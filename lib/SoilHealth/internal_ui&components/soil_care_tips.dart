import 'package:flutter/material.dart';
import '../../Theme/AppColors.dart';
import '../../Theme/FontSize.dart';

/// ========================================================
/// SOIL CARE TIPS — Header + Horizontal Cards (PIXEL-PERFECT)
/// ========================================================
class SoilCareTipsHorizontalExact extends StatelessWidget {
  final List<SoilTipItem> items;

  const SoilCareTipsHorizontalExact({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Header (exact sizes/colors)
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            children: [
              Text(
                "Soil Care Tips",
                style: TextStyle(
                  color: AppColors.green,
                  fontSize: primary(), // 14
                  fontWeight: FontWeight.w700,
                  height: 1.1,
                ),
              ),
              const Spacer(),
              Row(
                children: [
                  Text(
                    "View All",
                    style: TextStyle(
                      color: AppColors.green,
                      fontSize: primary(), // 14
                      fontWeight: FontWeight.w600,
                      height: 1.1,
                    ),
                  ),
                  const SizedBox(width: 2),
                  Icon(Icons.chevron_right, size: 18, color: AppColors.green),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 18),

        // Horizontal list
        SizedBox(
          height: 200, // card height
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: items.length,
            separatorBuilder: (_, __) => const SizedBox(width: 12),
            itemBuilder: (context, i) => _TipCardExact(item: items[i]),
          ),
        ),
      ],
    );
  }
}

/// Data model for a tip card
class SoilTipItem {
  final String title;
  final String subtitle;
  final ImageProvider image;

  SoilTipItem({
    required this.title,
    required this.subtitle,
    required this.image,
  });
}

/// ==============================
/// Single Tip Card (pixel-perfect)
/// ==============================
class _TipCardExact extends StatelessWidget {
  final SoilTipItem item;

  const _TipCardExact({required this.item});

  @override
  Widget build(BuildContext context) {
    // neutrals tuned to the mock
    const text900 = Color(0xFF1F2937);
    const text500 = Color(0xFF6B7280);
    const divider = Color(0xFFE9ECEF);

    return Container(
      width: 302, // exact card width from screenshot
      height: 176, // exact card height
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.greyBorder, width: 1),
        boxShadow: const [
          BoxShadow(
            color: Color(0x14000000),
            blurRadius: 12,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // TOP IMAGE (rounded only on top)
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
            child: SizedBox(
              height: 116, // locked
              child: Image(image: item.image, fit: BoxFit.cover),
            ),
          ),
          SizedBox(height: 4),
          // Bottom slab with thin top divider
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(height: 1, color: divider),
                  const SizedBox(height: 8),
                  Text(
                    item.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: secondary(), // 16
                      fontWeight: FontWeight.w700,
                      color: text900,
                      height: 1.1,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    item.subtitle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: tertiary(), // 14
                      fontWeight: FontWeight.w500,
                      color: text500,
                      height: 1.25,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
