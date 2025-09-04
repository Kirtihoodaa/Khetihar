import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';

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
];
