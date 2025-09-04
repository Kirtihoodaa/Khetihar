import 'package:flutter/material.dart';

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
              Container(
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
        child: Image.network(
          url,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
