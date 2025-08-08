/*




import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:zony/services/api.services/api_service_helper.dart';
import 'package:zony/services/api.services/config_service.dart';

import 'operation_result.dart';

class ApiService {
  /// 🔒 Custom encoder used when saving complex data to SharedPreferences
  static dynamic customEncode(dynamic item) {
    if (item is DateTime) {
      return item.toIso8601String();
    }
    return item;
  }

  ///  Main GET Request for dynamic responses
  Future<OperationResult> httpGetDynamic(
      String url, {
        Map<String, String>? header,
        bool checkOnTokenExpiration = true,
      }) async {
    final tokenCheck = await ApiServiceHelper.checkExpirationOfTokens(
      checkOnTokenExpiration: checkOnTokenExpiration,
    );
    if (!tokenCheck.success) return tokenCheck;

    final h = header ?? await getDefaultHeader();
    log("➡️ GET: $url");

    try {
      final response = await http.get(Uri.parse(url), headers: h);
      return parseResponse(response);
    } catch (e, s) {
      log("❌ GET Error", error: e, stackTrace: s);
      return OperationResult(success: false, message: e.toString());
    }
  }

  /// 🟢 Main POST Request (map body)
  Future<OperationResult> httpPost(
      String url,
      dynamic data, [
        Map<String, String>? header,
        bool asString = false,
        bool checkOnTokenExpiration = true,
      ]) async {
    final tokenCheck = await ApiServiceHelper.checkExpirationOfTokens(
      checkOnTokenExpiration: checkOnTokenExpiration,
    );
    if (!tokenCheck.success) return tokenCheck;

    final h = header ?? await getDefaultHeader();
    log("➡️ POST: $url\nBODY: $data");

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: h,
        body: json.encode(data),
      );
      return parseResponse(response);
    } catch (e, s) {
      log("❌ POST Error", error: e, stackTrace: s);
      return OperationResult(success: false, message: e.toString());
    }
  }

  /// 🔧 Helper to build default headers (Content-Type + Authorization)
  Future<Map<String, String>> getDefaultHeader() async {
    final token = ConfigService.token;
    return {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
  }

  /// 🧩 Parses the HTTP response into a standard OperationResult object
  OperationResult parseResponse(http.Response response) {
    try {
      final r = json.decode(response.body);

      return OperationResult(
        count: r.containsKey('count')
            ? (r['count'] is int)
            ? r['count']
            : int.tryParse('${r['count']}')
            : null,
        success: r['success'] is bool
            ? r['success']
            : r['success']?.toString() == "true",
        innerError: r['innerError']?.toString(),
        minVersion: r['minVersion']?.toString(),
        lastVersion: r['lastVersion']?.toString(),
        message: r['message'] is Map || r['message'] == null
            ? (r['messageAr'] ??
            r['errorString'] ??
            r['fullMessagesString'] ??
            r['errorCodeString'] ??
            'No Server Error!')
            : r['message'],
        data: r['data'],
        features: r['features'] != null
            ? (r['features'] as List<dynamic>).cast<String>().toList()
            : null,
        multiMessage: r['message'] is Map ? r['message'] : null,
        errorCodeString: r['errorCodeString']?.toString(),
      );
    } catch (e, s) {
      log("❌ Parse Error", error: e, stackTrace: s);
      return OperationResult(success: false, message: 'Parsing Error');
    }
  }
}
*/
