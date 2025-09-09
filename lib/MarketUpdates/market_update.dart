import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khetihar/Components/CustomAppBar.dart';
import 'package:khetihar/Components/CustomButton.dart';
import 'package:khetihar/MarketUpdates/set_price_alerts.dart';
import 'package:khetihar/MarketUpdates/view_market.dart';

import '../../Theme/AppColors.dart';
import '../../Theme/FontSize.dart';
import 'alerts.dart';
import 'nearby_market.dart';

class MarketUpdate extends StatelessWidget {
  const MarketUpdate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const KCenteredActionsAppBar(title: ""),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        children: [
          const SizedBox(height: 10),

          MarketUpdateSectionExact(
            bannerImage: const AssetImage(
              'Assets/HomeScreens/farmer_login.png',
            ),
            onLocationTap: () {},
            onCtaTap: () {},
          ),

          const SizedBox(height: 20),

          MarketPriceCardExact(
            image: const AssetImage('Assets/HomeScreens/Field.png'),
            onPressed: () {},
          ),
          // Inside a Column/ListView item:
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            child: const SetPriceAlertsTitle(),
          ),
          const SizedBox(height: 0),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 14),
            child: AlertsMintPanel(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const AlertItemCard(
                    text: 'Tomato: Alert when price falls\nbelow INR 40/kg',
                  ),
                  const SizedBox(height: 10),
                  const AlertItemCard(
                    text: 'Potato: Alert when price rises above\nINR 25/kg',
                  ),
                  const SizedBox(height: 12),
                  // Use a builder/Callback in real code
                  AddNewAlertButton(
                    onPressed: () => Get.to(() => SetPriceAlerts()),
                  ),
                ],
              ),
            ),
          ),
          // ...
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            child: const NearbyMarketsTitle(),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            child: NearbyMarketsList(
              items: [
                (
                  image: const AssetImage('Assets/Seeds/Vegetable.png'),
                  label: 'Bihar Market',
                  onTap: () {},
                ),
                (
                  image: const AssetImage('Assets/HomeScreens/Field.png'),
                  label: 'Patna Market',
                  onTap: () {},
                ),
                (
                  image: const AssetImage(
                    'Assets/HomeScreens/profile_background.png',
                  ),
                  label: 'Gaya Market',
                  onTap: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MarketUpdateSectionExact extends StatelessWidget {
  const MarketUpdateSectionExact({
    super.key,
    this.title = 'Market Updates',
    this.location = 'New Delhi, India',
    required this.bannerImage, // e.g. AssetImage('assets/seed_hands.jpg')
    this.bannerText = 'Would you like to receive free\nseeds for your farm?',
    this.ctaText = 'Register Now',
    this.onLocationTap,
    this.onCtaTap,
    this.bannerHeight = 200,
    this.radius = 12,
  });

  final String title;
  final String location;
  final ImageProvider bannerImage;
  final String bannerText;
  final String ctaText;
  final VoidCallback? onLocationTap;
  final VoidCallback? onCtaTap;
  final double bannerHeight;
  final double radius;

  @override
  Widget build(BuildContext context) {
    // lock text scale for pixel parity
    final mq = MediaQuery.of(context).copyWith(textScaleFactor: 1.0);

    return MediaQuery(
      data: mq,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            Text(
              title,
              style: TextStyle(
                fontSize: secondary(), // 16
                fontWeight: FontWeight.w600,
                color: AppColors.green,
                height: 1.2,
              ),
            ),
            const SizedBox(height: 14),

            // Location row
            InkWell(
              borderRadius: BorderRadius.circular(8),
              onTap: onLocationTap,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    location,
                    style: TextStyle(
                      fontSize: secondary(), // 16
                      fontWeight: FontWeight.w600,
                      color: AppColors.green,
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(width: 6),
                  const Icon(
                    Icons.chevron_right,
                    size: 18,
                    color: AppColors.green,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 22),

            // Banner card
            ClipRRect(
              borderRadius: BorderRadius.circular(radius),
              child: SizedBox(
                height: bannerHeight,
                width: double.infinity,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    // Image
                    Image(image: bannerImage, fit: BoxFit.cover),

                    // Dark overlay (for white text contrast)
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [
                            Colors.black.withOpacity(0.45),
                            Colors.black.withOpacity(0.15),
                          ],
                        ),
                      ),
                    ),

                    // Copy + CTA
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            bannerText,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: primary(),
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                              height: 1.25,
                            ),
                          ),
                          const SizedBox(height: 12),
                          CustomButton(
                            fontSize: 12,
                            text: ctaText,
                            onPressed: onCtaTap,
                            height: 40,
                            foregroundColor: Colors.white,
                            backgroundColor: AppColors.darkGreen,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MarketPriceCardExact extends StatelessWidget {
  const MarketPriceCardExact({
    super.key,
    required this.image, // e.g. AssetImage('assets/market.jpg')
    this.title = 'Get Market Price Updates',
    this.subtitle =
        'Current daily prices of various items from\ndifferent markets',
    this.ctaText = 'View Market',
    this.onPressed,
    this.radius = 12,
    this.imageHeight = 200,
  });

  final ImageProvider image;
  final String title;
  final String subtitle;
  final String ctaText;
  final VoidCallback? onPressed;
  final double radius;
  final double imageHeight;

  @override
  Widget build(BuildContext context) {
    // Lock scaling for pixel parity
    final mq = MediaQuery.of(context).copyWith(textScaleFactor: 1.0);

    return MediaQuery(
      data: mq,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(radius),
          border: Border.all(color: AppColors.greyBorder, width: 1),
          boxShadow: [
            // subtle base shadow as in the mock
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Top image (rounded only on top)
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(radius),
                topRight: Radius.circular(radius),
              ),
              child: SizedBox(
                height: imageHeight,
                width: double.infinity,
                child: Image(image: image, fit: BoxFit.cover),
              ),
            ),

            // Content
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10),
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: secondary(), // 16
                      fontWeight: FontWeight.w600,
                      color: AppColors.green,
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(height: 12),
                  // Grey body
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: tertiary(), // 14
                      color: Colors.black,
                      height: 1.35,
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Centered green pill CTA
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: SizedBox(
                      height: 40,
                      width: 180,
                      child: CustomButton(
                        text: "View Market",
                        onPressed: () {
                          Get.to(() => ViewMarket());
                        },
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
