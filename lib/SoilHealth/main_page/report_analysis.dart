import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khetihar/Components/CustomAppBar.dart';
import 'package:khetihar/SoilHealth/main_page/recomendations.dart';
import 'package:khetihar/SoilHealth/main_page/soil_healtCard.dart';

import '../../Theme/AppColors.dart';
import '../internal_ui&components/nutrient_metric_card.dart';

import '../internal_ui&components/rec_section.dart';
import '../internal_ui&components/soil_composition.dart';
import '../internal_ui&components/test_info_card.dart';

class ReportAnalysis extends StatelessWidget {
  ReportAnalysis({super.key});

  final _red = Color(0xFFD90429);
  final _amber = Color(0xFFF59E0B); // label + numeric "Medium"
  final _green = Color(0xFF06870F);
  final _siltColor = Color(0xFFC89D6B); // warm tan
  final _sandColor = Color(0xFFF0D9A8); // light sand
  final _softPink = Color(0xFFFDECEC); // Low Nitrogen bg
  final _softYellow = const Color(
    0xFFFFFBEC,
  ); // Organic Matter bg (matches your AppColors.yellow family)
  final _softMint = Color(0xFFF1F6EE);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: KCenteredActionsAppBar(title: "Report Analysis"),
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 16, horizontal: 18),
            child: InternalSoilHealthCard(
              soilType: 'Silty Clay',
              scorePercent: 75,
              statusLabel: 'Moderate',
              // statusColor: const Color(0xFFE37D3A), // optional, auto-picked if omitted
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 18),
            child: TestInfoCardPerfect(
              testDate: '22 May 2023',
              testingMethod: 'Laboratory\nAnalysis',
              location: 'North Plot',
              sampleDepth: '0-10 inches',
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 18),
            child: NutrientProfileCardPerfect(
              metrics: [
                NutrientMetric(
                  icon: Icons.water_drop_outlined,
                  label: 'pH',
                  value: 6.8,
                  rightUnit: '',
                  idealMin: 6.0,
                  idealMax: 7.0,
                  scaleMax: 14.0,
                  barColor: _green,
                  // green fill
                  trackColor: _green,
                  // pH row shows a full green track in the shot
                  showIdealBand: false,
                  // band hidden in pH row per image
                  statusText: 'Optimal',
                  statusColor: _green,
                  rightValueColor: _green,
                ),
                NutrientMetric(
                  icon: Icons.science_outlined,
                  label: 'Nitrogen (N)',
                  value: 35,
                  rightUnit: '%',
                  idealMin: 60,
                  idealMax: 80,
                  scaleMax: 100,
                  barColor: const Color(0xFFEF4444),
                  // red bar
                  statusText: 'low',
                  statusColor: _red,
                  rightValueColor: _red,
                ),
                NutrientMetric(
                  icon: Icons.science_outlined,
                  label: 'Phosphorus (P)',
                  value: 55,
                  rightUnit: '%',
                  idealMin: 60,
                  idealMax: 80,
                  scaleMax: 100,
                  barColor: _amber,
                  // yellow bar
                  statusText: 'Medium',
                  statusColor: _amber,
                  rightValueColor: _amber,
                ),
                NutrientMetric(
                  icon: Icons.science_outlined,
                  label: 'Potassium (K)',
                  value: 78,
                  rightUnit: '%',
                  idealMin: 60,
                  idealMax: 80,
                  scaleMax: 100,
                  barColor: _green,
                  // green bar
                  statusText: 'High',
                  statusColor: _green,
                  rightValueColor: _green,
                ),
                NutrientMetric(
                  icon: Icons.biotech_outlined,
                  label: 'Organic Matter',
                  value: 55,
                  rightUnit: '%',
                  idealMin: 60,
                  idealMax: 80,
                  scaleMax: 100,
                  barColor: _green,
                  // green bar as in shot
                  statusText: 'Medium',
                  statusColor: _green,
                  // in your image, OM status is green
                  rightValueColor: _green,
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 18),
            child: SoilCompositionCardPerfect(
              slices: [
                const CompositionSlice('Clay', 45, AppColors.brown),
                CompositionSlice('Silt', 40, _siltColor),
                CompositionSlice('Sand', 15, _sandColor),
              ],
              description:
                  'Sandy loam soil is a light, warm, dry soil formed by a mixture of sand, silt, and clay '
                  'particles with a high proportion of sand. It drains well, warms up quickly in spring, and '
                  'is easy to cultivate.',
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 18),
            child: RecommendationsCardUltraPerfect(
              lowNitrogen: RecSection(
                title: 'Low Nitrogen Level',
                bodyLines: const [
                  'Apply nitrogen-rich fertilizer to improve soil',
                  'nitrogen content. Recommended NPK ratio:',
                  '10–5–5.',
                  'Apply 2–3 cups of NPK Fertilizer (Urvarak) per',
                  'acre',
                ],
                emphasis: 'Before sowing',
                background: _softPink,
              ),
              organicMatter: RecSection(
                title: 'Organic Matter Enhancement',
                bodyLines: const [
                  'Incorporate more organic matter to improve',
                  'soil structure and fertility.',
                  'Add compost, green manure, or vermicompost',
                ],
                emphasis: '2–3 weeks before planting',
                background: _softYellow,
              ),
              crops: const ['Corn', 'Beans', 'Potatoes', 'Leafy Greens'],
              onBuy: () {
                Get.to(() => RecomendationsProduct());
              },
            ),
          ),
        ],
      ),
    );
  }
}
