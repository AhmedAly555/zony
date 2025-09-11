 import 'package:flutter/material.dart';

import 'modules/auth/screens/change_password.dart';
import 'modules/auth/screens/login_screen.dart';
import 'modules/auth/screens/otp_screen.dart';
import 'modules/auth/screens/select_login_screen.dart';
import 'modules/couriers/views/delivering/screens/camera.screen.dart';
import 'modules/couriers/views/delivering/screens/parcel_details.screen.dart';
import 'modules/couriers/views/delivering/screens/podu_parcels.screen.dart';
import 'modules/couriers/views/delivering/screens/successful_delivering.screen.dart';
import 'modules/couriers/views/podus&parcels/all_podus.dart';
import 'modules/couriers/views/podus&parcels/podu_details_and_parcels/podu_details_and_parcels.screen.dart';
import 'modules/couriers/views/podus&parcels/podus_map.dart';
import 'modules/couriers/views/screens/account_settings.screen.dart';
import 'modules/couriers/views/screens/main_home/screen/home.screen.dart';
import 'modules/couriers/views/screens/main_home/screen/main_home_screen.dart';
import 'modules/recieve_parcel/screens/scanner_qr_manual.dart';

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
      //home: const MainHomeScreen(),
      //home: const CustomCameraScreen(),
      //home: const SuccessfulDelivering(),
      //home: const ParcelDetailsScreen(),
      //home: const AllPODUsScreen(),
      home: const PDOUDetailsAndParceis(),
    );
  }
}
