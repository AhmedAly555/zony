import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:zony/generated/l10n.dart';

import '../../../../../../controllers/pudu_main_home_controller.dart';
import '../../../../../../views/widgets/template_app_scaffold.widget.dart';
import '../../../../Recieve/parcel_approve_screen.dart';
import 'podu_delivering_screen.dart';
import 'podu_home_screen.dart';
import 'podu_more.screen.dart';

class PoduMainHomeScreen extends StatefulWidget {
  const PoduMainHomeScreen({super.key});

  @override
  State<PoduMainHomeScreen> createState() => _PoduMainHomeScreenState();
}

class _PoduMainHomeScreenState extends State<PoduMainHomeScreen> {
  DateTime? _lastPressedAt;

  final List<Widget> _screens = [
    const PoduHomeScreen(),
    const ParcelApproveScreen(),
    const PoduDeliveringScreen(),
    const PoduMoreScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final controller = PuduMainHomeController.instance;

    return ValueListenableBuilder<int>(
      valueListenable: controller.currentTabIndex,
      builder: (context, selectedIndex, _) {
        return WillPopScope(
          onWillPop: () async {
            if (selectedIndex != 0) {
              controller.changeTab(0);
              return false; // Prevent default back behavior
            }

            final now = DateTime.now();
            final didPop = _lastPressedAt == null ||
                now.difference(_lastPressedAt!) > const Duration(seconds: 2);

            if (didPop) {
              _lastPressedAt = now;
              Fluttertoast.showToast(
                msg: S.of(context).pressBackAgainToExit,
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                backgroundColor: Colors.black54,
                textColor: Colors.white,
              );
              return false; // Prevent app from exiting
            }
            return true; // Allow app to exit
          },
          child: TemplateAppScaffold(
            body: IndexedStack(
              index: selectedIndex,
              children: _screens,
            ),
            showBottomNavBar: true,
            currentIndex: selectedIndex,
            onNavTap: controller.changeTab,
          ),
        );
      },
    );
  }
}
