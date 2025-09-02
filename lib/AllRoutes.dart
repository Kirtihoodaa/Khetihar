import 'package:get/get.dart';
import 'package:khetihar/Login%20Registration/BookField.dart';
import 'package:khetihar/Login%20Registration/Field.dart';
import 'package:khetihar/Login%20Registration/book_field_date_time.dart';
import 'package:khetihar/Login%20Registration/booking_detail_summary_card.dart';
import 'package:khetihar/Login%20Registration/otp.dart';
import 'package:khetihar/Login%20Registration/profile.dart';
import 'package:khetihar/splash_setup/language_screen.dart';
import 'package:khetihar/splash_setup/splash_screen.dart';

import 'Login Registration/forgotPassword.dart';
import 'Login Registration/login.dart';
import 'Login Registration/register.dart';
import 'SplashScreen/OnBording.dart';
import 'SplashScreen/WelcomeScreen.dart';

final List<GetPage> allPages = [
  GetPage(
    name: '/',
    page: () => const SplashScreen(),
    transition: Transition.cupertino,
    transitionDuration: const Duration(milliseconds: 400),
  ),

  GetPage(
    name: '/LanguageScreen',
    page: () => const LanguageScreen(),
    transition: Transition.cupertino,
    transitionDuration: const Duration(milliseconds: 400),
  ),
  GetPage(
    name: '/onboarding',
    page: () => const OnboardingScreen(),
    transition: Transition.cupertino,
    transitionDuration: const Duration(milliseconds: 400),
  ),
  GetPage(
    name: '/welcome',
    page: () => const WelcomeScreen(),
    transition: Transition.cupertino,
    transitionDuration: const Duration(milliseconds: 400),
  ),
  GetPage(
    name: '/login',
    page: () => LoginScreen(),
    transition: Transition.cupertino,
    transitionDuration: const Duration(milliseconds: 400),
  ),
  GetPage(
    name: '/register',
    page: () => RegisterScreen(),
    transition: Transition.cupertino,
    transitionDuration: const Duration(milliseconds: 400),
  ),
  GetPage(
    name: '/forgot',
    page: () => ForgetPasswordScreen(),
    transition: Transition.cupertino,
    transitionDuration: const Duration(milliseconds: 400),
  ),
  GetPage(
    name: '/otpVerification',
    page: () => OtpVerificationScreen(),
    transition: Transition.cupertino,
    transitionDuration: const Duration(milliseconds: 400),
  ),
  GetPage(
    name: '/BookFieldScreen',
    page: () => BookFieldScreen(),
    transition: Transition.cupertino,
    transitionDuration: const Duration(milliseconds: 400),
  ),
  GetPage(
    name: '/FieldInspection',
    page: () => FieldInspectionIntro(),
    transition: Transition.cupertino,
    transitionDuration: const Duration(milliseconds: 400),
  ),
  GetPage(
    name: '/CompleteProfileScreen',
    page: () => CompleteProfileScreen(),
    transition: Transition.cupertino,
    transitionDuration: const Duration(milliseconds: 400),
  ),
  GetPage(
    name: '/BookFieldDateTime',
    page: () => BookFieldDateTime(),
    transition: Transition.cupertino,
    transitionDuration: const Duration(milliseconds: 400),
  ),
];
