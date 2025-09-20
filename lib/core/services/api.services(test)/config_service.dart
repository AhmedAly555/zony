import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConfigService {
  static SharedPreferences? _preferences;

  /// Initialize SharedPreferences instance
  static Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();
    _preferences ??= await SharedPreferences.getInstance();
  }

  /// Access Token
  static String get token => _getValueString('token');
  static set token(String value) => _setValueString('token', value);

  /// Refresh Token
  static String get refreshToken => _getValueString('refreshToken');
  static set refreshToken(String value) => _setValueString('refreshToken', value);

  /// Access Token Expiration Date
  static int get accessTokenExpDate => _getValueInt('accessTokenExpDate');
  static set accessTokenExpDate(int value) =>
      _setValueInt('accessTokenExpDate', value);
  static DateTime? get accessTokenExpDateTime =>
      accessTokenExpDate == 0 ? null : DateTime.fromMillisecondsSinceEpoch(accessTokenExpDate);
  static set accessTokenExpDateTime(DateTime? dateTime) =>
      _setValueInt('accessTokenExpDate', dateTime?.millisecondsSinceEpoch ?? 0);

  /// Refresh Token Expiration Date
  static int get refreshTokenExpDate => _getValueInt('refreshTokenExpDate');
  static set refreshTokenExpDate(int value) =>
      _setValueInt('refreshTokenExpDate', value);
  static DateTime? get refreshTokenExpDateTime =>
      refreshTokenExpDate == 0 ? null : DateTime.fromMillisecondsSinceEpoch(refreshTokenExpDate);
  static set refreshTokenExpDateTime(DateTime? dateTime) =>
      _setValueInt('refreshTokenExpDate', dateTime?.millisecondsSinceEpoch ?? 0);

  /// Is User Logged In
  static bool get isLogin => _getValueBool('is_login');
  static set isLogin(bool value) => _setValueBool('is_login', value);

  /// General Getters/Setters
  static String _getValueString(String key) =>
      _preferences?.getString(key) ?? '';

  static int _getValueInt(String key) =>
      _preferences?.getInt(key) ?? 0;

  static bool _getValueBool(String key) =>
      _preferences?.getBool(key) ?? false;

  static Future<void> _setValueString(String key, String? value) async {
    if (_preferences == null) await init();
    if (value == null) {
      await _preferences?.remove(key);
    } else {
      await _preferences?.setString(key, value);
    }
  }

  static Future<void> _setValueInt(String key, int value) async {
    if (_preferences == null) await init();
    await _preferences?.setInt(key, value);
  }

  static Future<void> _setValueBool(String key, bool value) async {
    if (_preferences == null) await init();
    await _preferences?.setBool(key, value);
  }

  static Future<void> clearAll() async {
    await _preferences?.clear();
  }

  static bool checkValueExist(String key) {
    return _preferences?.containsKey(key) ?? false;
  }
}
