/*
import 'package:flutter/material.dart';

import '../../../../../../views/widgets/template_app_scaffold.widget.dart';
import '../../../../../couriers/views/screens/main_home/screen/courier_delivering_screen.dart';
import '../../../../../couriers/views/screens/main_home/screen/courier_home.screen.dart';
import '../../../../../couriers/views/screens/main_home/screen/courier_more.screen.dart';
import '../../../../../couriers/views/screens/main_home/screen/courier_receiving_screen.dart';

class CourierMainHomeScreen extends StatefulWidget {
  final int initialIndex;
  const CourierMainHomeScreen({super.key, this.initialIndex = 0});

  @override
  State<CourierMainHomeScreen> createState() => _CourierMainHomeScreenState();
}

class _CourierMainHomeScreenState extends State<CourierMainHomeScreen> {
  late int _selectedIndex;

  final List<Widget> _screens = [
    CourierHomeScreen(),
    const CourierReceivingScreen(),
    const CourierDeliveringScreen(),
    const CourierMoreScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TemplateAppScaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _screens,
      ),
      showBottomNavBar: true,
      currentIndex: _selectedIndex,
      onNavTap: _onItemTapped,
    );
  }
}
*/
import 'package:flutter/material.dart';

import '../../../../../../controllers/courier_main_home_controller.dart';
import '../../../../../../views/widgets/template_app_scaffold.widget.dart';
import '../../../../../couriers/views/screens/main_home/screen/courier_delivering_screen.dart';
import '../../../../../couriers/views/screens/main_home/screen/courier_home.screen.dart';
import '../../../../../couriers/views/screens/main_home/screen/courier_more.screen.dart';
import '../../../../../couriers/views/screens/main_home/screen/courier_receiving_screen.dart';

class CourierMainHomeScreen extends StatelessWidget {
  const CourierMainHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = CourierMainHomeController.instance;

    final List<Widget> screens = [
      CourierHomeScreen(),
      const CourierReceivingScreen(),
      const CourierDeliveringScreen(),
      const CourierMoreScreen(),
    ];

    return ValueListenableBuilder<int>(
      valueListenable: controller.currentTabIndex,
      builder: (context, selectedIndex, _) {
        return TemplateAppScaffold(
          body: IndexedStack(
            index: selectedIndex,
            children: screens,
          ),
          showBottomNavBar: true,
          currentIndex: selectedIndex,
          onNavTap: controller.changeTab,
        );
      },
    );
  }
}

