import 'package:flutter/material.dart';
import '../../Theme/AppColors.dart';
import '../../Theme/FontSize.dart';

/// Title: "Some Nearby Markets"
class NearbyMarketsTitle extends StatelessWidget {
  const NearbyMarketsTitle({super.key, this.text = 'Some Nearby Markets'});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: primary(), // 16
        fontWeight: FontWeight.w600,
        color: AppColors.green,
        height: 1.2,
      ),
    );
  }
}

/// One photo card with rounded corners + green bottom band + white label.
class MarketThumbCard extends StatelessWidget {
  const MarketThumbCard({
    super.key,
    required this.image,
    required this.label,
    this.onTap,
    this.width = 330, // matches the visual scale in your mock
    this.height = 146,
    this.radius = 12,
  });

  final ImageProvider image;
  final String label;
  final VoidCallback? onTap;
  final double width;
  final double height;
  final double radius;

  @override
  Widget build(BuildContext context) {
    final card = ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Photo
          Image(image: image, fit: BoxFit.cover),

          // Bottom green band
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 36, // height of the band in the screenshot
              color: AppColors.green.withOpacity(0.78),
            ),
          ),

          // Label text
          Positioned(
            left: 12,
            bottom: 8,
            child: Text(
              label,
              style: TextStyle(
                fontSize: secondary(),
                // 16
                fontWeight: FontWeight.w600,
                color: Colors.white,
                height: 1.1,
                letterSpacing: 0.1,
              ),
            ),
          ),
        ],
      ),
    );

    return SizedBox(
      width: width,
      height: height,
      child:
          onTap == null
              ? card
              : Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(radius),
                  onTap: onTap,
                  child: card,
                ),
              ),
    );
  }
}

/// The horizontal list (kept tiny so you can reuse anywhere).
class NearbyMarketsList extends StatelessWidget {
  const NearbyMarketsList({
    super.key,
    required this.items,
    this.itemSpacing = 12,
    this.sidePadding = const EdgeInsets.only(
      right: 12,
    ), // shows next card peeking
  });

  final List<({ImageProvider image, String label, VoidCallback? onTap})> items;
  final double itemSpacing;
  final EdgeInsets sidePadding;

  @override
  Widget build(BuildContext context) {
    // Fix the height so the inner horizontal ListView gets tight constraints.
    const double cardHeight = 166;

    return SizedBox(
      height: cardHeight,
      child: ListView.separated(
        padding: sidePadding,
        // tiny right pad to show partial next card, like the mock
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, i) {
          final it = items[i];
          return MarketThumbCard(
            image: it.image,
            label: it.label,
            onTap: it.onTap,
          );
        },
        separatorBuilder: (_, __) => SizedBox(width: itemSpacing),
        itemCount: items.length,
      ),
    );
  }
}
