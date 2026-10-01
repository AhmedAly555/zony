import 'dart:io';

import 'package:url_launcher/url_launcher.dart';

/// Opens [latitude],[longitude] in the user's map app: a `geo:` intent on
/// Android (the system lets the user pick the app), Apple Maps on iOS.
/// Returns false for missing (null/0) coordinates or when nothing can open it.
Future<bool> openInMapsApp({
  required double? latitude,
  required double? longitude,
  String? label,
}) async {
  if (latitude == null || longitude == null) {
    return false;
  }

  if (latitude == 0 || longitude == 0) {
    return false;
  }

  // launchUrl reports "no handler" as false; canLaunchUrl would need a
  // <queries> manifest entry per scheme on Android 11+.
  try {
    return await launchUrl(
      _mapsUri(latitude, longitude, label),
      mode: LaunchMode.externalApplication,
    );
  } catch (_) {
    return false;
  }
}

Uri _mapsUri(double latitude, double longitude, String? label) {
  final coordinates = '$latitude,$longitude';
  final name = label ?? '';

  if (Platform.isIOS) {
    return Uri.https('maps.apple.com', '/', {
      'll': coordinates,
      'q': name.isEmpty ? coordinates : name,
    });
  }

  // The label sits inside "(...)", so parentheses in it must be escaped too.
  final encodedName = Uri.encodeComponent(name)
      .replaceAll('(', '%28')
      .replaceAll(')', '%29');
  final query = name.isEmpty ? coordinates : '$coordinates($encodedName)';
  return Uri.parse('geo:$coordinates?q=$query');
}
