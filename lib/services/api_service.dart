import 'dart:convert';
import 'package:http/http.dart' as http;

import 'base_api_service.dart';
import 'shered_preferences/profile_storage.dart';
import 'shered_preferences/token_storage.dart';

class ApiService extends BaseApiService {
  // ---------------- Singleton ----------------
  static final ApiService _instance = ApiService._internal();
  factory ApiService() => _instance;
  ApiService._internal() : super(baseUrl: "http://149.104.71.115:8000") {
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
  Future<Map<String, dynamic>> login(String email, String password) async {
    final url = Uri.parse('$baseUrl/auth/login');

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "email": email,
        "password": password,
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

  Future<void> logout() async {
    final url = Uri.parse('$baseUrl/auth/logout');
    final response = await http.post(url, headers: _authorizedHeaders());

    if (response.statusCode == 200) {
      await clearTokens();
    } else {
      throw Exception("Logout failed: ${response.body}");
    }
  }

  Future<void> refreshAccessToken() async {
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

    final headers = {
      ..._authorizedHeaders(),
      if (extraHeaders != null) ...extraHeaders,
    };

    http.Response response = await _makeRequest(method, uri, body, headers);

    if (response.statusCode == 401) {
      await refreshAccessToken();
      response = await _makeRequest(method, uri, body, headers);
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

/*
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'base_api_service.dart';
import 'shered_preferences/profile_storage.dart';
import 'shered_preferences/token_storage.dart';

class ApiService extends BaseApiService {
  // ---------------- Singleton ----------------
  static final ApiService _instance = ApiService._internal();
  factory ApiService() => _instance;
  ApiService._internal() : super(baseUrl: "http://149.104.71.115:8000");

  static ApiService get instance => _instance;

  // ---------------- Tokens ----------------
  String? _accessToken;
  String? _refreshToken;

  Future<void> setTokens(String accessToken, String refreshToken) async {
    _accessToken = accessToken;
    _refreshToken = refreshToken;
    await TokenStorage.saveTokens(
      accessToken: accessToken,
      refreshToken: refreshToken,
    );
  }

  Future<void> loadTokens() async {
    _accessToken = await TokenStorage.getAccessToken();
    _refreshToken = await TokenStorage.getRefreshToken();
  }

  Future<void> clearTokens() async {
    _accessToken = null;
    _refreshToken = null;
    await TokenStorage.clearTokens();
  }

  // ---------------- Auth APIs ----------------
  Future<Map<String, dynamic>> login(String email, String password) async {
    final url = Uri.parse('$baseUrl/auth/login');

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "email": email,
        "password": password,
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

  Future<void> logout() async {
    final url = Uri.parse('$baseUrl/auth/logout');
    final response = await http.post(url, headers: _authorizedHeaders());

    if (response.statusCode == 200) {
      await clearTokens();
    } else {
      throw Exception("Logout failed: ${response.body}");
    }
  }

  Future<void> refreshAccessToken() async {
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

    final headers = {
      ..._authorizedHeaders(),
      if (extraHeaders != null) ...extraHeaders,
    };

    http.Response response = await _makeRequest(method, uri, body, headers);

    if (response.statusCode == 401) {
      await refreshAccessToken();
      response = await _makeRequest(method, uri, body, headers);
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
      }) {
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
      }) {
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
      }) {
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
*/
