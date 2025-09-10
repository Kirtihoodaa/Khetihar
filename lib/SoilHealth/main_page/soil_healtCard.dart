import 'dart:math' as math;
import 'package:flutter/material.dart';

import '../../Theme/AppColors.dart';
import '../../Theme/FontSize.dart';

// Uses your existing helpers (sizes + palette):
// primary()=18, secondary()=16, tertiary()=14, medium()=12
// AppColors.green, AppColors.brown, AppColors.grey, AppColors.greyBorder

class InternalSoilHealthCard extends StatelessWidget {
  final String title; // "Overall Soil Health"
  final String soilType; // "Silty Clay"
  final double scorePercent; // 0..100
  final String statusLabel; // "Moderate"
  final Color? statusColor; // defaults by status
  final double width; // exact px from screenshot
  final double height; // exact px from screenshot
  final double ringSize; // circle px
  final double ringStroke; // circle stroke

  const InternalSoilHealthCard({
    super.key,
    this.title = 'Overall Soil Health',
    required this.soilType,
    required this.scorePercent,
    required this.statusLabel,
    this.statusColor,
    this.width = 315, // screenshot width ≈ 315px
    this.height = 244, // screenshot height ≈ 224px
    this.ringSize = 100,
    this.ringStroke = 8,
  });

  @override
  Widget build(BuildContext context) {
    final clamped = scorePercent.clamp(0, 100).toDouble();
    final Color pillColor = statusColor ?? _statusToColor(statusLabel);

    return SizedBox(
      width: width,
      height: height,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 14, horizontal: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12), // matches screenshot
          border: Border.all(color: AppColors.greyBorder, width: 1),
          boxShadow: const [
            BoxShadow(
              color: Color(0x14000000),
              blurRadius: 8,
              offset: Offset(0, 2),
            ),
          ],
        ),
        // tuned padding
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top row: Title + status pill
            Row(
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: tertiary(), // 12
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF6B7280), // muted label
                      height: 1.1,
                    ),
                  ),
                ),
                _StatusPill(text: statusLabel, color: pillColor),
              ],
            ),
            const SizedBox(height: 6),

            // Soil Type (bold)
            Text(
              soilType,
              style: TextStyle(
                fontSize: primary(), // 18
                fontWeight: FontWeight.w700,
                color: const Color(0xFF111827),
                height: 1.1,
              ),
            ),

            const Spacer(),

            // Circular score + caption
            Align(
              alignment: Alignment.center, // matches visual composition
              child: SizedBox(
                width: ringSize,
                height: ringSize,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    CustomPaint(
                      size: Size(ringSize, ringSize),
                      painter: _RingProgressPainter(
                        percent: clamped / 100.0,
                        progressColor: AppColors.green,
                        trackColor: const Color(0xFFE5E7EB),
                        // light grey track
                        strokeWidth: ringStroke,
                        startAngle: -math.pi / 2,
                        // starts at top
                        cap: StrokeCap.round,
                      ),
                    ),
                    Text(
                      '${clamped.toStringAsFixed(0)}%',
                      style: TextStyle(
                        fontSize: primary(), // 18
                        fontWeight: FontWeight.w700,
                        color: AppColors.green,
                        height: 1.0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 18),

            Align(
              alignment: Alignment.center,
              child: Text(
                'Soil Health Score',
                style: TextStyle(
                  fontSize: tertiary(), // 12
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF6B7280),
                  height: 1.1,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Color _statusToColor(String s) {
    final t = s.toLowerCase().trim();
    if (t.contains('good') || t.contains('healthy')) {
      return const Color(0xFF2E7D32);
    }
    if (t.contains('poor') || t.contains('low')) return const Color(0xFFD90429);
    // default to the warm orange used in your UI
    return const Color(0xFFE37D3A);
  }
}

class _StatusPill extends StatelessWidget {
  final String text;
  final Color color;

  const _StatusPill({required this.text, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 26,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(
          16,
        ), // pill radius matching screenshot
      ),
      alignment: Alignment.center,
      child: Text(
        text,
        style: TextStyle(
          color: Colors.white,
          fontSize: tertiary(), // 14 (slightly condensed in pill)
          fontWeight: FontWeight.w700,
          height: 1.0,
        ),
      ),
    );
  }
}

class _RingProgressPainter extends CustomPainter {
  final double percent; // 0..1
  final Color progressColor;
  final Color trackColor;
  final double strokeWidth;
  final double startAngle; // radians
  final StrokeCap cap;

  _RingProgressPainter({
    required this.percent,
    required this.progressColor,
    required this.trackColor,
    required this.strokeWidth,
    required this.startAngle,
    this.cap = StrokeCap.round,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final center = rect.center;
    final radius = (math.min(size.width, size.height) - strokeWidth) / 2;

    final track =
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = strokeWidth
          ..strokeCap = StrokeCap.round
          ..color = trackColor;

    final progress =
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = strokeWidth
          ..strokeCap = cap
          ..color = progressColor;

    // Track (full circle)
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      0,
      math.pi * 2,
      false,
      track,
    );

    // Progress arc
    final sweep = (math.pi * 2) * percent;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      sweep,
      false,
      progress,
    );
  }

  @override
  bool shouldRepaint(covariant _RingProgressPainter oldDelegate) {
    return oldDelegate.percent != percent ||
        oldDelegate.progressColor != progressColor ||
        oldDelegate.trackColor != trackColor ||
        oldDelegate.strokeWidth != strokeWidth ||
        oldDelegate.startAngle != startAngle ||
        oldDelegate.cap != cap;
  }
}
