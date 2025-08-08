
import 'operation_result.dart';

///  Function to parse API response and return an OperationResult
OperationResult parseResponse(Map<String, dynamic> r) {
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
}
