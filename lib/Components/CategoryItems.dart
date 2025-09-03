import 'package:flutter/material.dart';
import 'package:khetihar/Theme/FontSize.dart';

class ReusableCategoryItem extends StatelessWidget {
  final String image;
  final String title;
  final VoidCallback? onTap;
  final double? radius;
  final Color? backgroundColor;
  final int? maxLines;

  const ReusableCategoryItem({
    super.key,
    required this.image,
    required this.title,
    this.onTap,
    this.radius = 32,
    this.backgroundColor = Colors.white,
    this.maxLines = 2,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          CircleAvatar(
            radius: radius,
            backgroundColor: backgroundColor,
            backgroundImage: AssetImage(image),
          ),
          const SizedBox(height: 6),
          Text(
            title,
            textAlign: TextAlign.center,
            maxLines: maxLines,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: medium(),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}