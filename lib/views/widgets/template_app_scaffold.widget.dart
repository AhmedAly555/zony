import 'package:flutter/material.dart';

import '../../services/size_config.dart';
import 'default_navigation_bar.widget.dart';
class TemplateAppScaffold extends StatelessWidget {
  final Widget body;
  final bool showBottomNavBar;
  final int? currentIndex;
  final Function(int)? onNavTap;

  const TemplateAppScaffold({
    super.key,
    required this.body,
    this.showBottomNavBar = true,
    this.currentIndex,
    this.onNavTap,
  });

  @override
  Widget build(BuildContext context) {
    // SizeConfig.init(context);

    return Scaffold(
      backgroundColor: const Color(0xFFF4F4F4),

      body: SafeArea(child: body),
      bottomNavigationBar: showBottomNavBar && currentIndex != null && onNavTap != null
          ? DefaultNavigationBar(
        currentIndex: currentIndex!,
        onTap: onNavTap!,
      )
          : null,
    );
  }
}

