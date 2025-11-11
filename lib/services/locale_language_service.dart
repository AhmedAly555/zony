import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocaleLanguageService {
  // Singleton setup
  LocaleLanguageService._privateConstructor();
  static final LocaleLanguageService instance = LocaleLanguageService._privateConstructor();

  // ValueNotifier to hold the locale
  final ValueNotifier<Locale> localeNotifier = ValueNotifier(const Locale('en'));

  static const _languageCodeKey = 'languageCode';

  // Set the locale and notify listeners
  void setLocale(Locale locale) {
    localeNotifier.value = locale;
    _saveLocaleToPrefs(locale);
  }

  // Save locale to SharedPreferences
  Future<void> _saveLocaleToPrefs(Locale locale) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_languageCodeKey, locale.languageCode);
  }

  // Load locale from SharedPreferences
  Future<void> loadLocale() async {
    final prefs = await SharedPreferences.getInstance();
    final languageCode = prefs.getString(_languageCodeKey) ?? 'en'; // Default to English
    localeNotifier.value = Locale(languageCode);
  }
}
