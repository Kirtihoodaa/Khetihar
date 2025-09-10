import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:khetihar/Components/CustomAppBar.dart';
import 'package:khetihar/SoilHealth/internal_ui&components/recomendations.dart';
import 'package:khetihar/SoilHealth/internal_ui&components/soil_action_cards.dart';
import 'package:khetihar/SoilHealth/internal_ui&components/soil_care_tips.dart';
import 'package:khetihar/SoilHealth/internal_ui&components/soil_report.dart';
import 'package:khetihar/SoilHealth/internal_ui&components/soild_health_card.dart';
import 'package:khetihar/SoilHealth/main_page/upload_report.dart';

class SoilHealth extends StatelessWidget {
  SoilHealth({super.key});

  final tips = [
    SoilTipItem(
      title: "Season: Pre-Sowing",
      subtitle: "3 steps to prepare your soil",
      image: const AssetImage(
        "Assets/HomeScreens/profile.png",
      ), // or NetworkImage(...)
    ),
    SoilTipItem(
      title: "Improve Soil Health",
      subtitle: "Natural nutrient boosters",
      image: const AssetImage("Assets/HomeScreens/profile_background.png"),
    ),
    // more...
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: KCenteredActionsAppBar(title: ""),
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 2, horizontal: 10),
        child: ListView(
          children: [
            SoilHealthCard(),
            SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: GestureDetector(child: const SoilActionCardsExact()),
            ),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.symmetric(vertical: 2, horizontal: 7),
              child: RecommendationsSectionExact(),
            ),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.symmetric(vertical: 2, horizontal: 7),
              child: SoilCareTipsHorizontalExact(items: tips),
            ),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.symmetric(vertical: 2, horizontal: 10),
              child: MySoilReportsSectionExact(),
            ),
          ],
        ),
      ),
    );
  }
}
