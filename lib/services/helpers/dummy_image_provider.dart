import 'package:flutter/services.dart';

class DummyImageProvider {
  static Future<Uint8List> loadParcelPlaceholder() async {
    final bytes = await rootBundle.load(
      'assets/images/zony-logo.png',
    );
    return bytes.buffer.asUint8List();
  }
}
