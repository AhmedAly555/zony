import 'package:url_launcher/url_launcher.dart';

class TechnicalSupportService {
  static Future<bool> openChat({
    required String phoneNumber,
    String? message,
  }) async {
    final Uri uri = Uri.parse(
      'https://wa.me/$phoneNumber?text=${Uri.encodeComponent(message ?? '')}',
    );

    try {
      if (await canLaunchUrl(uri)) {
        await launchUrl(
          uri,
          mode: LaunchMode.externalApplication,
        );
        return true;
      }
      return false;
    } catch (_) {
      return false;
    }
  }
}
