import 'dart:math' as math;
import 'package:flutter/material.dart';

import '../../Theme/AppColors.dart';
import '../../Theme/FontSize.dart';

// Uses your helpers already in the project:
// AppColors.green, AppColors.brown, AppColors.greyBorder
// secondary()=16, tertiary()=14, medium()=12

// extra tones to match the image exactly
const _siltColor = Color(0xFFC89D6B);
const _sandColor = Color(0xFFF0D9A8);
const _textStrong = Color(0xFF111827);
const _textMuted = Color(0xFF6B7280);

class CompositionSlice {
  final String label; // e.g. 'Clay'
  final double percent; // 0..100
  final Color color; // segment color
  const CompositionSlice(this.label, this.percent, this.color);
}

class SoilCompositionCardPerfect extends StatelessWidget {
  final String title;
  final List<CompositionSlice> slices; // order drawn clockwise
  final String description;

  // exact card size to mirror screenshot
  final double width;
  final double height;

  // donut specs tuned to screenshot
  final double donutSize; // outer diameter
  final double donutThickness; // ring thickness
  final double segmentGapDeg; // thin separators between segments
  final double leadWedgeDeg; // single larger white wedge (bottom-right in shot)

  const SoilCompositionCardPerfect({
    super.key,
    this.title = 'Soil Composition',
    required this.slices,
    required this.description,
    this.width = 316,
    this.height = 365,
    this.donutSize = 146, // bigger & centered now
    this.donutThickness = 34, // thicker ring
    this.segmentGapDeg = 4, // slim separators
    this.leadWedgeDeg = 22, // the visible white wedge
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
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
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            Text(
              title,
              style: TextStyle(
                color: AppColors.green,
                fontSize: primary(), // 16
                fontWeight: FontWeight.w700,
                height: 1.1,
              ),
            ),
            const SizedBox(height: 18),

            // Donut (centered) + Legend
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Center the donut in its half
                SizedBox(
                  width: 250,
                  height: donutSize,
                  child: CustomPaint(
                    painter: _DonutPainter(
                      slices: slices,
                      thickness: donutThickness,
                      segmentGapRad: segmentGapDeg * math.pi / 180,
                      leadWedgeRad: leadWedgeDeg * math.pi / 180,
                      startAngle: -math.pi / 2, // 12 o'clock
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                // Legend
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:
                        slices.map((s) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 6),
                            child: _LegendItem(
                              color: s.color,
                              text:
                                  '${s.label}: ${s.percent.toStringAsFixed(0)}%',
                            ),
                          );
                        }).toList(),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 18),

            // Description paragraph
            Text(
              description,
              style: TextStyle(
                color: _textMuted,
                fontSize: secondary(), // 14
                height: 1.45,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LegendItem extends StatelessWidget {
  final Color color;
  final String text;

  const _LegendItem({required this.color, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white, width: 1),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              color: _textStrong,
              fontSize: tertiary(), // 14
              fontWeight: FontWeight.w600,
              height: 1.1,
            ),
          ),
        ),
      ],
    );
  }
}

class _DonutPainter extends CustomPainter {
  final List<CompositionSlice> slices;
  final double thickness;
  final double segmentGapRad; // small gaps between slices
  final double leadWedgeRad; // one larger wedge (visible)
  final double startAngle;

  _DonutPainter({
    required this.slices,
    required this.thickness,
    required this.segmentGapRad,
    required this.leadWedgeRad,
    required this.startAngle,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final c = rect.center;
    final radius = (math.min(size.width, size.height) - thickness) / 2;

    // white ring base
    final track =
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = thickness
          ..strokeCap = StrokeCap.butt
          ..color = Colors.white;
    canvas.drawCircle(c, radius, track);

    // compute total angles with one leading wedge + thin gaps between segments
    final totalPct = slices.fold<double>(0, (a, b) => a + b.percent);
    final gapsBetween = math.max(0, slices.length - 1);
    final totalGaps = segmentGapRad * gapsBetween + leadWedgeRad;
    final usable = (2 * math.pi) - totalGaps;

    double angle = startAngle + leadWedgeRad; // leave the visible wedge first
    for (int i = 0; i < slices.length; i++) {
      final s = slices[i];
      final proportion = totalPct == 0 ? 0 : (s.percent / totalPct);
      final sweep = usable * proportion;

      final arcPaint =
          Paint()
            ..style = PaintingStyle.stroke
            ..strokeWidth = thickness
            ..strokeCap = StrokeCap.butt
            ..color = s.color;

      canvas.drawArc(
        Rect.fromCircle(center: c, radius: radius),
        angle,
        sweep,
        false,
        arcPaint,
      );

      angle += sweep;
      if (i != slices.length - 1) angle += segmentGapRad; // small separator
    }
  }

  @override
  bool shouldRepaint(covariant _DonutPainter old) {
    return old.slices != slices ||
        old.thickness != thickness ||
        old.segmentGapRad != segmentGapRad ||
        old.leadWedgeRad != leadWedgeRad ||
        old.startAngle != startAngle;
  }
}
