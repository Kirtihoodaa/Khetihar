import 'package:flutter/material.dart';

import '../../Theme/AppColors.dart';
import '../../Theme/FontSize.dart';

// Uses your sizes & palette:
// AppColors.green, AppColors.greyBorder
// secondary()=16, tertiary()=14, medium()=12

// subtle tints + neutrals tuned to the screenshot
const _textStrong = Color(0xFF111827);

class BenefitItem {
  final IconData icon;
  final String label; // use "\n" to force 2 lines (e.g., "Right\nFertilizers")
  final Color bubbleColor;
  final Color iconColor;

  const BenefitItem({
    required this.icon,
    required this.label,
    required this.bubbleColor,
    required this.iconColor,
  });
}

class WhyTestYourSoilCardPerfect extends StatelessWidget {
  final String title; // "Why Test Your Soil?"
  final List<BenefitItem> items; // exactly 3 in the screenshot

  const WhyTestYourSoilCardPerfect({
    super.key,
    this.title = 'Why Test Your Soil?',
    required this.items,
  }) : assert(items.length == 3, 'Provide exactly 3 items to match layout');

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 313, // screenshot width
      height: 164, // screenshot height
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
        padding: const EdgeInsets.fromLTRB(12, 8, 12, 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            Padding(
              padding: const EdgeInsets.only(left: 2, bottom: 8),
              child: Text(
                title,
                style: TextStyle(
                  color: AppColors.green,
                  fontSize: secondary(), // 16
                  fontWeight: FontWeight.w700,
                  height: 1.1,
                ),
              ),
            ),

            // Three evenly-spaced benefits
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: items.map((b) => _Benefit(b)).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Benefit extends StatelessWidget {
  final BenefitItem b;

  const _Benefit(this.b);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 86, // tuned so the middle label wraps to 2 lines like screenshot
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // circular soft bubble with centered icon
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: b.bubbleColor,
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Icon(b.icon, size: 24, color: b.iconColor),
          ),
          const SizedBox(height: 10),
          // label
          Text(
            b.label,
            textAlign: TextAlign.center,
            softWrap: true,
            style: TextStyle(
              color: _textStrong,
              fontSize: tertiary(), // 14
              fontWeight: FontWeight.w600,
              height: 1.15,
            ),
          ),
        ],
      ),
    );
  }
}
