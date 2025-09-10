import 'package:flutter/material.dart';
import '../../Theme/AppColors.dart';
import '../../Theme/FontSize.dart';

class RecommendationsSectionExact extends StatelessWidget {
  const RecommendationsSectionExact({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 515, // section width to match screenshot scale
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header row
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: Row(
              children: [
                Text(
                  "Recommendations",
                  style: TextStyle(
                    color: AppColors.green,
                    fontSize: primary(), // 14
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const Spacer(),
                Row(
                  children: [
                    Text(
                      "View All",
                      style: TextStyle(
                        color: AppColors.green,
                        fontSize: primary(), // 14
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Icon(Icons.chevron_right, size: 18, color: AppColors.green),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          // The card
          const ProductRecommendationCardExact(),
        ],
      ),
    );
  }
}

// ========================================
// PRODUCT CARD (pixel perfect to screenshot)
// ========================================
class ProductRecommendationCardExact extends StatelessWidget {
  const ProductRecommendationCardExact({super.key, this.image});

  final ImageProvider? image;

  @override
  Widget build(BuildContext context) {
    // subtle neutrals tuned to screenshot
    const Color text900 = Color(0xFF1F2937);
    const Color text600 = Color(0xFF4B5563);
    const Color text500 = Color(0xFF6B7280);
    const Color cardShadow = Color(0x14000000);

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.greyBorder),
        boxShadow: const [
          BoxShadow(color: cardShadow, blurRadius: 12, offset: Offset(0, 4)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Image with rounded top and favorite pill
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
            child: Stack(
              children: [
                // Use provided image or a safe placeholder
                AspectRatio(
                  aspectRatio: 315 / 160, // locked to screenshot look
                  child: Image(
                    image:
                        image ??
                        const NetworkImage(
                          "https://images.unsplash.com/photo-1501004318641-b39e6451bec6?q=80&w=1200&auto=format&fit=crop",
                        ),
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 10,
                  right: 10,
                  child: Container(
                    width: 28,
                    height: 28,
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.35),
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 1.2),
                    ),
                    child: const Icon(
                      Icons.favorite_border,
                      color: Colors.white,
                      size: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          // Content
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 10, 12, 12),
            child: Column(
              children: [
                // Title + price/weight
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Text(
                        "NPK Fertilizer",
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
                    Text(
                      "INR 500",
                      style: TextStyle(
                        fontSize: secondary(), // 16
                        fontWeight: FontWeight.w700,
                        color: text900,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      "1 kg",
                      style: TextStyle(
                        fontSize: medium(), // 12
                        color: text600,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // Features (two columns)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Expanded(
                      child: _IconTextLine(
                        icon: Icons.local_florist_outlined,
                        iconColor: Color(0xFFFF8A00), // warm orange glyph
                        text: "2–3 cups per acre",
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: _IconTextLine(
                        icon: Icons.schedule_outlined,
                        iconColor: AppColors.green,
                        text: "Before sowing",
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Expanded(
                      child: _IconTextLine(
                        icon: Icons.eco_outlined,
                        iconColor: AppColors.green,
                        textTop: "Alternative:",
                        text: "Vermicompost",
                        emphasizeTail: true,
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: _IconTextLine(
                        icon: Icons.grass_outlined,
                        iconColor: AppColors.green,
                        textTop: "Suitable for:",
                        text: "Wheat, Rice, cotton",
                        emphasizeTail: true,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 10),

                // Buttons
                Row(
                  children: [
                    // Add To Cart (brown)
                    Expanded(
                      child: SizedBox(
                        height: 40,
                        child: TextButton.icon(
                          onPressed: () {},
                          style: TextButton.styleFrom(
                            backgroundColor: AppColors.brown,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(22),
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                          ),
                          icon: const Icon(
                            Icons.shopping_cart_outlined,
                            size: 18,
                          ),
                          label: Text(
                            "Add To Cart",
                            style: TextStyle(
                              fontSize: tertiary(), // 14
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    // Buy Now (green)
                    Expanded(
                      child: SizedBox(
                        height: 40,
                        child: TextButton.icon(
                          onPressed: () {},
                          style: TextButton.styleFrom(
                            backgroundColor: AppColors.green,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(22),
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                          ),
                          icon: const Icon(
                            Icons.shopping_bag_outlined,
                            size: 18,
                          ),
                          label: Text(
                            "Buy Now",
                            style: TextStyle(
                              fontSize: tertiary(), // 14
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ------------------------------------
// Small icon+text row used in features
// ------------------------------------
class _IconTextLine extends StatelessWidget {
  final IconData icon;
  final String text;
  final String? textTop; // e.g., "Alternative:"
  final bool emphasizeTail; // make tail part 600 weight
  final Color iconColor;

  const _IconTextLine({
    required this.icon,
    required this.iconColor,
    required this.text,
    this.textTop,
    this.emphasizeTail = false,
  });

  @override
  Widget build(BuildContext context) {
    const Color text500 = Color(0xFF6B7280);
    const Color text900 = Color(0xFF1F2937);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 16, color: iconColor),
        const SizedBox(width: 6),
        Expanded(
          child: RichText(
            text: TextSpan(
              children: [
                if (textTop != null)
                  TextSpan(
                    text: "$textTop ",
                    style: TextStyle(
                      fontSize: secondary(), // 14
                      color: text500,
                      fontWeight: FontWeight.w600,
                      height: 1.25,
                    ),
                  ),
                TextSpan(
                  text: text,
                  style: TextStyle(
                    fontSize: secondary(), // 14
                    color: emphasizeTail ? text900 : text500,
                    fontWeight:
                        emphasizeTail ? FontWeight.w600 : FontWeight.w500,
                    height: 1.25,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
