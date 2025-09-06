import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:khetihar/AccountsAndSettings/LoanRequest/loanRequest.dart';
import 'package:khetihar/AccountsAndSettings/order_pages/address.dart';
import 'package:khetihar/AccountsAndSettings/order_pages/cards.dart';
import 'package:khetihar/AccountsAndSettings/order_pages/changePassword.dart';
import 'package:khetihar/AccountsAndSettings/order_pages/editProfile.dart';
import 'package:khetihar/AccountsAndSettings/order_pages/notification.dart';
import 'order_pages/help_support.dart';
import 'order_pages/language_selection.dart';

final List<GetPage> allAccountPages = [
  GetPage(
    name: '/languageSelectionAccount',
    page: () => const UpdateLanguageScreen(),
    transition: Transition.cupertino,
    transitionDuration: const Duration(milliseconds: 400),
  ),
  GetPage(
    name: '/helpsupportAccount',
    page: () => const HelpSupportScreen(),
    transition: Transition.cupertino,
    transitionDuration: const Duration(milliseconds: 400),
  ),
  GetPage(
    name: '/editProfileAccount',
    page: () => const EditProfileScreen(),
    transition: Transition.cupertino,
    transitionDuration: const Duration(milliseconds: 400),
  ),
  GetPage(
    name: '/savedCardsAccount',
    page: () => const SavedCardsScreen(),
    transition: Transition.cupertino,
    transitionDuration: const Duration(milliseconds: 400),
  ),
  GetPage(
    name: '/changePasswordAccount',
    page: () => const ChangePasswordPage(),
    transition: Transition.cupertino,
    transitionDuration: const Duration(milliseconds: 400),
  ),
  GetPage(
    name: '/notifiactionAccount',
    page: () => const NotificationSettingsPage(),
    transition: Transition.cupertino,
    transitionDuration: const Duration(milliseconds: 400),
  ),
   GetPage(
    name: '/addressAccount',
    page: () => const ShippingAddressScreen(),
    transition: Transition.cupertino,
    transitionDuration: const Duration(milliseconds: 400),
  ),
   GetPage(
    name: '/loanAccount',
    page: () => const LoanRequestAccount(),
    transition: Transition.cupertino,
    transitionDuration: const Duration(milliseconds: 400),
  ),
];
