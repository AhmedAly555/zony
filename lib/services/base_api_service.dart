import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

/// Simple exception wrapper for HTTP errors.
/// It carries statusCode, a human message and the original response body.
class ApiException implements Exception {
  final int statusCode;
  final String message;
  final dynamic body;

  ApiException(this.statusCode, this.message, [this.body]);

  @override
  String toString() => 'ApiException($statusCode): $message';
}

/// BaseApiService
/// - Handles GET / POST (JSON) / PATCH (JSON) / PATCH (multipart) using dart:io HttpClient
/// - Adds Authorization header automatically when token is set
/// - Throws ApiException on non-2xx responses
class BaseApiService {
  final String baseUrl;
  Duration timeout;
  String? _authToken;

  /// Create an instance with a baseUrl (e.g. "http://149.104.71.115:5000")
  /// Optionally pass an authToken now or set it later via setAuthToken().
  BaseApiService({
    required this.baseUrl,
    this.timeout = const Duration(seconds: 15),
    String? authToken,
  }) {
    _authToken = authToken;
  }

  /// Set the authorization token (for example: a JWT).
  /// When set, every request will include: Authorization: Bearer <token>
  void setAuthToken(String token) => _authToken = token;

  /// Clear stored token (useful for logout).
  void clearAuthToken() => _authToken = null;

  /// Build default headers for requests. You can pass extra headers per-request.
  Map<String, String> _defaultHeaders([Map<String, String>? extra]) {
    final headers = <String, String>{
      'Accept': 'application/json',
      'Content-Type': 'application/json; charset=utf-8',
    };

    // If a token is present, add Authorization header here.
    if (_authToken != null && _authToken!.isNotEmpty) {
      headers['Authorization'] = 'Bearer $_authToken';
    }

    if (extra != null) headers.addAll(extra);
    return headers;
  }

  /// Ensure base URL and path are concatenated correctly.
  String _normalizeBase() {
    return baseUrl.endsWith('/') ? baseUrl.substring(0, baseUrl.length - 1) : baseUrl;
  }

  /// Build Uri from path and optional query parameters.
  Uri _buildUri(String path, [Map<String, dynamic>? queryParameters]) {
    final normalizedPath = path.startsWith('/') ? path : '/$path';
    final base = _normalizeBase();
    final uri = Uri.parse('$base$normalizedPath');

    if (queryParameters == null || queryParameters.isEmpty) return uri;

    final qp = <String, String>{};
    queryParameters.forEach((k, v) {
      if (v != null) qp[k] = v.toString();
    });
    return uri.replace(queryParameters: qp);
  }

  void _applyHeaders(HttpClientRequest request, Map<String, String> headers) {
    headers.forEach((k, v) => request.headers.set(k, v));
  }

  /// Process response body and throw ApiException for non-2xx statuses.
  Future<dynamic> _processResponse(HttpClientResponse response, String body) async {
    final status = response.statusCode;
    final contentType = response.headers.contentType?.mimeType ?? '';
    dynamic parsed;

    if (body.isNotEmpty && contentType.contains('application/json')) {
      try {
        parsed = json.decode(body);
      } catch (e) {
        parsed = body;
      }
    } else {
      parsed = body;
    }

    if (status >= 200 && status < 300) {
      return parsed;
    } else {
      String message = 'HTTP $status';
      if (parsed is Map && parsed['message'] != null) {
        message = parsed['message'].toString();
      } else if (parsed is String && parsed.isNotEmpty) {
        message = parsed;
      }
      throw ApiException(status, message, parsed);
    }
  }

  /// HTTP GET
  Future<dynamic> get(String path, {Map<String, dynamic>? queryParameters, Map<String, String>? extraHeaders}) async {
    final client = HttpClient();
    try {
      final uri = _buildUri(path, queryParameters);
      final request = await client.getUrl(uri).timeout(timeout);
      final headers = _defaultHeaders(extraHeaders);
      _applyHeaders(request, headers);
      final response = await request.close().timeout(timeout);
      final body = await utf8.decoder.bind(response).join();
      return await _processResponse(response, body);
    } on SocketException catch (e) {
      throw ApiException(-1, 'No Internet connection', e.toString());
    } on TimeoutException catch (e) {
      throw ApiException(-1, 'Request timeout', e.toString());
    } finally {
      client.close(force: true);
    }
  }

