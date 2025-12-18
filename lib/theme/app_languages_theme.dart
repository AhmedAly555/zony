import 'package:flutter/material.dart';

import 'app_colors.theme.dart';

class AppTheme {
  static final ThemeData arabicTheme = ThemeData(
    fontFamily: 'Cairo',
    colorScheme: ColorScheme.fromSeed(seedColor: AppColors.zonyPrimary),
    scaffoldBackgroundColor: AppColors.zonyBackground,
  );

  static final ThemeData englishTheme = ThemeData(
    fontFamily: 'Poppins',
    colorScheme: ColorScheme.fromSeed(seedColor: AppColors.zonyPrimary),
    scaffoldBackgroundColor: AppColors.zonyBackground,
  );
}
