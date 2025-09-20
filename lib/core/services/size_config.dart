import 'package:flutter/material.dart';

class SizeConfig {
  static late MediaQueryData _mediaQueryData;
  static late double screenWidth;
  static late double screenHeight;

  static void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
  }

  static double heightPercent(double percent) {
    return screenHeight * percent;
  }

  static double widthPercent(double percent) {
    return screenWidth * percent;
  }
}
