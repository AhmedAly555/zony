import 'package:flutter/material.dart';
import 'package:zony/modules/couriers/views/screens/main_home/screen/receiving_screen.dart';

import '../../../../../../views/widgets/template_app_scaffold.widget.dart';
import 'delivering_screen.dart';
import 'home.screen.dart';
import 'more.screen.dart';

class MainHomeScreen extends StatefulWidget {
  const MainHomeScreen({super.key});

  @override
  State<MainHomeScreen> createState() => _MainHomeScreenState();
}

class _MainHomeScreenState extends State<MainHomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = const [
    HomeScreen(),
    ReceivingScreen(),
    DeliveringScreen(),
    MoreScreen(),
  ];

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
