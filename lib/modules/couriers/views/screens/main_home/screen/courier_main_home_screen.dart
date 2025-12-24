import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:zony/generated/l10n.dart';

import '../../../../../../controllers/courier_main_home_controller.dart';
import '../../../../../../views/widgets/template_app_scaffold.widget.dart';
import '../../../../../couriers/views/screens/main_home/screen/courier_delivering_screen.dart';
import '../../../../../couriers/views/screens/main_home/screen/courier_home.screen.dart';
import '../../../../../couriers/views/screens/main_home/screen/courier_more.screen.dart';
import '../../../../../couriers/views/screens/main_home/screen/courier_receiving_screen.dart';

class CourierMainHomeScreen extends StatefulWidget {
  const CourierMainHomeScreen({super.key});

  @override
  State<CourierMainHomeScreen> createState() => _CourierMainHomeScreenState();
}

class _CourierMainHomeScreenState extends State<CourierMainHomeScreen> {
  DateTime? _lastPressedAt;

  final List<Widget> _screens = [
    const CourierHomeScreen(),
    const CourierReceivingScreen(),
    const CourierDeliveringScreen(),
    const CourierMoreScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final controller = CourierMainHomeController.instance;

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
