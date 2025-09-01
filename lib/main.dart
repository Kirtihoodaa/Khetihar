import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:khetihar/Login%20Registration/book_field_date_time.dart';
import 'package:khetihar/Login%20Registration/confirm_booking_field_agent.dart';
import 'package:khetihar/splash_setup/language_screen.dart';
import 'package:khetihar/splash_setup/splash_screen.dart';
import 'package:khetihar/splash_setup/translations.dart';

import 'AllRoutes.dart';
import 'SplashScreen/OnBording.dart';
import 'Theme/AppColors.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    final saved = box.read<String>('lang'); // "en_US", "hi_IN", ...
    Locale? initialLocale;
    if (saved != null && saved.contains('_')) {
      final p = saved.split('_');
      initialLocale = Locale(p[0], p[1]);
    }

    final theme = ThemeData(
      useMaterial3: true,
      colorSchemeSeed: AppColors.green,
      scaffoldBackgroundColor: AppColors.grey,
      textTheme: GoogleFonts.poppinsTextTheme(),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.green,
          foregroundColor: Colors.white,
          minimumSize: const Size.fromHeight(48),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28),
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.green,
          side: const BorderSide(color: AppColors.green, width: 1.2),
          minimumSize: const Size.fromHeight(48),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28),
          ),
        ),
      ),
    );
    // return MaterialApp(home: ConfirmBookingFieldAgent());
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: theme,
      translations: AppTranslations(),
      locale: initialLocale,
      fallbackLocale: const Locale('en', 'US'),
      getPages: allPages,
      initialRoute: '/',
      // initialRoute: SplashScreen.route,
      // getPages: [
      //   GetPage(name: SplashScreen.route, page: () => const SplashScreen()),
      //   GetPage(name: LanguageScreen.route, page: () => const LanguageScreen()),
      //   GetPage(name: '/onboarding', page: () => OnboardingScreen()),
      // ],
    );
  }
}
