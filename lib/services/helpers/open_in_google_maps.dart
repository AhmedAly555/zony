import 'package:url_launcher/url_launcher.dart';

Future<bool> openInGoogleMaps({
  required double? latitude,
  required double? longitude,
}) async {
  // 1️⃣ null check
  if (latitude == null || longitude == null) {
    return false;
  }

  // 2️⃣ invalid coordinates check (0,0)
  if (latitude == 0 || longitude == 0) {
    return false;
  }

  final uri = Uri.parse(
    'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude',
  );

  try {
    if (!await canLaunchUrl(uri)) {
      return false;
    }

    return await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    );
  } catch (_) {
    return false;
  }
}
