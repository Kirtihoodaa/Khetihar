import 'package:flutter/material.dart';
import 'package:khetihar/Components/CustomAppBar.dart';

import '../internal_ui&components/recomendations.dart';

class RecomendationsProduct extends StatelessWidget {
  const RecomendationsProduct({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: KCenteredActionsAppBar(title: "Recommendations"),
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 14, horizontal: 16),
        child: ListView(
          children: [
            ProductRecommendationCardExact(),
            SizedBox(height: 18),
            ProductRecommendationCardExact(),
            SizedBox(height: 18),
            ProductRecommendationCardExact(),
          ],
        ),
      ),
    );
  }
}
