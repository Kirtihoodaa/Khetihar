import 'package:flutter/material.dart';
import 'package:khetihar/Components/CustomButton.dart';

import '../../Theme/AppColors.dart';
import '../../Theme/FontSize.dart';

// uses your palette + sizes:
// AppColors.green, AppColors.greyBorder
// secondary()=16, tertiary()=14, medium()=12

// subtle tones to match the screenshot
const _textStrong = Color(0xFF111827);
const _textMuted = Color(0xFF6B7280);
const _softPink = Color(0xFFFDECEC); // low N bg
const _softYellow = Color(0xFFFEF3C7); // organic matter bg
const _softMint = Color(0xFFF1F6EE); // suitable crops bg
const _sectionStroke = Color(0xFFF1F1F1);

class RecSection {
  final String title;
  final List<String> bodyLines; // each line is a separate <Text>
  final String? emphasis; // small bold line at bottom
  final Color background;

  const RecSection({
    required this.title,
    required this.bodyLines,
    this.emphasis,
    required this.background,
  });
}

class RecommendationsCardUltraPerfect extends StatelessWidget {
  final String heading; // "Recommendations"
  final RecSection lowNitrogen; // first block
  final RecSection organicMatter; // second block
  final List<String> crops; // shown in two columns
  final VoidCallback? onBuy;

  // exact card width (matches screenshot)
  final double width;

  const RecommendationsCardUltraPerfect({
    super.key,
    this.heading = 'Recommendations',
    required this.lowNitrogen,
    required this.organicMatter,
    required this.crops,
    this.onBuy,
    this.width = 315,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // ===== main white card =====
          Container(
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
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // heading
                Padding(
                  padding: const EdgeInsets.only(left: 2, bottom: 8),
                  child: Text(
                    heading,
                    style: TextStyle(
                      color: AppColors.green,
                      fontSize: primary(), // 16
                      fontWeight: FontWeight.w700,
                      height: 1.1,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                // section #1
                _SectionCard(section: lowNitrogen),
                const SizedBox(height: 18),

                // section #2
                _SectionCard(section: organicMatter),
                const SizedBox(height: 18),

                // section #3 (Suitable Crops)
                _SectionCard(
                  section: RecSection(
                    title: 'Suitable Crops',
                    bodyLines: const ['This soil is well-suited for growing:'],
                    background: _softMint,
                  ),
                  trailing: _CropsTwoColumn(items: crops),
                ),
              ],
            ),
          ),

          const SizedBox(height: 12),

          // ===== bottom CTA =====
          SizedBox(
            height: 48, // pill height in the screenshot
            child: CustomButton(
              text: "Buy Recommended Products",
              onPressed: onBuy,
              foregroundColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  final RecSection section;
  final Widget? trailing; // optional crops grid

  const _SectionCard({required this.section, this.trailing});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: section.background,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _sectionStroke, width: 1),
      ),
      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // title
          Text(
            section.title,
            style: TextStyle(
              color: _textStrong,
              fontSize: secondary(), // 14
              fontWeight: FontWeight.w700,
              height: 1.1,
            ),
          ),
          const SizedBox(height: 10),

          // lines
          ...section.bodyLines.map(
            (l) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Text(
                l,
                style: TextStyle(
                  color: _textMuted,
                  fontSize: tertiary(), // 14
                  height: 1.45,
                ),
              ),
            ),
          ),

          // emphasis
          if (section.emphasis != null) ...[
            const SizedBox(height: 2),
            Text(
              section.emphasis!,
              style: TextStyle(
                color: _textStrong,
                fontSize: tertiary(), // 14
                fontWeight: FontWeight.w700,
                height: 1.1,
              ),
            ),
          ],

          // trailing content (crops grid)
          if (trailing != null) ...[const SizedBox(height: 10), trailing!],
        ],
      ),
    );
  }
}

class _CropsTwoColumn extends StatelessWidget {
  final List<String> items;

  const _CropsTwoColumn({required this.items});

  @override
  Widget build(BuildContext context) {
    final left = <String>[];
    final right = <String>[];
    for (int i = 0; i < items.length; i++) {
      (i.isEven ? left : right).add(items[i]);
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: _CropCol(items: left)),
        const SizedBox(width: 12),
        Expanded(child: _CropCol(items: right)),
      ],
    );
  }
}

class _CropCol extends StatelessWidget {
  final List<String> items;

  const _CropCol({required this.items});

  @override
  Widget build(BuildContext context) {
    return Column(
      children:
          items
              .map(
                (e) => Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    children: [
                      Icon(
                        Icons.eco_outlined,
                        size: 16,
                        color: AppColors.green,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          e,
                          style: TextStyle(
                            color: _textStrong,
                            fontSize: tertiary(), // 14
                            fontWeight: FontWeight.w600,
                            height: 1.1,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
              .toList(),
    );
  }
}
