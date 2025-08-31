import 'package:flutter/material.dart';

import '../../../../../../views/widgets/template_app_scaffold.widget.dart';
import '../../../../../couriers/views/screens/main_home/screen/delivering_screen.dart';
import '../../../../../couriers/views/screens/main_home/screen/home.screen.dart';
import '../../../../../couriers/views/screens/main_home/screen/more.screen.dart';
import '../../../../../couriers/views/screens/main_home/screen/receiving_screen.dart';

class MainHomeScreen extends StatefulWidget {
  final int initialIndex;
  const MainHomeScreen({super.key, this.initialIndex = 0});

  @override
  State<MainHomeScreen> createState() => _MainHomeScreenState();
}

class _MainHomeScreenState extends State<MainHomeScreen> {
  late int _selectedIndex;

  final List<Widget> _screens = const [
    HomeScreen(),
    ReceivingScreen(),
    DeliveringScreen(),
    MoreScreen(),
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
