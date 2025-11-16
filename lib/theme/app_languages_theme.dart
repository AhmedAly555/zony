import 'package:flutter/material.dart';

class AppTheme {
  static final ThemeData arabicTheme = ThemeData(
    fontFamily: 'Cairo',
    colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFF49159B)),
    scaffoldBackgroundColor: const Color(0xFFF4F4F4),
  );

  static final ThemeData englishTheme = ThemeData(
    fontFamily: 'Poppins',
    colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFF49159B)),
    scaffoldBackgroundColor: const Color(0xFFF4F4F4),
  );
}
