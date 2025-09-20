import 'package:flutter/material.dart';

import '../../Theme/AppColors.dart';
import '../../Theme/FontSize.dart';

// Uses your helpers already in the project:
// AppColors.green, AppColors.greyBorder
// secondary()=16, tertiary()=14, medium()=12

// extra tints & neutrals for exact match
const _textStrong = Color(0xFF111827);
const _textMuted = Color(0xFF6B7280);
const _bubbleGreen = Color(0xFFE8F2E4);
const _bubbleOrange = Color(0xFFFEEAD5);
const _bubbleBlue = Color(0xFFDBEAFE);
const _orangeIcon = Color(0xFFE37D3A);

class TestingOption {
  final IconData icon;
  final Color bubbleColor;
  final Color iconColor;
  final String title; // e.g., "Schedule Home Collection"
  final String subtitle; // e.g., "Soil expert will visit your farm"
  final String priceText; // e.g., "INR 500 - INR 800" / "Free - INR 100"
  final String resultText; // e.g., "Results in 7–10 days"

  const TestingOption({
    required this.icon,
    required this.bubbleColor,
    required this.iconColor,
    required this.title,
    required this.subtitle,
    required this.priceText,
    required this.resultText,
  });
}

class TestingOptionsCardPerfect extends StatelessWidget {
  final String heading; // "Testing Options"
  final List<TestingOption> options; // 3 rows as per screenshot
  final double width;

  const TestingOptionsCardPerfect({
    super.key,
    this.heading = 'Testing Options',
    required this.options,
    this.width = 320, // tuned to screenshot
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.greyBorder, width: 1),
          boxShadow: const [
            BoxShadow(
              color: Color(0x14000000),
              blurRadius: 8,
              offset: Offset(0, 2),
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Heading
            Padding(
              padding: const EdgeInsets.only(left: 2, bottom: 8),
              child: Text(
                heading,
                style: TextStyle(
                  color: AppColors.green,
                  fontSize: secondary(), // 16
                  fontWeight: FontWeight.w700,
                  height: 1.1,
                ),
              ),
            ),

            // Option cards (exact spacing & radii)
            ...List.generate(options.length, (i) {
              final isLast = i == options.length - 1;
              return Padding(
                padding: EdgeInsets.only(bottom: isLast ? 0 : 12),
                child: _OptionRow(option: options[i]),
              );
            }),
          ],
        ),
      ),
    );
  }
}

class _OptionRow extends StatelessWidget {
  final TestingOption option;

  const _OptionRow({required this.option});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white, // inner card
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.greyBorder, width: 1),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0F000000), // softer inner shadow
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Icon bubble
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: option.bubbleColor,
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Icon(option.icon, size: 25, color: option.iconColor),
          ),
          const SizedBox(width: 12),

          // Texts
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title
                Text(
                  option.title,
                  style: TextStyle(
                    color: _textStrong,
                    fontSize: secondary(), // 16
                    fontWeight: FontWeight.w700,
                    height: 1.1,
                  ),
                ),
                const SizedBox(height: 8),

                // Subtitle
                Text(
                  option.subtitle,
                  style: TextStyle(
                    color: _textMuted,
                    fontSize: tertiary(), // 14
                    height: 1.35,
                  ),
                ),
                const SizedBox(height: 8),

                // Price row
                Row(
                  children: [
                    Icon(
                      Icons.description_outlined,
                      size: 16,
                      color: AppColors.green,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      option.priceText,
                      style: TextStyle(
                        color: AppColors.green,
                        fontSize: tertiary(), // 14
                        fontWeight: FontWeight.w700,
                        height: 1.0,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),

                // Result row
                Row(
                  children: [
                    Icon(
                      Icons.calendar_today_outlined,
                      size: 16,
                      color: _textMuted,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      option.resultText,
                      style: TextStyle(
                        color: _textMuted,
                        fontSize: medium(), // 12
                        fontWeight: FontWeight.w600,
                        height: 1.0,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
