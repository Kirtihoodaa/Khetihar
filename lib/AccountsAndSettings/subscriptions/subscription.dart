import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:khetihar/Components/CustomAppBar.dart';
import 'package:khetihar/Components/CustomButton.dart';
import '../../Theme/AppColors.dart';
import '../../Theme/FontSize.dart';

class Subscription extends StatelessWidget {
  const Subscription({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: KCenteredActionsAppBar(
        title: "Manage Subscriptions",
        avatarImage: AssetImage("Assets/Seeds/OilSeed.png"),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 20),
              SubscriptionPlanCardExact(
                title: 'Free',
                currency: 'INR',
                priceText: '0',
                periodText: '/month',
                features: const [
                  'Basic crop advisory',
                  'Community access',
                  'Market price updates',
                  'Community support',
                ],
                showActiveBadge: true,
              ),
              PremiumPlanCardExact(),
              SizedBox(height: 12),
              BillingInfoSectionExact(
                nextBillingDate: DateTime(2025, 8, 25),
                onCancel: () {
                  /* cancel logic */
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SubscriptionPlanCardExact extends StatelessWidget {
  const SubscriptionPlanCardExact({
    super.key,
    this.title = 'Free',
    this.currency = 'INR',
    this.priceText = '0',
    this.periodText = '/month',
    this.features = const [
      'Basic crop advisory',
      'Community access',
      'Market price updates',
      'Community support',
    ],
    this.showActiveBadge = true,
    this.activeBadgeText = 'Currently Active',
  });

  final String title;
  final String currency;
  final String priceText;
  final String periodText;
  final List<String> features;
  final bool showActiveBadge;
  final String activeBadgeText;

  @override
  Widget build(BuildContext context) {
    // lock scaling for exact sizing (optional but helps parity)
    final mq = MediaQuery.of(context).copyWith(textScaleFactor: 1.1);

    return MediaQuery(
      data: mq,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: AppColors.brown,
            width: 1,
          ), // thin brown outline
        ),
        child: Stack(
          children: [
            // content
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // "Free"
                Text(
                  title,
                  style: TextStyle(
                    fontSize: secondary(), // 16
                    fontWeight: FontWeight.w500, // medium (not too bold)
                    color: Colors.black.withOpacity(0.75),
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 8),

                // "INR 0/month" on one baseline
                RichText(
                  text: TextSpan(
                    style: TextStyle(
                      fontSize: large(), // 26
                      fontWeight: FontWeight.w700,
                      color: Colors.black87,
                      height: 2.0,
                    ),
                    children: [
                      TextSpan(text: '$currency '),
                      TextSpan(text: priceText),
                      TextSpan(
                        text: ' $periodText',
                        style: TextStyle(
                          fontSize: tertiary(), // 14
                          fontWeight: FontWeight.w500,
                          color: Colors.black.withOpacity(0.55),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),

                // features list (tiny soft-grey check bullets)
                for (var i = 0; i < features.length; i++) ...[
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 0),
                    child: _FeatureRowExact(text: features[i]),
                  ),
                  if (i != features.length - 1) const SizedBox(height: 10),
                ],
              ],
            ),

            // top-right badge
            if (showActiveBadge)
              Positioned(
                right: 0,
                top: 0,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.brown,
                    borderRadius: BorderRadius.circular(16), // pill
                  ),
                  child: Text(
                    activeBadgeText,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                      height: 1.0,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _FeatureRowExact extends StatelessWidget {
  const _FeatureRowExact({required this.text});

  final String text;

  static const _dotFill = Color(0xFFF3F2F0); // soft grey fill (not pure white)
  static const _dotStroke = Color(0xFFB8B2AC); // soft grey stroke
  static const _dotIcon = Color(0xFFB0AAA4); // soft grey check

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // tiny circular bullet with check
        Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            color: _dotFill,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: _dotStroke, width: 1),
          ),
          alignment: Alignment.center,
          child: const Icon(Icons.check, size: 10, color: _dotIcon),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: secondary(), // 16
              color: Colors.black.withOpacity(0.85),
              height: 1.85,
            ),
          ),
        ),
      ],
    );
  }
}

class PremiumPlanCardExact extends StatelessWidget {
  const PremiumPlanCardExact({
    super.key,
    this.title = 'Premium',
    this.currency = 'INR',
    this.priceText = '120',
    this.periodText = '/month',
    this.features = const [
      'All Normal Plan features',
      'Premium seeds & fertilizers',
      'Expert advice priority',
      'Loan application assistance',
      'Tools rental discour',
      'Individual Chat',
    ],
    this.badgeText = 'MOST POPULAR',
    this.ctaText = 'Start 7-Day Free Trial',
    this.onCta,
  });

  final String title;
  final String currency;
  final String priceText;
  final String periodText;
  final List<String> features;
  final String badgeText;
  final String ctaText;
  final VoidCallback? onCta;

  @override
  Widget build(BuildContext context) {
    // lock scaling for pixel parity
    final mq = MediaQuery.of(context).copyWith(textScaleFactor: 1.0);

    return MediaQuery(
      data: mq,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
        decoration: BoxDecoration(
          color: AppColors.green, // olive background
          borderRadius: BorderRadius.circular(14),
        ),
        child: Stack(
          children: [
            // content
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title
                Text(
                  title,
                  style: TextStyle(
                    fontSize: secondary(), // 16
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 10),

                // Price line: INR 120 /month (same baseline)
                RichText(
                  text: TextSpan(
                    style: TextStyle(
                      fontSize: large(), // 26
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      height: 1.5,
                    ),
                    children: [
                      TextSpan(text: '$currency '),
                      TextSpan(text: priceText),
                      TextSpan(
                        text: ' $periodText',
                        style: TextStyle(
                          fontSize: tertiary(), // 14
                          fontWeight: FontWeight.w500,
                          color: Colors.white.withOpacity(0.85),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),

                // Features list (white text, white bullets with green check)
                for (int i = 0; i < features.length; i++) ...[
                  _WhiteCheckRow(text: features[i]),
                  if (i != features.length - 1) const SizedBox(height: 10),
                ],

                const SizedBox(height: 16),

                // CTA button (full-width white pill)
                SizedBox(
                  width: double.infinity,
                  height: 44,
                  child: CustomButton(
                    text: "Start 7-Day Free Trial",
                    onPressed: () {},
                    foregroundColor: AppColors.green,
                    backgroundColor: Colors.white,
                  ),
                ),
              ],
            ),

            // Top-right badge
            Positioned(
              right: 0,
              top: 0,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: AppColors.brown,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Text(
                  'MOST POPULAR',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    height: 1.0,
                    letterSpacing: 0.2,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _WhiteCheckRow extends StatelessWidget {
  const _WhiteCheckRow({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // small white disc with green check
        Container(
          width: 18,
          height: 18,
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
          alignment: Alignment.center,
          child: const Icon(Icons.check, size: 12, color: AppColors.green),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: secondary(), // 16
              color: Colors.white,
              height: 1.85,
            ),
          ),
        ),
      ],
    );
  }
}

class BillingInfoSectionExact extends StatelessWidget {
  const BillingInfoSectionExact({
    super.key,
    required this.nextBillingDate,
    required this.onCancel,
    this.title = 'Billing Information',
  });

  final DateTime nextBillingDate;
  final VoidCallback onCancel;
  final String title;

  @override
  Widget build(BuildContext context) {
    // lock scaling for strict parity
    final mq = MediaQuery.of(context).copyWith(textScaleFactor: 1.0);
    final dateStr = DateFormat('MMMM dd, yyyy').format(nextBillingDate);

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
                color: Colors.black87,
                height: 1.2,
              ),
            ),
            const SizedBox(height: 8),

            // Card
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.greyBorder, width: 1),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Row: Next billing / date
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Next billing:',
                        style: TextStyle(
                          fontSize: tertiary(), // 14
                          color: Colors.black.withOpacity(0.70),
                          height: 1.25,
                        ),
                      ),
                      Text(
                        dateStr,
                        style: TextStyle(
                          fontSize: tertiary(), // 14
                          fontWeight: FontWeight.w700,
                          color: Colors.black87,
                          height: 1.25,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),

                  // Green pill button
                  SizedBox(
                    height: 44,
                    child: CustomButton(
                      text: "Cancel Subscription",
                      onPressed: () {},
                      foregroundColor: Colors.white,
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
