import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:zony/modules/auth/view/widgets/login_cubit_route.dart';

import 'base_api_service.dart';
import 'navigator.services/navigation_service.dart';
import 'shered_preferences/profile_storage.dart';
import 'shered_preferences/token_storage.dart';

class ApiService extends BaseApiService {
  // ---------------- Singleton ----------------
  static final ApiService _instance = ApiService._internal();
  factory ApiService() => _instance;
  ApiService._internal() : super(baseUrl: "https://api.zony.sa") {
    // Load tokens and role automatically on instance creation
    loadTokens();
  }

  static ApiService get instance => _instance;

  // ---------------- State Variables (Tokens & Role) ----------------
  String? _accessToken;
  String? _refreshToken;
  String? _role;

  String? get role => _role;
  
  // Locking mechanism for refresh token to prevent multiple refreshes at once
  Completer<void>? _refreshCompleter;

  // ---------------- Token Management ----------------
  Future<void> setTokens(String accessToken, String refreshToken, String role) async {
    _accessToken = accessToken;
    _refreshToken = refreshToken;
    _role = role;

    setAuthToken(accessToken);
    await TokenStorage.saveTokens(
      accessToken: accessToken,
      refreshToken: refreshToken,
      role: role,
    );
  }

  Future<void> loadTokens() async {
    _accessToken = await TokenStorage.getAccessToken();
    _refreshToken = await TokenStorage.getRefreshToken();
    _role = await TokenStorage.getRole();

    if (_accessToken != null) {
      setAuthToken(_accessToken!);
    }
  }

  Future<void> clearTokens() async {
    _accessToken = null;
    _refreshToken = null;
    _role = null;
    clearAuthToken();
    await TokenStorage.clearTokens();
  }

