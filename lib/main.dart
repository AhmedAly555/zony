import 'package:flutter/material.dart';

import 'modules/auth/screens/change_password.dart';
import 'modules/couriers/views/screens/main_home/screen/home.screen.dart';
import 'modules/couriers/views/screens/main_home/screen/main_home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Zony',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Poppins',
        colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFF49159B)),
        scaffoldBackgroundColor: Color(0xFFF4F4F4),
      ),
      //home: const LoginScreen(),
      //home: const SelectLoginScreen(),
      home: const MainHomeScreen(),
      //home: const ChangePasswordScreen(),
    );
  }
}
