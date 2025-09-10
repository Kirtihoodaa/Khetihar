import 'package:flutter/material.dart';
import 'package:khetihar/Components/CustomButton.dart';
import '../../Theme/AppColors.dart';
import '../../Theme/FontSize.dart';

/// EXACT pixel-spec pulled from the screenshot
class SoilHealthCard extends StatelessWidget {
  const SoilHealthCard({super.key});

  @override
  Widget build(BuildContext context) {
    // extra neutrals used in the image
    const Color text900 = Color(0xFF1F2937); // title
    const Color text500 = Color(0xFF6B7280); // captions/icons
    const Color trackBg = Color(0xFFF0F2F5); // meter track
    const Color donutTrack = Color(0xFFE6E7EA); // outer ring gray
    const Color warnYellow = Color(
      0xFFE5B600,
    ); // yellow seen in bars/percent text

    return Container(
      width: 360,
      // screenshot width scale reference (card inner ~ 328)
      margin: const EdgeInsets.all(12),
      padding: const EdgeInsets.symmetric(vertical: 22, horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.greyBorder),
        boxShadow: const [
          BoxShadow(
            color: Color(0x14000000),
            blurRadius: 12,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // HEADER
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Overall Soil Health",
                      style: TextStyle(
                        fontSize: medium(),
                        color: text500,
                        fontWeight: FontWeight.w600,
                        height: 1.1,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      "Clay Loam",
                      style: TextStyle(
                        fontSize: primary(),
                        color: text900,
                        fontWeight: FontWeight.w700,
                        height: 1.15,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 28,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: AppColors.green,
                  borderRadius: BorderRadius.circular(18),
                ),
                alignment: Alignment.center,
                child: Text(
                  "Good",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: tertiary(),
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // DONUT + METERS
          Column(
            children: [
              SizedBox(
                width: 116,
                height: 116,
                child: _DonutPercent(
                  percent: 0.75,
                  ringWidth: 10,
                  startAngleDeg: -35,
                  // slight tilt like screenshot
                  activeColor: AppColors.green,
                  trackColor: donutTrack,
                  centerTextStyle: TextStyle(
                    color: AppColors.green,
                    fontWeight: FontWeight.w800,
                    fontSize: primary(),
                    height: 1,
                  ),
                ),
              ),
              const SizedBox(height: 22),
              Row(
                children: const [
                  _Meter(
                    title: "pH",
                    icon: Icons.opacity_outlined,
                    valueText: "6.5",
                    valueColor: AppColors.green,
                    fillColor: AppColors.green,
                    percent: 0.60,
                  ),
                  SizedBox(width: 14),
                  _Meter(
                    title: "N",
                    icon: Icons.water_drop_outlined,
                    valueText: "30%",
                    valueColor: AppColors.red,
                    fillColor: AppColors.red,
                    percent: 0.30,
                  ),
                  SizedBox(width: 14),
                  _Meter(
                    title: "P",
                    icon: Icons.science_outlined,
                    valueText: "65%",
                    valueColor: warnYellow,
                    fillColor: warnYellow,
                    percent: 0.65,
                  ),
                  SizedBox(width: 14),
                  _Meter(
                    title: "K",
                    icon: Icons.science_outlined,
                    valueText: "85%",
                    valueColor: AppColors.green,
                    fillColor: AppColors.green,
                    percent: 0.85,
                  ),
                  SizedBox(width: 14),
                  _Meter(
                    title: "Organic",
                    icon: Icons.eco_outlined,
                    valueText: "45%",
                    valueColor: warnYellow,
                    fillColor: warnYellow,
                    percent: 0.45,
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 18),

          // META
          const _Meta(
            icon: Icons.calendar_today_outlined,
            text: "Last Test: 15 Jun 2025",
          ),
          const SizedBox(height: 6),
          const _Meta(
            icon: Icons.location_on_outlined,
            text: "Field: East Plot",
          ),

          const SizedBox(height: 18),

          // CTA
          SizedBox(
            width: double.infinity,
            height: 46,
            child: CustomButton(
              text: "View Detailed Report",
              onPressed: () {},
              foregroundColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

/// Donut with rounded caps and slight tilt to match art
class _DonutPercent extends StatelessWidget {
  final double percent; // 0..1
  final double ringWidth;
  final double startAngleDeg;
  final Color activeColor;
  final Color trackColor;
  final TextStyle centerTextStyle;

  const _DonutPercent({
    required this.percent,
    required this.ringWidth,
    required this.startAngleDeg,
    required this.activeColor,
    required this.trackColor,
    required this.centerTextStyle,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _DonutPainter(
        percent: percent,
        ringWidth: ringWidth,
        startAngleDeg: startAngleDeg,
        activeColor: activeColor,
        trackColor: trackColor,
      ),
      child: Center(
        child: Text("${(percent * 100).round()}%", style: centerTextStyle),
      ),
    );
  }
}

class _DonutPainter extends CustomPainter {
  final double percent, ringWidth, startAngleDeg;
  final Color activeColor, trackColor;

  _DonutPainter({
    required this.percent,
    required this.ringWidth,
    required this.startAngleDeg,
    required this.activeColor,
    required this.trackColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final radius = (size.shortestSide / 2) - ringWidth / 2;
    final start = startAngleDeg * (3.1415926535 / 180);

    final paint =
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = ringWidth
          ..strokeCap = StrokeCap.round;

    // Full gray ring
    paint.color = trackColor;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      start,
      2 * 3.1415926535,
      false,
      paint,
    );

    // Green progress arc
    paint.color = activeColor;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      start,
      (2 * 3.1415926535) * percent,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant _DonutPainter old) =>
      old.percent != percent ||
      old.ringWidth != ringWidth ||
      old.activeColor != activeColor ||
      old.trackColor != trackColor ||
      old.startAngleDeg != startAngleDeg;
}

/// Single vertical meter, with track/rounded fill and tiny top highlight cap like the image
class _Meter extends StatelessWidget {
  final String title;
  final IconData icon;
  final String valueText;
  final Color valueColor;
  final Color fillColor;
  final double percent;

  const _Meter({
    required this.title,
    required this.icon,
    required this.valueText,
    required this.valueColor,
    required this.fillColor,
    required this.percent,
  });

  @override
  Widget build(BuildContext context) {
    const double trackW = 28;
    const double trackH = 120;
    const double radius = 12;
    const Color caption = Color(0xFF6B7280);
    const Color track = Color(0xFFF0F2F5);

    return SizedBox(
      width: 62,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: small(),
                  color: caption,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(width: 2),
              Icon(icon, size: 14, color: caption),
            ],
          ),
          const SizedBox(height: 6),
          SizedBox(
            width: trackW,
            height: trackH,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                // track
                Container(
                  width: trackW,
                  height: trackH,
                  decoration: BoxDecoration(
                    color: track,
                    borderRadius: BorderRadius.circular(radius),
                  ),
                ),
                // top soft cap (faint gray halo visible on P/K)
                Positioned(
                  top: 0,
                  child: Container(
                    width: trackW,
                    height: 18,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.20),
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(radius),
                      ),
                    ),
                  ),
                ),
                // fill (rounded even when short)
                LayoutBuilder(
                  builder: (_, c) {
                    final h = (c.maxHeight * percent.clamp(0.0, 1.0));
                    return Container(
                      width: trackW,
                      height: h,
                      decoration: BoxDecoration(
                        color: fillColor,
                        borderRadius: BorderRadius.circular(radius),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 6),
          Text(
            valueText,
            style: TextStyle(
              fontSize: small(),
              fontWeight: FontWeight.w800,
              color: valueColor,
              height: 1.2,
            ),
          ),
        ],
      ),
    );
  }
}

class _Meta extends StatelessWidget {
  final IconData icon;
  final String text;

  const _Meta({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    const Color meta = Color(0xFF6B7280);
    return Row(
      children: [
        Icon(icon, size: 16, color: meta),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: tertiary(),
              color: meta,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
