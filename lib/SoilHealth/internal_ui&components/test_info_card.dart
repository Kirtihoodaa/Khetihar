import 'package:flutter/material.dart';

import '../../Theme/AppColors.dart';
import '../../Theme/FontSize.dart';
import 'package:flutter/material.dart';

// assumes your helpers exist:
// AppColors.green, AppColors.greyBorder
// primary()=18, secondary()=16, tertiary()=14, medium()=12

const _textStrong = Color(0xFF111827);
const _textMuted = Color(0xFF6B7280);
const _iconGrey = Color(0xFF9CA3AF);

class TestInfoCardPerfect extends StatelessWidget {
  final String title;
  final String testDate;
  final String testingMethod; // allow "\n" to force wrap like screenshot
  final String location;
  final String sampleDepth;

  const TestInfoCardPerfect({
    super.key,
    this.title = 'Test Information',
    required this.testDate,
    required this.testingMethod,
    required this.location,
    required this.sampleDepth,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 317, // exact to screenshot
      height: 200, // exact to screenshot
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
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
        // tuned insets
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // heading
            Text(
              title,
              style: TextStyle(
                color: AppColors.green,
                fontSize: secondary(), // 16
                fontWeight: FontWeight.w700,
                height: 1.1,
              ),
            ),
            const SizedBox(height: 18),

            // two-column grid (exact gaps)
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // left column
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _InfoItemTight(
                        icon: Icons.calendar_today_outlined,
                        label: 'Test Date',
                        value: testDate,
                        valueSize: secondary(),
                        // 16
                        valueWeight: FontWeight.w500,
                      ),
                      const SizedBox(height: 18),
                      _InfoItemTight(
                        icon: Icons.science_outlined,
                        label: 'Testing Method',
                        value: testingMethod,
                        // 'Laboratory\nAnalysis'
                        valueSize: primary(),
                        // 18
                        valueWeight: FontWeight.w500,
                        wrapWidth: 135,
                        // forces the same 2-line break
                        maxLines: 2,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 26), // column gap matched to image
                // right column
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _InfoItemTight(
                        icon: Icons.location_on_outlined,
                        label: 'Location',
                        value: location,
                        valueSize: secondary(),
                        // 16
                        valueWeight: FontWeight.w500,
                        wrapWidth: 135,
                      ),
                      const SizedBox(height: 18),
                      _InfoItemTight(
                        icon: Icons.straighten,
                        // ruler
                        label: 'Sample Depth',
                        value: sampleDepth,
                        valueSize: secondary(),
                        // 16
                        valueWeight: FontWeight.w500,
                        wrapWidth: 135,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoItemTight extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final double valueSize;
  final FontWeight valueWeight;
  final int maxLines;
  final double? wrapWidth;

  const _InfoItemTight({
    required this.icon,
    required this.label,
    required this.value,
    required this.valueSize,
    required this.valueWeight,
    this.maxLines = 1,
    this.wrapWidth,
  });

  @override
  Widget build(BuildContext context) {
    final valueText = Text(
      value,
      maxLines: maxLines,
      softWrap: true,
      overflow: TextOverflow.visible,
      style: TextStyle(
        color: _textStrong,
        fontSize: valueSize,
        fontWeight: valueWeight,
        height: 1.2,
      ),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // label row
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 18, color: _iconGrey),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                color: _textMuted,
                fontSize: secondary(),
                // 12
                fontWeight: FontWeight.w600,
                height: 1.0,
                letterSpacing: 0.1,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        // value with controlled wrap width to match image
        if (wrapWidth != null)
          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: wrapWidth!),
            child: valueText,
          )
        else
          valueText,
      ],
    );
  }
}
