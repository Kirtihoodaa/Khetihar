import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:khetihar/NewTrends/NewsView.dart';

final List<GetPage> allnewsTrendsRoutes = [
  GetPage(
    name: '/newsDetail',
    page: () => const NewsDetailPage(),
    transition: Transition.cupertino,
    transitionDuration: const Duration(milliseconds: 400),
  ),
];
