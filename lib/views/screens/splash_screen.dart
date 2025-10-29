import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../services/get_pudos_service.dart';
import '../../services/navigator.services/app_navigator.services.dart';
import '../../modules/couriers/views/screens/main_home/screen/courier_main_home_screen.dart';
import '../../modules/podu/views/screens/main_home/screen/podu_main_home_screen.dart';
import '../../modules/auth/screens/login_screen.dart';
import '../../services/user_profile_service.dart';
import '../widgets/loading.widget.dart';

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

  /*Future<void> _checkLogin() async {
    final prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString('access_token');
    final role = prefs.getString('role');

    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;

    if (accessToken != null && role != null) {
      // if have tokens go to main screen depends on role
      if (role == "courier") {
        AppNavigator.navigateAndRemoveUntil(context, () => const CourierMainHomeScreen());
      } else if (role == "podu") {
        AppNavigator.navigateAndRemoveUntil(context, () => const PoduMainHomeScreen());
      }
    } else {
      // if don't have tokens go to login screen
      AppNavigator.navigateAndRemoveUntil(context, () => const LoginScreen());
    }
  }*/
  Future<void> _checkLogin() async {
    final prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString('access_token');
    final role = prefs.getString('role');

    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;

    if (accessToken != null && role != null) {
      // try to get profile from cache
      final cachedProfile = await UserService.instance.getCachedProfile();
      //debugPrint("Cached user: ${cachedProfile?.firstName}");

      // try to get pudos from cache
      final cachedPudos = await PudoService.instance.getCachedPudos();
      //debugPrint('Cached PUDOs: ${cachedPudos.length}');


      //go to main screen depends on role
      if (role == "courier") {
        AppNavigator.navigateAndRemoveUntil(
            context, () => const CourierMainHomeScreen());
      } else if (role == "responsible") {
        AppNavigator.navigateAndRemoveUntil(context, () => const PoduMainHomeScreen());
      }
    } else {
      // go to login screen
      AppNavigator.navigateAndRemoveUntil(context, () => const LoginScreen());
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: LoadingWidget(),
      ),
    );
  }
}
