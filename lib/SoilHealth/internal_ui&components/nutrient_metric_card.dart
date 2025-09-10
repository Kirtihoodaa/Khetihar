import 'dart:math' as math;
import 'package:flutter/material.dart';

import '../../Theme/AppColors.dart';
import '../../Theme/FontSize.dart';

// expects your helpers to exist in the project:
// AppColors.green, AppColors.grey, AppColors.greyBorder
// primary()=18, secondary()=16, tertiary()=14, medium()=12

const _textStrong = Color(0xFF111827);
const _textMuted = Color(0xFF6B7280);
const _track = Color(0xFFF1F5F9); // very light track (soft)
const _idealBand = Color(0xFFE5E7EB); // light grey ideal window

// Tracks & bands tuned to screenshot
const _trackGrey = Color(0xFFE5E7EB); // base track
const _idealGrey = Color(0xFFD1D5DB); // ideal window band

// Status colors locked to image
const _red = Color(0xFFD90429);
const _amber = Color(0xFFF59E0B); // label + numeric "Medium"
const _green = Colors.green; // your AppColors.green, echoed here for clarity

class NutrientMetric {
  final IconData icon;
  final String label; // e.g. 'Nitrogen (N)'
  final double value; // 0..scaleMax (or %)
  final String rightUnit; // '%', '', etc.—shown with right value
  final double idealMin; // ideal lower bound
  final double idealMax; // ideal upper bound
  final double scaleMax; // 100 for %, 14 for pH, etc.
  final Color barColor; // fill color of the bar
  final Color? trackColor; // default _trackGrey; override for pH row
  final bool showIdealBand; // pH hides it in screenshot
  final String? statusText; // 'Optimal' / 'low' / 'Medium' / 'High'
  final Color? statusColor; // color for status text
  final Color? rightValueColor; // color for right numeric value

  const NutrientMetric({
    required this.icon,
    required this.label,
    required this.value,
    required this.rightUnit,
    required this.idealMin,
    required this.idealMax,
    required this.scaleMax,
    required this.barColor,
    this.trackColor,
    this.showIdealBand = true,
    this.statusText,
    this.statusColor,
    this.rightValueColor,
  });
}

class NutrientProfileCardPerfect extends StatelessWidget {
  final String title;
  final List<NutrientMetric> metrics;

  const NutrientProfileCardPerfect({
    super.key,
    this.title = 'Nutrient Profile',
    required this.metrics,
  });

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints.tightFor(width: 317), // exact width
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
        padding: const EdgeInsets.fromLTRB(12, 10, 12, 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            Padding(
              padding: const EdgeInsets.only(left: 2, bottom: 6),
              child: Text(
                title,
                style: TextStyle(
                  color: AppColors.green,
                  fontSize: primary(), // 16
                  fontWeight: FontWeight.w700,
                  height: 1.1,
                ),
              ),
            ),
            SizedBox(height: 13),
            // Metrics
            ...List.generate(metrics.length, (i) {
              final isLast = i == metrics.length - 1;
              return Padding(
                padding: EdgeInsets.only(bottom: isLast ? 0 : 20),
                child: _MetricBlock(metric: metrics[i]),
              );
            }),
          ],
        ),
      ),
    );
  }
}

class _MetricBlock extends StatelessWidget {
  final NutrientMetric metric;

  const _MetricBlock({required this.metric});