  /// HTTP POST with JSON body
  Future<dynamic> postJson(String path, Map<String, dynamic> jsonBody, {Map<String, String>? extraHeaders}) async {
    final client = HttpClient();
    try {
      final uri = _buildUri(path);
      final request = await client.postUrl(uri).timeout(timeout);
      final headers = _defaultHeaders(extraHeaders);
      _applyHeaders(request, headers);
      request.headers.set(HttpHeaders.contentTypeHeader, 'application/json; charset=utf-8');
      request.write(json.encode(jsonBody));
      final response = await request.close().timeout(timeout);
      final body = await utf8.decoder.bind(response).join();
      return await _processResponse(response, body);
    } finally {
      client.close(force: true);
    }
  }

  /// HTTP PATCH with JSON body
  Future<dynamic> patchJson(String path, Map<String, dynamic> jsonBody, {Map<String, String>? extraHeaders}) async {
    final client = HttpClient();
    try {
      final uri = _buildUri(path);
      // HttpClient doesn't have patchUrl, so use openUrl with method 'PATCH'
      final request = await client.openUrl('PATCH', uri).timeout(timeout);
      final headers = _defaultHeaders(extraHeaders);
      _applyHeaders(request, headers);
      request.headers.set(HttpHeaders.contentTypeHeader, 'application/json; charset=utf-8');
      request.write(json.encode(jsonBody));
      final response = await request.close().timeout(timeout);
      final body = await utf8.decoder.bind(response).join();
      return await _processResponse(response, body);
    } finally {
      client.close(force: true);
    }
  }

  /// HTTP PATCH with multipart/form-data (for uploading files/images)
  ///
  /// - fields: simple string form fields (e.g. {'status': 'waiting_confirmation'})
  /// - fileBytes: bytes of the file to upload (required)
  /// - fileField: the form name for the file (e.g. 'pudo_image', 'warehouse_image')
  /// - filename: the filename reported to the server (e.g. 'photo.jpg')
  /// - contentType: mime type of the file (e.g. 'image/jpeg')
  Future<dynamic> patchMultipart(
      String path, {
        Map<String, String>? fields,
        Uint8List? fileBytes,
        String fileField = 'file',
        String filename = 'image.jpg',
        String contentType = 'application/octet-stream',
        Map<String, String>? extraHeaders,
      }) async {
    if (fileBytes == null) {
      throw ArgumentError('fileBytes must be provided for multipart upload');
    }

    final client = HttpClient();
    try {
      final uri = _buildUri(path);
      final boundary = '----dart-http-boundary-${DateTime.now().millisecondsSinceEpoch}';

      // Build multipart payload: header + file bytes + footer
      final sb = StringBuffer();
      fields?.forEach((key, value) {
        sb.write('--$boundary\r\n');
        sb.write('Content-Disposition: form-data; name="$key"\r\n\r\n');
        sb.write('$value\r\n');
      });

      sb.write('--$boundary\r\n');
      sb.write('Content-Disposition: form-data; name="$fileField"; filename="$filename"\r\n');
      sb.write('Content-Type: $contentType\r\n\r\n');

      final headerBytes = utf8.encode(sb.toString());
      final footer = '\r\n--$boundary--\r\n';
      final footerBytes = utf8.encode(footer);

      final contentLength = headerBytes.length + fileBytes.length + footerBytes.length;

      final request = await client.openUrl('PATCH', uri).timeout(timeout);
      final headers = _defaultHeaders(extraHeaders);
      // override Content-Type for multipart
      headers[HttpHeaders.contentTypeHeader] = 'multipart/form-data; boundary=$boundary';
      headers[HttpHeaders.contentLengthHeader] = contentLength.toString();
      _applyHeaders(request, headers);

      // write bytes
      request.add(headerBytes);
      request.add(fileBytes);
      request.add(footerBytes);

      final response = await request.close().timeout(timeout);
      final body = await utf8.decoder.bind(response).join();
      return await _processResponse(response, body);
    } finally {
      client.close(force: true);
    }
  }

  /// Debug helper to show a fully built URL (path + query params)
  String buildDebugUrl(String path, [Map<String, dynamic>? queryParameters]) {
    return _buildUri(path, queryParameters).toString();
  }
}
