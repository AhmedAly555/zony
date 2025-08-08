
import 'package:flutter/material.dart';

class OperationResult<T> {
  bool success;
  T? data;
  String? message;
  Map<String, dynamic>? multiMessage;
  String? minVersion;
  String? lastVersion;
  String? innerError;
  String? errorCodeString;
  int? count;
  List<String>? features;

  OperationResult({
    this.success = false,
    this.data,
    this.message,
    this.multiMessage,
    this.errorCodeString,
    this.minVersion,
    this.lastVersion,
    this.innerError,
    this.count,
    this.features,
  });

  ///  Show message in a dialog (you can customize this later)
  Future<void> showMessage(BuildContext context, [String? generalMessage]) async {
    final snackBar = SnackBar(
      content: Text(message ?? generalMessage ?? ''),
      backgroundColor: success ? Colors.green : Colors.red,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  /// 🧾 Override toString to log result
  @override
  String toString() {
    if (success == true) {
      return '✅ Success, Message: $message, Inner: $innerError';
    } else {
      return '❌ FAILED, Message: $message, Inner: $innerError';
    }
  }
}
