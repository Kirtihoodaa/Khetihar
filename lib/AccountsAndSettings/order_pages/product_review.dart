import 'package:flutter/material.dart';
import 'package:khetihar/Components/CustomAppBar.dart';
import 'package:flutter/material.dart';
import 'package:khetihar/Components/CustomButton.dart';
import '../../Theme/AppColors.dart';
import '../../Theme/FontSize.dart';

class ProductReview extends StatelessWidget {
  const ProductReview({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: KCenteredActionsAppBar(
        title: "Review Product",
        avatarImage: AssetImage("Assets/HomeScreens/Logo.png"),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            ReviewUploadSection(
              productName: "Wheat",
              thumb: AssetImage("Assets/Seeds/OilSeed.png"),
            ),
            SizedBox(height: 16),
            WriteReviewBlock(height: 150),
            SizedBox(height: 22),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 40),
              width: double.infinity,
              child: CustomButton(
                foregroundColor: Colors.white,
                text: "Submit Review",
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ReviewUploadSection extends StatelessWidget {
  const ReviewUploadSection({
    super.key,
    required this.productName,
    required this.thumb,
    this.onTapUpload,
  });

  final String productName;
  final ImageProvider thumb;
  final VoidCallback? onTapUpload;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Row: thumbnail + product name
          Row(
            children: [
              _Thumb(image: thumb),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  productName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: secondary(), // 16
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                    height: 1.2,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 18),

          // Label: Add Photo
          Text(
            'Add Photo',
            style: TextStyle(
              fontSize: secondary(), // 16
              fontWeight: FontWeight.w600,
              color: Colors.black.withOpacity(0.70),
              height: 1.2,
            ),
          ),

          const SizedBox(height: 16),

          // Dashed upload box
          _DashedUploadBox(onTap: onTapUpload, height: 140),
        ],
      ),
    );
  }
}

class _Thumb extends StatelessWidget {
  const _Thumb({required this.image});

  final ImageProvider image;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.greyBorder, width: 1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Image(image: image, fit: BoxFit.cover),
      ),
    );
  }
}

/// Centered upload area with rounded **dashed** outline and light fill
class _DashedUploadBox extends StatelessWidget {
  const _DashedUploadBox({this.onTap, this.height = 140, this.radius = 14});

  final VoidCallback? onTap;
  final double height;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.grey.shade100,
      child: InkWell(
        borderRadius: BorderRadius.circular(radius),
        onTap: onTap,
        child: CustomPaint(
          foregroundPainter: _DashedRRectPainter(
            color: Colors.grey.shade400,
            // dashed border color
            strokeWidth: 1.2,
            dash: 6,
            gap: 4,
            radius: radius,
          ),
          child: Container(
            height: height,
            decoration: BoxDecoration(
              color: Colors.grey.shade100, // #F7F8F9 light fill
              borderRadius: BorderRadius.circular(radius),
            ),
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.image_outlined, size: 35, color: AppColors.green),
                const SizedBox(height: 10),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.cloud_upload_outlined,
                      size: 22,
                      color: AppColors.green,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      'Tap to upload',
                      style: TextStyle(
                        fontSize: secondary(), // 16
                        fontWeight: FontWeight.w600,
                        color: AppColors.green,
                        height: 1.2,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Draws a dashed rounded-rect border (no external packages needed)
class _DashedRRectPainter extends CustomPainter {
  _DashedRRectPainter({
    required this.color,
    required this.strokeWidth,
    required this.dash,
    required this.gap,
    required this.radius,
  });

  final Color color;
  final double strokeWidth;
  final double dash;
  final double gap;
  final double radius;

  @override
  void paint(Canvas canvas, Size size) {
    final rrect = RRect.fromRectAndRadius(
      Offset.zero & size,
      Radius.circular(radius),
    );

    final path = Path()..addRRect(rrect);
    final paint =
        Paint()
          ..color = color
          ..style = PaintingStyle.stroke
          ..strokeWidth = strokeWidth;

    // dash the path
    for (final metric in path.computeMetrics()) {
      double dist = 0;
      while (dist < metric.length) {
        final len = dash;
        final seg = metric.extractPath(
          dist,
          (dist + len).clamp(0, metric.length),
        );
        canvas.drawPath(seg, paint);
        dist += dash + gap;
      }
    }
  }

  @override
  bool shouldRepaint(covariant _DashedRRectPainter old) {
    return old.color != color ||
        old.strokeWidth != strokeWidth ||
        old.dash != dash ||
        old.gap != gap ||
        old.radius != radius;
  }
}

class WriteReviewBlock extends StatelessWidget {
  const WriteReviewBlock({
    super.key,
    this.title = 'Write a Review',
    this.hint = 'How is the product ? What do you like ?\nWhat do you hate ?',
    this.controller,
    this.height = 120, // matches screenshot proportions
    this.radius = 12,
    this.onChanged,
  });

  final String title;
  final String hint;
  final TextEditingController? controller;
  final double height;
  final double radius;
  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title (subtle dark grey, semi-bold)
          Text(
            title,
            style: TextStyle(
              fontSize: secondary(), // 16
              fontWeight: FontWeight.w600,
              color: Colors.black.withOpacity(0.65), // like the mock
              height: 1.2,
            ),
          ),
          const SizedBox(height: 8),

          // Text area
          SizedBox(
            height: height,
            child: TextFormField(
              controller: controller,
              onChanged: onChanged,
              expands: true,
              // fill the SizedBox height
              minLines: null,
              maxLines: null,
              textAlignVertical: TextAlignVertical.top,
              // top-left start
              keyboardType: TextInputType.multiline,
              style: TextStyle(
                fontSize: tertiary(), // 14
                color: Colors.black87,
                height: 1.35,
              ),
              decoration: InputDecoration(
                hintText: hint,
                hintStyle: TextStyle(
                  fontSize: tertiary(), // 14
                  color: Colors.black, // soft hint like mock
                  height: 1.35,
                ),
                isDense: true,
                filled: true,
                fillColor: Colors.grey.shade100,
                // #F7F8F9
                contentPadding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(radius),
                  borderSide: const BorderSide(
                    color: AppColors.greyBorder, // #E8ECF4
                    width: 2,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  // stays grey (like image)
                  borderRadius: BorderRadius.circular(radius),
                  borderSide: const BorderSide(
                    color: AppColors.greyBorder,
                    width: 1,
                  ),
                ),
              ),
              cursorColor: AppColors.green,
            ),
          ),
        ],
      ),
    );
  }
}
