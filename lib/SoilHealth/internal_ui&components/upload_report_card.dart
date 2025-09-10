// === Very small additions to match the screenshot exactly ===
import 'package:flutter/material.dart';
import 'package:khetihar/Components/CustomButton.dart';

import '../../Theme/AppColors.dart';
import '../../Theme/FontSize.dart';

const _textMuted = Color(0xFF6B7280); // subtle gray for paragraph
const _dashedBorder = Color(0xFFE5E7EB); // light gray dashed outline
const _uploadBg = Color(0xFFFEEAD5); // warm peach behind the upload icon
const _uploadIcon = Color(0xFFE37D3A); // orange upload icon

/// Pixel-perfect card for: "Upload Soil Test Report"
class UploadSoilTestCard extends StatelessWidget {
  final VoidCallback? onBrowse;
  final VoidCallback? onTapDropzone;

  const UploadSoilTestCard({super.key, this.onBrowse, this.onTapDropzone});

  @override
  Widget build(BuildContext context) {
    // Fixed sizing to match screenshot closely
    return Container(
      width: 323,
      // screenshot width
      height: 400,
      // screenshot height
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.greyBorder),
        boxShadow: const [
          BoxShadow(
            color: Color(0x14000000),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          Text(
            'Upload Soil Test Report',
            style: TextStyle(
              color: AppColors.green,
              fontSize: primary(),
              fontWeight: FontWeight.w600,
              height: 1.1,
            ),
          ),
          const SizedBox(height: 6),
          // Subtitle paragraph
          Text(
            'Upload your soil test report to get personalized\nrecommendations for your crops.',
            style: TextStyle(
              color: _textMuted,
              fontSize: tertiary(),
              height: 1.35,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 30),

          // Dropzone (dashed rounded rect)
          _DashedBorderContainer(
            radius: 14,
            dashLength: 6,
            gapLength: 6,
            strokeWidth: 1.4,
            color: _dashedBorder,
            child: InkWell(
              borderRadius: BorderRadius.circular(14),
              onTap: onTapDropzone ?? onBrowse,
              child: Container(
                width: double.infinity,
                height: 196,
                // visually matches screenshot proportion
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Circular icon
                    Container(
                      width: 66,
                      height: 66,
                      decoration: const BoxDecoration(
                        color: _uploadBg,
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: Icon(
                        Icons.cloud_upload_outlined,
                        size: 38,
                        color: _uploadIcon,
                      ),
                    ),
                    const SizedBox(height: 12),

                    // "Drag files here or tap to browse"
                    Text(
                      'Drag files here or tap to browse',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: secondary(),
                        fontWeight: FontWeight.w600,
                        height: 1.25,
                      ),
                    ),
                    const SizedBox(height: 6),

                    // formats hint
                    Text(
                      'We accept PDF, JPG, or PNG formats',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: _textMuted,
                        fontSize: tertiary(),
                        height: 1.25,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          SizedBox(height: 26),

          // Browse Files CTA
          Center(
            child: SizedBox(
              height: 50,
              width: 180,
              child: CustomButton(
                text: "Browse Files",
                onPressed: onBrowse,
                foregroundColor: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Draws a rounded-rect dashed border that hugs its child (pixel-perfect).
class _DashedBorderContainer extends StatelessWidget {
  final Widget child;
  final double radius;
  final double dashLength;
  final double gapLength;
  final double strokeWidth;
  final Color color;

  const _DashedBorderContainer({
    required this.child,
    required this.radius,
    required this.dashLength,
    required this.gapLength,
    required this.strokeWidth,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _DashedBorderPainter(
        radius: radius,
        dashLength: dashLength,
        gapLength: gapLength,
        strokeWidth: strokeWidth,
        color: color,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radius),
        child: child,
      ),
    );
  }
}

class _DashedBorderPainter extends CustomPainter {
  final double radius;
  final double dashLength;
  final double gapLength;
  final double strokeWidth;
  final Color color;

  _DashedBorderPainter({
    required this.radius,
    required this.dashLength,
    required this.gapLength,
    required this.strokeWidth,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final rrect = RRect.fromRectAndRadius(
      Offset.zero & size,
      Radius.circular(radius),
    );

    final paint =
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = strokeWidth
          ..color = color;

    final path = Path()..addRRect(rrect);
    for (final metric in path.computeMetrics()) {
      double distance = 0;
      while (distance < metric.length) {
        final double next = distance + dashLength;
        final extract = metric.extractPath(
          distance,
          next.clamp(0, metric.length),
        );
        canvas.drawPath(extract, paint);
        distance += dashLength + gapLength;
      }
    }
  }

  @override
  bool shouldRepaint(covariant _DashedBorderPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.radius != radius ||
        oldDelegate.dashLength != dashLength ||
        oldDelegate.gapLength != gapLength ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
