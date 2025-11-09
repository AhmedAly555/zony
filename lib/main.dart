import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:zony/services/locale_service.dart';
import 'package:zony/services/navigation_service.dart';

import 'package:zony/views/screens/splash_screen.dart';

import 'generated/l10n.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocaleService.instance.loadLocale();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    LocaleService.instance.localeNotifier.addListener(() {
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Locale>(
      valueListenable: LocaleService.instance.localeNotifier,
      builder: (context, locale, child) {
        return MaterialApp(
          navigatorKey: NavigationService.navigatorKey,
          locale: locale,
          localizationsDelegates: [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: S.delegate.supportedLocales,
          title: 'Zony',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            fontFamily: 'Poppins',
            colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFF49159B)),
            scaffoldBackgroundColor: Color(0xFFF4F4F4),
          ),
          home: const SplashScreen(),
        );
      },
    );
  }
}
