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
      backgroundColor: Color(0xFFF4F4F4),

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


/*
import 'package:flutter/material.dart';
import 'package:tecfy_attendance_employee/widgets/default_appbar.widgets.dart';
import 'package:tecfy_attendance_employee/widgets/home_floating_button.widget.dart';
import 'package:tecfy_attendance_employee/widgets/navbar.widget.dart';

class TemplateWidget extends StatefulWidget {
  final Widget body;
  final bool hideNavBar;
  final bool hideAppBar;
  final PreferredSizeWidget? customAppBar;
  final String? defaultAppBarTitle;
  final int? sideMenuIndex;
  final void Function()? onPopCallback;

  const TemplateWidget(
      {super.key,
      required this.body,
      this.customAppBar,
      this.hideNavBar = false,
      this.hideAppBar = false,
      this.defaultAppBarTitle,
      this.sideMenuIndex,
      this.onPopCallback});

  @override
  State<TemplateWidget> createState() => _TemplateWidgetState();
}

class _TemplateWidgetState extends State<TemplateWidget> {


  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          floatingActionButton: widget.hideNavBar ? null : HomeFloatingButton(),
          floatingActionButtonLocation: widget.hideNavBar
              ? null
              : FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: widget.hideNavBar
              ? null
              : AppBottomNavBarWidget(sideMenuIndex: widget.sideMenuIndex),
          extendBody: true,
          drawer: Drawer(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            elevation: 1,
            child: DrawerWidget(),
          ),
          appBar: widget.hideAppBar
              ? null
              : widget.customAppBar ??
                  DefaultAppbar(
                    title: widget.defaultAppBarTitle ?? '',
                    withDrawerIcon: widget.withDrawerIcon,
                    onPopCallback: widget.onPopCallback,
                  ),
          body: GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 700),
                child: widget.body,
              )),
          // bottomNavigationBar: const AppBottomNavBarWidget(),
        )
      ],
    );
  }
}
*/
