import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:khetihar/HomePages/HomePage.dart';

import '../HomePages/AgricultureTools/ProductDetailAgri.dart';
import '../HomePages/BuySeeds/ProductDetailspage.dart';
import '../HomePages/BuySeeds/ReviewScreen.dart';

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
  GetPage(
    name: '/ProductDetailAgri',
    page: () => ProductDetailAgri(), // no need to pass here
    transition: Transition.cupertino,
    transitionDuration: const Duration(milliseconds: 400),
  ),
  GetPage(
    name: '/all_reviews',
    page: () => ReviewScreen(), // no need to pass here
    transition: Transition.cupertino,
    transitionDuration: const Duration(milliseconds: 400),
  ),
];
