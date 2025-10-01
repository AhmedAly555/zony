import 'dart:convert';
import 'package:http/http.dart' as http;

import 'base_api_service.dart';
import 'token_storage.dart';

/// ApiService is the main service that talks to your backend.
/// It extends BaseApiService to reuse common request logic.
/// Responsible for authentication (login/logout/refresh) and requests with tokens.
class ApiService extends BaseApiService {
  ApiService() : super(baseUrl: "http://149.104.71.115:8000");

  /// Tokens (cached in memory for faster access)
  String? _accessToken;
  String? _refreshToken;

  /// Save tokens in memory + SharedPreferences
  Future<void> setTokens(String accessToken, String refreshToken) async {
    _accessToken = accessToken;
    _refreshToken = refreshToken;
    await TokenStorage.saveTokens(
      accessToken: accessToken,
      refreshToken: refreshToken,
    );
  }

  /// Load tokens from SharedPreferences (e.g., on app start)
  Future<void> loadTokens() async {
    _accessToken = await TokenStorage.getAccessToken();
    _refreshToken = await TokenStorage.getRefreshToken();
  }

  /// Clear tokens (in memory + SharedPreferences)
  Future<void> clearTokens() async {
    _accessToken = null;
    _refreshToken = null;
    await TokenStorage.clearTokens();
  }

  /// Login to the system and get tokens
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

      /// Save access & refresh tokens
      await setTokens(data['access_token'], data['refresh_token']);

      return data;
    } else {
      throw Exception("Login failed: ${response.body}");
    }
  }

  /// Logout user (invalidate session on server)
  Future<void> logout() async {
    final url = Uri.parse('$baseUrl/auth/logout');

    final response = await http.post(
      url,
      headers: _authorizedHeaders(),
    );

    if (response.statusCode == 200) {
      await clearTokens();
    } else {
      throw Exception("Logout failed: ${response.body}");
    }
  }

  /// Refresh the access token using refresh token
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

      /// Update only the access token
      _accessToken = data['access_token'];

      /// Save new token to storage
      await TokenStorage.saveTokens(
        accessToken: _accessToken!,
        refreshToken: _refreshToken!,
      );
    } else {
      throw Exception("Refresh failed: ${response.body}");
    }
  }

  /// Helper: Authorized headers with access token
  Map<String, String> _authorizedHeaders() {
    if (_accessToken == null) {
      throw Exception("No access token set, please login first.");
    }
    return {
      "Content-Type": "application/json",
      "Authorization": "Bearer $_accessToken",
    };
  }

  /// Example of GET request with token handling
  Future<Map<String, dynamic>> getData(String endpoint) async {
    final url = Uri.parse('$baseUrl/$endpoint');

    var response = await http.get(url, headers: _authorizedHeaders());

    if (response.statusCode == 401) {
      /// Token expired → try refresh
      await refreshAccessToken();

      /// Retry request with new token
      response = await http.get(url, headers: _authorizedHeaders());
    }

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Request failed: ${response.body}");
    }
  }

  /// Example of POST request with token handling
  Future<Map<String, dynamic>> postData(
      String endpoint, Map<String, dynamic> body) async {
    final url = Uri.parse('$baseUrl/$endpoint');

    var response = await http.post(
      url,
      headers: _authorizedHeaders(),
      body: jsonEncode(body),
    );

    if (response.statusCode == 401) {
      /// Token expired → try refresh
      await refreshAccessToken();

      /// Retry request with new token
      response = await http.post(
        url,
        headers: _authorizedHeaders(),
        body: jsonEncode(body),
      );
    }

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Request failed: ${response.body}");
    }
  }
}
