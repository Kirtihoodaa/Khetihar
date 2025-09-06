import 'package:flutter/material.dart';

import '../Theme/FontSize.dart';

class FullWidthPhotoRow extends StatelessWidget {
  final List<String> photos;
  final double gap; // space between photos
  final double borderRadius;

  const FullWidthPhotoRow({
    super.key,
    required this.photos,
    this.gap = 6,
    this.borderRadius = 8,
  });

  @override
  Widget build(BuildContext context) {
    final extraCount = photos.length > 4 ? photos.length - 4 : 0;

    return Row(
      children: List.generate(4, (index) {
        if (index >= photos.length) {
          return Expanded(child: SizedBox(height: 0));
        }

        Widget child;
        if (index == 3 && extraCount > 0) {
          // last with +count
          child = Stack(
            children: [
              _buildImage(photos[index]),
              InkWell(
                onTap: () {
                  _showAllPhotosDialog(context);
                },
                child: Container(
                  height: MediaQuery.sizeOf(context).height / 9.2,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.black54,
                    borderRadius: BorderRadius.circular(borderRadius),
                  ),
                  child: Text(
                    '+$extraCount',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          );
        } else {
          child = _buildImage(photos[index]);
        }

        return Expanded(
          child: Padding(
            padding: EdgeInsets.only(right: index < 3 ? gap : 0),
            child: child,
          ),
        );
      }),
    );
  }

  Widget _buildImage(String url) {
    return AspectRatio(
      aspectRatio: 1,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: Image.network(url, fit: BoxFit.cover),
      ),
    );
  }

  void _showAllPhotosDialog(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (_) => AlertDialog(
            backgroundColor: Colors.white,
            title: Text('Customer Photos (${photos.length})'),
            content: SizedBox(
              width: double.maxFinite,
              child: GridView.builder(
                shrinkWrap: true,
                itemCount: photos.length, // use total images
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, // or 3 for more columns
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  childAspectRatio: 1,
                ),
                itemBuilder:
                    (_, index) => ClipRRect(
                      borderRadius: BorderRadius.circular(borderRadius),
                      child: InkWell(
                        onTap: () {
                          _openFullScreen(
                            context,
                            photos[index],
                            'review textSample review text',
                            4,
                          );
                        },
                        child: Image.network(photos[index], fit: BoxFit.cover),
                      ),
                    ),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('Close'),
              ),
            ],
          ),
    );
  }

  void _openFullScreen(
    BuildContext context,
    String url,
    String review,
    double rating,
  ) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (_) => Scaffold(
              backgroundColor: Colors.black,
              body: SafeArea(
                child: Stack(
                  children: [
                    Center(
                      child: Hero(
                        tag: url,
                        child: Image.network(
                          url,
                          fit: BoxFit.contain,
                          width: double.infinity,
                          height: double.infinity,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Container(
                        margin: const EdgeInsets.all(10),
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.65),
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Rating badge
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                              decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.star, color: Colors.white, size: secondary()),
                                  const SizedBox(width: 6),
                                  Text(
                                    rating.toStringAsFixed(1), // e.g., "4.6"
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 14),
                            // Review text
                            Padding(
                              padding: const EdgeInsets.only(left: 2.0),
                              child: Text(
                                review,
                                style: TextStyle(
                                  fontSize: tertiary(),
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400,
                                  height: 1.25,
                                ),
                                maxLines: 4,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            const SizedBox(height: 12),
                            // Reviewer info
                            Padding(
                              padding: const EdgeInsets.only(left: 2.0),
                              child: Text(
                                "Customer Name • 2 months ago",
                                style: TextStyle(
                                  fontSize: tertiary() * 0.95,
                                  color: Colors.white70,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    Positioned(
                      top: 20,
                      left: 20,
                      child: IconButton(
                        icon: const Icon(Icons.close, color: Colors.white),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),
                  ],
                ),
              ),
            ),
      ),
    );
  }
}
