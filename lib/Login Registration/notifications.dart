import 'package:flutter/material.dart';
import '../Theme/AppColors.dart';
import '../Theme/FontSize.dart';

// ---- assumes your AppColors & font helpers exist ----
// AppColors.green, AppColors.grey, AppColors.greyBorder
// primary() => 18, tertiary() => 14, small() => 10

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key, this.onBack});

  final VoidCallback? onBack;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            NotificationsAppBar(title: 'Notifications', onBack: onBack),
            // Body
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 2),
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    const SizedBox(height: 10),
                    const _SectionLabel('Today'),

                    // Item 1
                    _DividerLine(),
                    NotificationTile(
                      title: 'Order Shipped',
                      time: '10:26 AM',
                      body:
                          'Your order #AMZ-45786123 has been shipped and is on its way.',
                      ctaText: 'View Order',
                      onCtaTap: () {},
                    ),

                    // Item 2
                    _DividerLine(),
                    NotificationTile(
                      title: 'Weather Update',
                      time: '10:26 AM',
                      body:
                          'Temperature drop expected tonight. Current: 72°F, Tonight: 48°F.',
                      ctaText: 'View Details',
                      onCtaTap: () {},
                    ),

                    _DividerLine(),
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

// ---------------- Reusable header ----------------

class NotificationsAppBar extends StatelessWidget {
  const NotificationsAppBar({super.key, required this.title, this.onBack});

  final String title;
  final VoidCallback? onBack;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      color: AppColors.grey, // light bar like the mock
      padding: const EdgeInsets.symmetric(horizontal: 14),
      child: Row(
        children: [
          _CircleBackButton(
            onPressed: onBack ?? () => Navigator.maybePop(context),
          ),
          const Spacer(),
          Text(
            title,
            style: TextStyle(
              fontSize: primary(), // 18
              fontWeight: FontWeight.w600, // semi-bold
              color: AppColors.green,
              height: 1.2,
            ),
          ),
          const Spacer(),
          const SizedBox(width: 32), // keeps title centered (back button width)
        ],
      ),
    );
  }
}

class _CircleBackButton extends StatelessWidget {
  const _CircleBackButton({this.onPressed});

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: onPressed,
      child: Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: AppColors.greyBorder, width: 1),
        ),
        alignment: Alignment.center,
        child: const Icon(
          Icons.arrow_back_ios_new_rounded,
          size: 16,
          color: AppColors.green,
        ),
      ),
    );
  }
}

// ---------------- Reusable section label ----------------

class _SectionLabel extends StatelessWidget {
  const _SectionLabel(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 6, 16, 8),
      child: Text(
        text,
        style: TextStyle(
          fontSize: secondary(), // 14
          fontWeight: FontWeight.w600,
          color: Colors.black,
          height: 1.2,
        ),
      ),
    );
  }
}

// ---------------- Reusable divider (thin, subtle) ----------------

class _DividerLine extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1,
      margin: const EdgeInsets.only(top: 6),
      color: AppColors.greyBorder,
    );
  }
}

// ---------------- Reusable notification tile ----------------

class NotificationTile extends StatelessWidget {
  const NotificationTile({
    super.key,
    required this.title,
    required this.time,
    required this.body,
    required this.ctaText,
    this.onCtaTap,
  });

  final String title;
  final String time;
  final String body;
  final String ctaText;
  final VoidCallback? onCtaTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title + time
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: tertiary(), // 14
                    fontWeight: FontWeight.w700, // bold like mock
                    color: Colors.black87,
                    height: 1.2,
                  ),
                ),
              ),
              Text(
                time,
                style: TextStyle(
                  fontSize: small() + 2, // ~12
                  color: Colors.black.withOpacity(0.6),
                  height: 1.2,
                ),
              ),
            ],
          ),

          const SizedBox(height: 6),

          // Body
          Text(
            body,
            style: TextStyle(
              fontSize: tertiary(), // 14
              color: Colors.black.withOpacity(0.7),
              height: 1.35,
            ),
          ),

          const SizedBox(height: 10),

          // CTA
          InkWell(
            onTap: onCtaTap,
            borderRadius: BorderRadius.circular(4),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 2),
              child: Text(
                ctaText,
                style: TextStyle(
                  fontSize: tertiary(), // 14
                  fontWeight: FontWeight.w600,
                  color: AppColors.green,
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
