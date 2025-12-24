import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:zony/services/locale_language_service.dart';
import 'package:zony/services/navigator.services/navigation_service.dart';
import 'package:zony/theme/app_languages_theme.dart';


import 'package:zony/views/screens/splash_screen.dart';

import 'generated/l10n.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocaleLanguageService.instance.loadLocale();
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
    LocaleLanguageService.instance.localeNotifier.addListener(() {
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Locale>(
      valueListenable: LocaleLanguageService.instance.localeNotifier,
      builder: (context, locale, child) {
        return MaterialApp(
          navigatorKey: NavigationService.navigatorKey,
          locale: locale,
          localizationsDelegates: const [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: S.delegate.supportedLocales,
          title: 'Zony',
          debugShowCheckedModeBanner: false,
          theme: locale.languageCode == 'ar'
              ? AppTheme.arabicTheme
              : AppTheme.englishTheme,
          home: const SplashScreen(),
        );
      },
    );
  }
}
