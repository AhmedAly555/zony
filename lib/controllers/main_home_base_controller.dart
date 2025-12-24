import 'package:flutter/material.dart';

class MainHomeBaseController {
  final ValueNotifier<int> currentTabIndex = ValueNotifier<int>(0);

  void changeTab(int index) {
    currentTabIndex.value = index;
  }

  void reset() {
    currentTabIndex.value = 0;
  }
}
