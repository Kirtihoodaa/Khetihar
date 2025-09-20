import 'package:flutter/material.dart';
import 'package:khetihar/Components/CustomAppBar.dart';

import '../../Theme/AppColors.dart';
import '../../Theme/FontSize.dart';
import '../internal_ui&components/nearby_testing_labs_card.dart';
import '../internal_ui&components/soil_test_card.dart';
import '../internal_ui&components/testing_options.dart';

class SoilTestingReport extends StatelessWidget {
  SoilTestingReport({super.key});

  final _bubbleGreen = Color(0xFFE8F2E4); // soft green circle bg
  final _bubbleOrange = Color(0xFFFEEAD5); // soft orange circle bg
  final _bubbleBlue = Color(0xFFDBEAFE); // soft blue circle bg
  final _blueIcon = Color(0xFF3B82F6);
  final _orangeIcon = Color(0xFFE37D3A);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: KCenteredActionsAppBar(title: "Report Soil Testing"),
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 14, horizontal: 16),
        child: ListView(
          children: [
            WhyTestYourSoilCardPerfect(
              items: [
                BenefitItem(
                  icon: Icons.grain, // yields (cluster-like)
                  label: 'Better Yields',
                  bubbleColor: _bubbleGreen,
                  iconColor: AppColors.green,
                ),
                BenefitItem(
                  icon: Icons.science_outlined, // flask
                  label: 'Right\nFertilizers', // 2 lines like screenshot
                  bubbleColor: _bubbleOrange,
                  iconColor: const Color(0xFFE37D3A),
                ),
                BenefitItem(
                  icon: Icons.eco_outlined, // leaf
                  label: 'Save Money',
                  bubbleColor: _bubbleBlue,
                  iconColor: _blueIcon,
                ),
              ],
            ),
            SizedBox(height: 20),
            TestingOptionsCardPerfect(
              options: [
                TestingOption(
                  icon: Icons.home_outlined,
                  bubbleColor: _bubbleGreen,
                  iconColor: AppColors.green,
                  title: 'Schedule Home Collection',
                  subtitle: 'Soil expert will visit your farm',
                  priceText: 'INR 500 - INR 800',
                  resultText: 'Results in 7–10 days',
                ),
                TestingOption(
                  icon: Icons.near_me_outlined,
                  // arrow/locator
                  bubbleColor: _bubbleOrange,
                  iconColor: _orangeIcon,
                  title: 'Visit a Testing Lab',
                  subtitle: 'Take your soil sample to nearby lab',
                  priceText: 'INR 300 - INR 600',
                  resultText: 'Results in 3–5 days',
                ),
                TestingOption(
                  icon: Icons.grid_view_rounded,
                  bubbleColor: _bubbleBlue,
                  iconColor: const Color(0xFF3B82F6),
                  title: 'Government Testing Service',
                  subtitle: 'Free/subsidized testing facility',
                  priceText: 'Free - INR 100',
                  resultText: 'Results in 15–20 days',
                ),
              ],
            ),
            SizedBox(height: 20),
            HowToCollectSamplesCardPerfect(
              image: const AssetImage('Assets/NewsTrends/basket.png'),
              caption: 'How to Collect Soil Samples Watch Video',
              onTap: () {
                // TODO: open video / navigate
              },
            ),
            SizedBox(height: 20),
            NearbyTestingLabsPerfect(
              labs: const [
                LabItem(
                  name: 'Krishi Vigyan Kendra',
                  type: 'Government',
                  distanceKm: '3.8 km',
                ),
                LabItem(
                  name: 'Soil Health Laboratory',
                  type: 'Private',
                  distanceKm: '5.8 km',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// Uses your helpers already in the project:
// AppColors.green, AppColors.greyBorder
// secondary()=16, tertiary()=14

const _textStrong = Color(0xFF111827);

class HowToCollectSamplesCardPerfect extends StatelessWidget {
  final String title; // e.g. "How to Collect Samples"
  final ImageProvider image; // asset or network
  final String caption; // e.g. "How to Collect Soil Samples Watch Video"
  final VoidCallback? onTap; // tap on image/caption

  // exact card width to mirror screenshot
  final double width;

  // image and caption heights tuned to screenshot proportions
  final double imageHeight;
  final double captionHeight;

  const HowToCollectSamplesCardPerfect({
    super.key,
    this.title = 'How to Collect Samples',
    required this.image,
    required this.caption,
    this.onTap,
    this.width = 312, // screenshot ~312 px wide
    this.imageHeight = 180, // rounded photo height
    this.captionHeight = 48,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Heading (green, 16, bold)
          Padding(
            padding: const EdgeInsets.only(left: 2, bottom: 8),
            child: Text(
              title,
              style: TextStyle(
                color: AppColors.green,
                fontSize: primary(), // 16
                fontWeight: FontWeight.w700,
                height: 1.1,
              ),
            ),
          ),
          SizedBox(height: 12),
          // Rounded image
          GestureDetector(
            onTap: onTap,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: SizedBox(
                height: imageHeight,
                width: double.infinity,
                child: Image(image: image, fit: BoxFit.cover),
              ),
            ),
          ),

          const SizedBox(height: 18),

          // Caption card (white bg, rounded, subtle border)
          GestureDetector(
            onTap: onTap,
            child: Container(
              height: captionHeight,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: AppColors.greyBorder, width: 1),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x0F000000),
                    // very soft shadow like screenshot
                    blurRadius: 4,
                    offset: Offset(0, 1),
                  ),
                ],
              ),
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                caption,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: _textStrong,
                  fontSize: secondary(), // 14
                  fontWeight: FontWeight.w600,
                  height: 1.2,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