  @override
  Widget build(BuildContext context) {
    final double v = metric.value.clamp(0.0, metric.scaleMax).toDouble();

    final rightText =
        metric.rightUnit.isEmpty
            ? (v % 1 == 0 ? v.toStringAsFixed(0) : v.toStringAsFixed(1))
            : '${v.toStringAsFixed(0)}${metric.rightUnit}';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Row 1: icon + label  |  right value
        Row(
          children: [
            Row(
              children: [
                Icon(metric.icon, size: 20, color: _textMuted), // 16px icon
                const SizedBox(width: 8),
                Text(
                  metric.label,
                  style: TextStyle(
                    color: _textStrong,
                    fontSize: secondary(), // 14
                    fontWeight: FontWeight.w600, // semibold (not heavy)
                    height: 1.1,
                  ),
                ),
              ],
            ),
            const Spacer(),
            Text(
              rightText,
              style: TextStyle(
                color: metric.rightValueColor ?? _rightColorAuto(metric),
                fontSize: secondary(), // 14
                fontWeight: FontWeight.w700, // bold numeric
                height: 1.1,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),

        // Row 2: progress bar (16px height, fully rounded)
        _IdealProgressBar(
          value: v,
          scaleMax: metric.scaleMax,
          barColor: metric.barColor,
          trackColor: metric.trackColor ?? _trackGrey,
          showIdeal: metric.showIdealBand,
          idealMin: metric.idealMin,
          idealMax: metric.idealMax,
        ),
        const SizedBox(height: 6),

        // Row 3: Ideal range | Status
        Row(
          children: [
            Text(
              metric.rightUnit == '%'
                  ? 'Ideal Range: ${metric.idealMin.toStringAsFixed(0)}% - ${metric.idealMax.toStringAsFixed(0)}%'
                  : 'Ideal Range: ${_fmt(metric.idealMin)} - ${_fmt(metric.idealMax)}',
              style: TextStyle(
                color: _textMuted,
                fontSize: secondary(), // 12
                fontWeight: FontWeight.w600,
                height: 1.0,
              ),
            ),
            const Spacer(),
            Text(
              metric.statusText ?? _statusAuto(metric),
              style: TextStyle(
                color: metric.statusColor ?? _statusColorAuto(metric),
                fontSize: medium(), // 12
                fontWeight: FontWeight.w700,
                height: 1.0,
              ),
            ),
          ],
        ),
      ],
    );
  }

  static String _fmt(double v) =>
      v % 1 == 0 ? v.toStringAsFixed(0) : v.toStringAsFixed(1);

  static String _statusAuto(NutrientMetric m) {
    if (m.value < m.idealMin) return 'low';
    if (m.value > m.idealMax) return 'High';
    return 'Medium';
  }

  static Color _statusColorAuto(NutrientMetric m) {
    if (m.value < m.idealMin) return _red;
    if (m.value > m.idealMax) return _green;
    return _amber;
  }

  static Color _rightColorAuto(NutrientMetric m) {
    // Right numeric color mirrors screenshot behavior
    if (m.value < m.idealMin) return _red;
    if (m.value > m.idealMax) return _green;
    // in-range: for pH they used green, for others 'Medium' shows amber
    return m.rightUnit.isEmpty ? _green : _amber;
  }
}

class _IdealProgressBar extends StatelessWidget {
  final double value;
  final double scaleMax;
  final Color barColor;
  final Color trackColor;
  final bool showIdeal;
  final double idealMin;
  final double idealMax;

  const _IdealProgressBar({
    required this.value,
    required this.scaleMax,
    required this.barColor,
    required this.trackColor,
    required this.showIdeal,
    required this.idealMin,
    required this.idealMax,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, c) {
        final width = c.maxWidth;
        final h = 26.0;
        final r = h / 2;

        // positions
        final fillW = (value / scaleMax).clamp(0.0, 1.0) * width;
        final idealL = (idealMin / scaleMax).clamp(0.0, 1.0) * width;
        final idealR = (idealMax / scaleMax).clamp(0.0, 1.0) * width;

        return SizedBox(
          height: h,
          child: Stack(
            children: [
              // track
              Container(
                width: width,
                height: h,
                decoration: BoxDecoration(
                  color: trackColor,
                  borderRadius: BorderRadius.circular(r),
                ),
              ),
              if (showIdeal)
                // ideal band
                Positioned(
                  left: idealL,
                  width: (idealR - idealL).clamp(0.0, width),
                  top: 0,
                  bottom: 0,
                  child: Container(
                    decoration: BoxDecoration(
                      color: _idealGrey,
                      borderRadius: BorderRadius.circular(r),
                    ),
                  ),
                ),
              // fill
              Container(
                width: fillW,
                height: h,
                decoration: BoxDecoration(
                  color: barColor,
                  borderRadius: BorderRadius.circular(r),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
