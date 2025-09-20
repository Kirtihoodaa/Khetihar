import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khetihar/SoilHealth/main_page/soil_testing_report.dart';
import '../../Theme/AppColors.dart';
import '../../Theme/FontSize.dart';
import '../main_page/upload_report.dart';

/// =======================================
/// EXACT pair of action cards (pixel-perfect)
/// =======================================
class SoilActionCardsExact extends StatelessWidget {
  const SoilActionCardsExact({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () => Get.to(() => UploadReport()),
          child: const _ActionCardExact(
            title: "Upload Report",
            subtitle: "Upload your soil test PDF or image",
            footerIcon: Icons.description_outlined,
            footerText: "PDF, JPG, PNG",
            accent: _AccentSpecExact(
              ringColor: Color(0xFFFF8A00),
              iconColor: Color(0xFFFF8A00),
              softBg: Color(0x1AFF8A00),
              iconData: Icons.cloud_upload_outlined,
            ),
          ),
        ),
        const SizedBox(width: 40),
        GestureDetector(
          onTap: () => Get.to(() => SoilTestingReport()),
          child: const _ActionCardExact(
            title: "Request Testing",
            subtitle: "Book a soil test from a nearby lab",
            footerIcon: Icons.location_on_outlined,
            footerText: "3 labs nearby",
            accent: _AccentSpecExact(
              ringColor: AppColors.green,
              iconColor: AppColors.green,
              softBg: Color(0x145C7814),
              iconData: Icons.science_outlined,
            ),
          ),
        ),
      ],
    );
  }
}

/// ---- Single card (locked geometry) ----
class _ActionCardExact extends StatelessWidget {
  final String title, subtitle, footerText;
  final IconData footerIcon;
  final _AccentSpecExact accent;

  const _ActionCardExact({
    required this.title,
    required this.subtitle,
    required this.footerIcon,
    required this.footerText,
    required this.accent,
  });

  @override
  Widget build(BuildContext context) {
    // neutrals tuned to screenshot
    const text900 = Color(0xFF1F2937);
    const text500 = Color(0xFF6B7280);

    return Container(
      width: 182,
      // card width
      height: 190,
      // card height
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12), // corner radius
        border: Border.all(color: AppColors.greyBorder, width: 1),
        boxShadow: const [
          BoxShadow(
            color: Color(0x12000000),
            blurRadius: 10,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _AccentCircleExact(),
          const SizedBox(height: 12), // spacer baseline
          _AccentCircleExact(spec: accent), // real circle (overlays)
          const SizedBox(height: 16),

          // Title (exact 18)
          Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: primary(), // 18
              color: text900,
              fontWeight: FontWeight.w700,
              height: 1.05,
            ),
          ),
          const SizedBox(height: 12),

          // Subtitle (smaller – exact look)
          Text(
            subtitle,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: tertiary(), // 12
              color: text500,
              fontWeight: FontWeight.w500,
              height: 1.35,
            ),
          ),
          SizedBox(height: 14),
          // Footer row
          Row(
            children: [
              Icon(footerIcon, size: 14, color: text500), // tiny icon
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  footerText,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: tertiary(), // 12
                    color: text500,
                    fontWeight: FontWeight.w600,
                    height: 1.1,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// Accent spec
class _AccentSpecExact {
  final Color ringColor, iconColor, softBg;
  final IconData iconData;

  const _AccentSpecExact({
    required this.ringColor,
    required this.iconColor,
    required this.softBg,
    required this.iconData,
  });
}

/// Circular chip with thin ring (36px, 1.4px stroke, 18px icon)
class _AccentCircleExact extends StatelessWidget {
  final _AccentSpecExact? spec;

  const _AccentCircleExact({this.spec});

  @override
  Widget build(BuildContext context) {
    // when used as spacer (first call), render nothing but keep layout height 0
    if (spec == null) return const SizedBox.shrink();

    return SizedBox(
      width: double.infinity,
      height: 36,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: spec!.softBg,
              shape: BoxShape.circle,
            ),
          ),
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: spec!.ringColor.withOpacity(0.62),
                width: 1.4,
              ),
            ),
          ),
          Icon(spec!.iconData, size: 18, color: spec!.iconColor),
        ],
      ),
    );
  }
}
