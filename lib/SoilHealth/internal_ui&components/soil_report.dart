import 'package:flutter/material.dart';
import '../../Theme/AppColors.dart';
import '../../Theme/FontSize.dart';

// ===============================
// MY SOIL REPORTS (exact section)
// ===============================
class MySoilReportsSectionExact extends StatelessWidget {
  const MySoilReportsSectionExact({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 320, // matches screenshot scale
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: Text(
              "My Soil Reports",
              style: TextStyle(
                color: AppColors.green,
                fontSize: primary(), // 14
                fontWeight: FontWeight.w700,
                height: 1.1,
              ),
            ),
          ),
          const SizedBox(height: 18),

          // Items
          const _SoilReportItemExact(
            date: "15 Jun 2023",
            field: "East Plot",
            statusLabel: "Good",
            statusColor: AppColors.green,
            tileTint: Color(0x145C7814),
            // light green tint
            tileStroke: Color(0x335C7814),
            iconColor: AppColors.green,
          ),
          const SizedBox(height: 10),
          const _SoilReportItemExact(
            date: "03 Mar 2023",
            field: "West Field",
            statusLabel: "Poor",
            statusColor: Color(0xFFE64B3C),
            // soft red (closer to mock). Add if you want.
            tileTint: Color(0x14E64B3C),
            tileStroke: Color(0x33E64B3C),
            iconColor: Color(0xFFE64B3C),
          ),
        ],
      ),
    );
  }
}

// ===================================
// Single List Row (pixel-perfect)
// ===================================
class _SoilReportItemExact extends StatelessWidget {
  final String date, field, statusLabel;
  final Color statusColor, tileTint, tileStroke, iconColor;

  const _SoilReportItemExact({
    required this.date,
    required this.field,
    required this.statusLabel,
    required this.statusColor,
    required this.tileTint,
    required this.tileStroke,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    const text900 = Color(0xFF1F2937);
    const text500 = Color(0xFF6B7280);

    return Container(
      height: 66, // locked row height
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.greyBorder, width: 1),
        boxShadow: const [
          BoxShadow(
            color: Color(0x12000000),
            blurRadius: 10,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          // Leading icon tile
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: tileTint,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: tileStroke, width: 1),
            ),
            alignment: Alignment.center,
            child: Icon(Icons.description_outlined, size: 22, color: iconColor),
          ),
          const SizedBox(width: 12),

          // Date + field + status chip
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Date + chip
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        date,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: secondary(), // 16
                          fontWeight: FontWeight.w700,
                          color: text900,
                          height: 1.1,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    _StatusChip(label: statusLabel, color: statusColor),
                  ],
                ),
                const SizedBox(height: 2),
                Text(
                  field,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: tertiary(), // 14
                    fontWeight: FontWeight.w500,
                    color: text500,
                    height: 1.2,
                  ),
                ),
              ],
            ),
          ),

          // Trailing "View"
          const SizedBox(width: 10),
          Text(
            "View",
            style: TextStyle(
              color: AppColors.green,
              fontSize: tertiary(), // 14
              fontWeight: FontWeight.w700,
              height: 1.1,
            ),
          ),
        ],
      ),
    );
  }
}

// Status pill (Good/Poor)
class _StatusChip extends StatelessWidget {
  final String label;
  final Color color;

  const _StatusChip({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 24,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(14),
      ),
      alignment: Alignment.center,
      child: Text(
        label,
        style: TextStyle(
          color: Colors.white,
          fontSize: tertiary(), // 10
          fontWeight: FontWeight.w700,
          letterSpacing: 0.2,
        ),
      ),
    );
  }
}
