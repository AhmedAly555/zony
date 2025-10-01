import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../services/navigator.services/app_navigator.services.dart';
import '../../modules/couriers/views/screens/main_home/screen/courier_main_home_screen.dart';
import '../../modules/podu/views/screens/main_home/screen/podu_main_home_screen.dart';
import '../../modules/auth/screens/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkLogin();
  }

  Future<void> _checkLogin() async {
    final prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString('access_token');
    final role = prefs.getString('role');

    await Future.delayed(const Duration(seconds: 2)); // مجرد انيميشن بسيط

    if (!mounted) return;

    if (accessToken != null && role != null) {
      // Tokens موجودة → يحدد الشاشة حسب role
      if (role == "courier") {
        AppNavigator.navigateAndRemoveUntil(context, () => const CourierMainHomeScreen());
      } else if (role == "podu") {
        AppNavigator.navigateAndRemoveUntil(context, () => const PoduMainHomeScreen());
      }
    } else {
      // مفيش tokens → يروح شاشة Login
      AppNavigator.navigateAndRemoveUntil(context, () => const LoginScreen());
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(), // لودينج مؤقت
      ),
    );
  }
}
