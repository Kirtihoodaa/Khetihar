import 'package:flutter/material.dart';
import 'package:khetihar/Theme/AppColors.dart';
import 'package:khetihar/Theme/FontSize.dart';

class ReusableProductCard extends StatefulWidget {
  final String image;
  final String title;
  final String price;
  final String? desc;
  final double? rating;
  final int? reviewCount;
  final VoidCallback? onCardTap;

  // optional callbacks
  final ValueChanged<bool>? onAddedChanged;
  final ValueChanged<bool>? onFavoriteChanged;

  // flags
  final bool showFavorite;
  final bool showRating;
  final bool showButton;
  final double? imageHeight;
  final BorderRadius? borderRadius;
  final List<BoxShadow>? boxShadow;

  const ReusableProductCard({
    super.key,
    required this.image,
    required this.title,
    required this.price,
    this.desc,
    this.rating,
    this.reviewCount,
    this.onCardTap,
    this.onAddedChanged,
    this.onFavoriteChanged,
    this.showFavorite = true,
    this.showRating = true,
    this.showButton = true,
    this.imageHeight = 120,
    this.borderRadius,
    this.boxShadow,
  });

  @override
  State<ReusableProductCard> createState() => _ReusableProductCardState();
}

class _ReusableProductCardState extends State<ReusableProductCard> {
  bool _added = false;
  bool _favorited = false;

  @override
  Widget build(BuildContext context) {
    final defaultBorderRadius = BorderRadius.circular(16);
    final defaultBoxShadow = [
      BoxShadow(
        color: Colors.black.withOpacity(0.05),
        blurRadius: 8,
        offset: const Offset(0, 4),
      ),
    ];

    return GestureDetector(
      onTap: widget.onCardTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: widget.borderRadius ?? defaultBorderRadius,
          boxShadow: widget.boxShadow ?? defaultBoxShadow,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildImageSection(defaultBorderRadius),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    Text(
                      widget.title,
                      style: TextStyle(
                        fontSize: tertiary(),
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),

                    // Description
                    if (widget.desc != null) ...[
                      const SizedBox(height: 4),
                      Expanded(
                        child: Text(
                          widget.desc!,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: medium(),
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    ],

                    const SizedBox(height: 6),

                    // Price
                    Text(
                      widget.price,
                      style: TextStyle(
                        fontSize: tertiary(),
                        fontWeight: FontWeight.w600,
                        color: AppColors.green,
                      ),
                    ),

                    const SizedBox(height: 8),

                    // Rating + Cart Button
                    Row(
                      children: [
                        if (widget.showRating) _buildRatingSection(),
                        const Spacer(),
                        if (widget.showButton) _buildCartButton(),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImageSection(BorderRadius defaultBorderRadius) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.vertical(
            top: (widget.borderRadius ?? defaultBorderRadius).topLeft,
          ),
          child: Image.asset(
            widget.image,
            height: widget.imageHeight,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
        ),

        // Favorite Button
        if (widget.showFavorite)
          Positioned(
            right: 8,
            top: 8,
            child: GestureDetector(
              onTap: () {
                setState(() => _favorited = !_favorited);
                widget.onFavoriteChanged?.call(_favorited);
              },
              child: CircleAvatar(
                radius: 14,
                backgroundColor: Colors.white,
                child: Icon(
                  _favorited ? Icons.favorite : Icons.favorite_border,
                  size: 16,
                  color: _favorited ? Colors.red : Colors.grey,
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildRatingSection() {
    return Row(
      children: [
        const Icon(Icons.star, size: 16, color: Colors.amber),
        const SizedBox(width: 4),
        Text(
          "${widget.rating ?? 4.4} ${widget.reviewCount != null ? '(${widget.reviewCount})' : '(124)'}",
          style: TextStyle(fontSize: medium(), color: Colors.grey.shade700),
        ),
      ],
    );
  }

  Widget _buildCartButton() {
    return GestureDetector(
      onTap: () {
        setState(() => _added = !_added);
        widget.onAddedChanged?.call(_added);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 160),
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: _added ? AppColors.green : Colors.white,
          border: Border.all(color: AppColors.green, width: 2),
        ),
        alignment: Alignment.center,
        child: Icon(
          _added ? Icons.shopping_cart : Icons.shopping_cart_outlined,
          size: 16,
          color: _added ? Colors.white : AppColors.green,
        ),
      ),
    );
  }
}
