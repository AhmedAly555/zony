import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/profile_model.dart';

/// Handles saving, loading and clearing user profile data locally
class ProfileStorage {
  static const _keyProfile = 'user_profile';

  /// Save profile as JSON string in SharedPreferences
  static Future<void> saveProfile(Profile profile) async {
    final prefs = await SharedPreferences.getInstance();
    final profileJson = jsonEncode(profile.toJson());
    await prefs.setString(_keyProfile, profileJson);
  }

  /// Load profile from SharedPreferences (if available)
  static Future<Profile?> getProfile() async {
    final prefs = await SharedPreferences.getInstance();
    final profileJson = prefs.getString(_keyProfile);
    if (profileJson == null) return null;

    try {
      final map = jsonDecode(profileJson);
      return Profile.fromJson(map);
    } catch (_) {
      return null;
    }
  }

  /// Clear saved profile (useful for logout)
  static Future<void> clearProfile() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keyProfile);
  }
}
