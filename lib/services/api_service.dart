import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:zony/modules/auth/screens/login_screen.dart';

import 'base_api_service.dart';
import 'navigator.services/navigation_service.dart';
import 'shered_preferences/profile_storage.dart';
import 'shered_preferences/token_storage.dart';

class ApiService extends BaseApiService {
  // ---------------- Singleton ----------------
  static final ApiService _instance = ApiService._internal();
  factory ApiService() => _instance;
  ApiService._internal() : super(baseUrl: "https://api.zony.sa") {
    // Load tokens automatically on instance creation
    loadTokens();
  }

  static ApiService get instance => _instance;

  // ---------------- Tokens ----------------
  String? _accessToken;
  String? _refreshToken;

  Future<void> setTokens(String accessToken, String refreshToken) async {
    _accessToken = accessToken;
    _refreshToken = refreshToken;
    // Link to base for headers to benefit
    setAuthToken(accessToken);
    await TokenStorage.saveTokens(
      accessToken: accessToken,
      refreshToken: refreshToken,
    );
  }

  Future<void> loadTokens() async {
    _accessToken = await TokenStorage.getAccessToken();
    _refreshToken = await TokenStorage.getRefreshToken();
    // Link to base
    if (_accessToken != null) {
      setAuthToken(_accessToken!);
    }
  }

  Future<void> clearTokens() async {
    _accessToken = null;
    _refreshToken = null;
    clearAuthToken();
    await TokenStorage.clearTokens();
  }

  // ---------------- Auth APIs ----------------
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
      await setTokens(data['access_token'], data['refresh_token']);
      return data;
    } else {
      throw Exception("Login failed: ${response.body}");
    }
  }

  // ---------------- Logout API ----------------
  Future<void> logout() async {
    final url = Uri.parse('$baseUrl/auth/logout');
    final response = await http.post(url, headers: _authorizedHeaders());

    if (response.statusCode == 200) {
      await clearTokens();
    } else {
      throw Exception("Logout failed: ${response.body}");
    }
  }

  /*Future<void> refreshAccessToken() async {
    if (_refreshToken == null) {
      throw Exception("No refresh token found, user must login again.");
    }

    final url = Uri.parse('$baseUrl/auth/refresh');

    final response = await http.get(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $_refreshToken",
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      _accessToken = data['access_token'];

      await TokenStorage.saveTokens(
        accessToken: _accessToken!,
        refreshToken: _refreshToken!,
      );
    } else {
      throw Exception("Refresh failed: ${response.body}");
    }
  }*/

  // ---------------- Refresh Token API ----------------
  Future<void> refreshAccessToken() async {
    if (_refreshToken == null) {
      // If there is no Refresh Token, we ask the user to log in again
      await clearUserData();
      throw Exception("No refresh token found, user must login again.");
    }

    // endpoint (post)
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
      if (newAccessToken != null) {
        // 1. Replace the old Access Token with the new one
        _accessToken = newAccessToken;
        setAuthToken(_accessToken!); // Update the token in the Base Service

        // 2. Update the storage
        // We use the new Access Token and keep the old Refresh Token
        await TokenStorage.saveTokens(
          accessToken: _accessToken!,
          refreshToken: _refreshToken!,
        );
      } else {
        throw Exception("Refresh failed: Access Token missing in response.");
      }
    } else {
      final responseBody = jsonDecode(response.body);
      if (responseBody['msg'] == 'Token has expired') {
        await clearUserData();
        // Navigate to login screen
        NavigationService.navigatorKey.currentState?.pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const LoginScreen()),
              (route) => false,
        );
        throw Exception("Refresh token expired. Please log in again.");
      }
      // If the update fails (perhaps the refresh token has expired), we log out
      await clearTokens();
      throw Exception("Refresh failed: ${response.body}. Please log in again.");
    }
  }


  // ---------------- Helpers ----------------
  Map<String, String> _authorizedHeaders() {
    if (_accessToken == null) {
      throw Exception("No access token set, please login first.");
    }
    return {
      "Content-Type": "application/json",
      "Authorization": "Bearer $_accessToken",
    };
  }

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

    http.Response response = await _makeRequest(method, uri, body, {
      ..._authorizedHeaders(),
      if (extraHeaders != null) ...extraHeaders,
    });

    if (response.statusCode == 401) {
      await refreshAccessToken();
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
    // Before request, if token not loaded, load it (fallback)
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

  //clear tokens + profile data => logout
  static Future<void> clearUserData() async {
    await TokenStorage.clearTokens();
    await ProfileStorage.clearProfile();
  }
}
