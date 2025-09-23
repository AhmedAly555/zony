import 'package:flutter/material.dart';
import 'package:zony/modules/couriers/views/screens/main_home/screen/courier_receiving_screen.dart';

import '../../../../../../views/widgets/template_app_scaffold.widget.dart';
import 'podu_delivering_screen.dart';
import 'podu_home_screen.dart';
import 'podu_more.screen.dart';

class PoduMainHomeScreen extends StatefulWidget {
  const PoduMainHomeScreen({super.key});

  @override
  State<PoduMainHomeScreen> createState() => _PoduMainHomeScreenState();
}

class _PoduMainHomeScreenState extends State<PoduMainHomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = const [
    PoduHomeScreen(),
    CourierReceivingScreen(),
    PoduDeliveringScreen(),
    PoduMoreScreen(),
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
