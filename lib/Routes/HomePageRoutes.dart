import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:khetihar/HomePages/HomePage.dart';

import '../HomePages/BuySeeds/ProductDetailspage.dart';

final List<GetPage> homepageroute = [
  GetPage(
    name: '/HomePage',
    page: () => HomePage(),
    transition: Transition.cupertino,
    transitionDuration: const Duration(milliseconds: 400),
  ),
  GetPage(
    name: '/ProductDetailPage',
    page: () => ProductDetailsPage(), // no need to pass here
    transition: Transition.cupertino,
    transitionDuration: const Duration(milliseconds: 400),
  ),
];
