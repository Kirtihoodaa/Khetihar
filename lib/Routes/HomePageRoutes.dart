import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:khetihar/HomePages/HomePage.dart';

final List<GetPage> allPages = [
  GetPage(
    name: '/HomePage',
    page: () => HomePage(),
    transition: Transition.cupertino,
    transitionDuration: const Duration(milliseconds: 400),
  ),
];
