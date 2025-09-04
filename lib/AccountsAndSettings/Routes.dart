import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:khetihar/AccountsAndSettings/internal_pagez/help_support.dart';
import 'package:khetihar/AccountsAndSettings/internal_pagez/language_selection.dart';

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
];