  // ---------------- Auth APIs (Login) ----------------
  Future<Map<String, dynamic>> login(String email, String password, bool rememberMe) async {
    final url = Uri.parse('$baseUrl/auth/login');

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "email": email,
        "password": password,
        "remember_me": rememberMe ? 1 : 0,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final role = data['user']['role'] as String;
      await setTokens(data['access_token'], data['refresh_token'], role);
      return data;
    } else {
      throw Exception("Login failed: ${response.body}");
    }
  }

  // ---------------- Logout API ----------------
  Future<void> logout() async {
    final url = Uri.parse('$baseUrl/auth/logout');
    try {
       final response = await http.post(url, headers: _authorizedHeaders());
       if (response.statusCode != 200) {
         debugPrint("Logout API warning: ${response.body}");
       }
    } catch (e) {
      debugPrint("Logout API error: $e");
    } finally {
      // Clear tokens locally regardless of API success
      await clearTokens();
    }
  }
  
  // ---------------- Refresh Token Logic ----------------
  Future<void> refreshAccessToken() async {
    if (_refreshToken == null) {
      await clearUserData();
      throw Exception("No refresh token found, user must login again.");
    }

    // Endpoint for refreshing token
    final url = Uri.parse('$baseUrl/auth/refresh');

    final response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $_refreshToken",
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      final newAccessToken = data['access_token'];
      // Check if server returned a new refresh token (Token Rotation)
      final newRefreshToken = data['refresh_token']; 

      if (newAccessToken != null) {
        _accessToken = newAccessToken;
        if (newRefreshToken != null) {
          _refreshToken = newRefreshToken;
        }
        
        setAuthToken(_accessToken!); // Update the token in the Base Service

        await TokenStorage.saveTokens(
          accessToken: _accessToken!,
          refreshToken: _refreshToken!,
          role: _role!, 
        );
      } else {
        throw Exception("Refresh failed: Access Token missing in response.");
      }
    } else {
      // Any error on REFRESH endpoint (401, 403, 400) usually means the refresh token itself is invalid.
      // So we should logout immediately.
      
      // We check if it's NOT a server error (5xx). If it's a server error, maybe we shouldn't logout yet?
      // But typically, if refresh fails, user experience is better if they just login again.
      
      await clearUserData();
      
      // Using NavigationService here is pragmatic to force logout.
      NavigationService.navigatorKey.currentState?.pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const LoginCubitRoute()),
            (route) => false,
      );
      
      throw Exception("Session expired. Please log in again.");
    }
  }


  // ---------------- API Request Helpers ----------------
  
  // Helper to generate headers with Bearer token if available
  Map<String, String> _authorizedHeaders() {
    final headers = <String, String>{
      "Content-Type": "application/json",
    };
    // If accessToken is null, we do not send Authorization header, 
    // expecting server to return 401 which triggers refresh logic.
    if (_accessToken != null) {
      headers["Authorization"] = "Bearer $_accessToken";
    }
    return headers;
  }

  // Wrapper for HTTP requests that handles 401 Unauthorized (Refresh Token)
  Future<Map<String, dynamic>> _sendRequest(
      String method,
      String endpoint, {
        Map<String, dynamic>? body,
        Map<String, String>? extraHeaders,
        Map<String, dynamic>? queryParameters,
      }) async {
    final uri = Uri.parse('$baseUrl/$endpoint').replace(
      queryParameters: queryParameters?.map((k, v) => MapEntry(k, v.toString())),
    );

    // Initial Headers
    var headers = {
      ..._authorizedHeaders(),
      if (extraHeaders != null) ...extraHeaders,
    };

    http.Response response = await _makeRequest(method, uri, body, headers);

    if (response.statusCode == 401) {
      // --- Handle Refresh Concurrency ---
      if (_refreshCompleter == null) {
        // Start a new refresh process
        _refreshCompleter = Completer<void>();
        try {
          await refreshAccessToken();
          _refreshCompleter!.complete();
        } catch (e) {
          _refreshCompleter!.completeError(e);
          // If refresh failed, we can't retry. Throw the error.
          rethrow;
        } finally {
          // Reset the completer so next time we start fresh.
          _refreshCompleter = null;
        }
      } else {
        // If a refresh is already happening, wait for it to finish
        await _refreshCompleter!.future;
      }

      // Re-run the request with the new token
      response = await _makeRequest(method, uri, body, {
        ..._authorizedHeaders(), // This will now use the new token
        if (extraHeaders != null) ...extraHeaders,
      });
    }

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Request failed [${response.statusCode}]: ${response.body}");
    }
  }

  // Low-level request executor
  Future<http.Response> _makeRequest(
      String method,
      Uri url,
      Map<String, dynamic>? body,
      Map<String, String> headers,
      ) {
    switch (method.toUpperCase()) {
      case 'GET':
        return http.get(url, headers: headers);
      case 'POST':
        return http.post(url, headers: headers, body: jsonEncode(body));
      case 'PUT':
        return http.put(url, headers: headers, body: jsonEncode(body));
      case 'PATCH':
        return http.patch(url, headers: headers, body: jsonEncode(body));
      case 'DELETE':
        return http.delete(url, headers: headers);
      default:
        throw Exception("Unsupported HTTP method: $method");
    }
  }

  // ---------- Overrides from BaseApiService ----------
  @override
  Future<dynamic> get(
      String path, {
        Map<String, String>? extraHeaders,
        Map<String, dynamic>? queryParameters,
      }) async {
    if (_accessToken == null) {
      await loadTokens();
    }
    return _sendRequest(
      "GET",
      path,
      extraHeaders: extraHeaders,
      queryParameters: queryParameters,
    );
  }

  @override
  Future<dynamic> postJson(
      String path,
      Map<String, dynamic> jsonBody, {
        Map<String, String>? extraHeaders,
      }) async {
    if (_accessToken == null) {
      await loadTokens();
    }
    return _sendRequest(
      "POST",
      path,
      body: jsonBody,
      extraHeaders: extraHeaders,
    );
  }

  @override
  Future<dynamic> patchJson(
      String path,
      Map<String, dynamic> jsonBody, {
        Map<String, String>? extraHeaders,
      }) async {
    if (_accessToken == null) {
      await loadTokens();
    }
    return _sendRequest(
      "PATCH",
      path,
      body: jsonBody,
      extraHeaders: extraHeaders,
    );
  }

  // ---------------- Global Logout Helper ----------------
  static Future<void> clearUserData() async {
    await TokenStorage.clearTokens();
    await ProfileStorage.clearProfile();
  }
}
