import 'package:flutter/material.dart';

import '../../Theme/AppColors.dart';
import '../../Theme/FontSize.dart';

// Uses your helpers:
// AppColors.green, secondary()=16, tertiary()=14, medium()=12

const _textStrong = Color(0xFF111827);
const _textMuted = Color(0xFF6B7280);
const _bubbleOrange = Color(0xFFFEEAD5);
const _orangeIcon = Color(0xFFE37D3A);

class LabItem {
  final String name; // e.g., "Krishi Vigyan Kendra"
  final String type; // e.g., "Government" / "Private"
  final String distanceKm; // e.g., "3.8 km"
  final IconData icon;
  final Color bubbleColor;
  final Color iconColor;

  const LabItem({
    required this.name,
    required this.type,
    required this.distanceKm,
    this.icon = Icons.biotech_outlined,
    this.bubbleColor = _bubbleOrange,
    this.iconColor = _orangeIcon,
  });
}

class NearbyTestingLabsPerfect extends StatelessWidget {
  final String heading; // "Nearby Testing Labs"
  final List<LabItem> labs; // 2 items as in screenshot
  final double width; // exact card width
  final EdgeInsets padding;

  const NearbyTestingLabsPerfect({
    super.key,
    this.heading = 'Nearby Testing Labs',
    required this.labs,
    this.width = 317, // screenshot ~317 px
    this.padding = const EdgeInsets.fromLTRB(16, 16, 16, 16),
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Padding(
        padding: padding,
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
                  fontSize: primary(), // 16
                  fontWeight: FontWeight.w700,
                  height: 1.1,
                ),
              ),
            ),
            SizedBox(height: 18),
            // Items
            ...List.generate(labs.length, (i) {
              final isLast = i == labs.length - 1;
              return Padding(
                padding: EdgeInsets.only(bottom: isLast ? 0 : 30),
                child: _LabRow(item: labs[i]),
              );
            }),
          ],
        ),
      ),
    );
  }
}

class _LabRow extends StatelessWidget {
  final LabItem item;

  const _LabRow({required this.item});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Bubble icon (exact sizing)
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: item.bubbleColor,
            shape: BoxShape.circle,
          ),
          alignment: Alignment.center,
          child: Icon(item.icon, size: 25, color: item.iconColor),
        ),
        const SizedBox(width: 14),

        // Texts
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Name
              Text(
                item.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: _textStrong,
                  fontSize: secondary() + 1, // 15 for precise visual weight
                  fontWeight: FontWeight.w700,
                  height: 1.1,
                ),
              ),
              const SizedBox(height: 4),

              // Type • Distance
              Row(
                children: [
                  Flexible(
                    child: Text(
                      item.type,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: _textMuted,
                        fontSize: tertiary(), // 12
                        fontWeight: FontWeight.w600,
                        height: 1.0,
                      ),
                    ),
                  ),
                  const SizedBox(width: 6),
                  _Dot(),
                  const SizedBox(width: 6),
                  Text(
                    item.distanceKm,
                    style: TextStyle(
                      color: _textMuted,
                      fontSize: tertiary(), // 12
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
    );
  }
}

class _Dot extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 4,
      height: 4,
      decoration: const BoxDecoration(
        color: _textMuted,
        shape: BoxShape.circle,
      ),
    );
  }
}
