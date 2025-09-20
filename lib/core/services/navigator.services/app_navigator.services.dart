import 'package:flutter/material.dart';

class AppNavigator {
  /// Navigates to a new screen using a widget constructor
  static void navigateTo(BuildContext context, Widget Function() screenBuilder) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => screenBuilder(),
      ),
    );
  }

  /// Navigates to a new screen and removes all previous routes
  static void navigateAndRemoveUntil(BuildContext context, Widget Function() screenBuilder) {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => screenBuilder(),
      ),
          (Route<dynamic> route) => false,
    );
  }

  /// Replaces the current screen with a new one
  static void replaceWith(BuildContext context, Widget Function() screenBuilder) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => screenBuilder(),
      ),
    );
  }

  /// Pops the current screen
  static void pop(BuildContext context) {
    Navigator.of(context).pop();
  }

  /// Pops until reaching the specified route
  static void popUntil(BuildContext context, String routeName) {
    Navigator.of(context).popUntil(ModalRoute.withName(routeName));
  }
}