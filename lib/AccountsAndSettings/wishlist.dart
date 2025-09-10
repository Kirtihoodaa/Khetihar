import 'package:flutter/material.dart';
import 'package:khetihar/Components/CustomAppBar.dart';

import '../Components/GridView.dart';
import '../Components/ProductCard.dart';

class Wishlist extends StatelessWidget {
  Wishlist({super.key});

  final List<Map<String, dynamic>> rawProducts = [
    {
      'id': 'PRD-1001',
      'title': 'Wheat Seed',
      'subtitle': '#4',
      'image': 'Assets/Seeds/Fruit.png',
      'price': 146, // num (int/double)
      'rating': 4.6, // num
      'reviews': 87, // num
      'canBuy': true,
      'canRent': false,
    },
    {
      'id': 'PRD-1002',
      'title': 'Turmeric',
      'subtitle': '#3',
      'image': 'Assets/Seeds/Pulse.png',
      'price': 199,
      'rating': 4.8,
      'reviews': 112,
      'canBuy': true,
      'canRent': false,
    },
    {
      'id': 'PRD-1003',
      'title': 'Berseem',
      'subtitle': '#2',
      'image': 'Assets/Seeds/rice.png',
      'price': 120,
      'rating': 4.2,
      'reviews': 43,
      'canBuy': true,
      'canRent': false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: KCenteredActionsAppBar(title: "Wishlist"),
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          children: [
            SizedBox(height: 16),
            Expanded(
              child: ReusableGridView(
                // use your controller list, or fall back to the demo raw data
                items: rawProducts,
                crossAxisCount: 2,
                childAspectRatio: 0.75,

                itemBuilder: (context, product, index) {
                  // ---- safe reads + fallbacks ----
                  final String id = product['id']?.toString() ?? 'item$index';
                  final String title =
                      product['title']?.toString() ?? 'Untitled';
                  final String desc =
                      (product['subtitle'] ?? product['desc'] ?? '').toString();
                  final String image =
                      product['image']?.toString() ?? 'Assets/Seeds/Fruit.png';
                  final num priceNum = (product['price'] as num?) ?? 0;
                  final double rating =
                      (product['rating'] as num?)?.toDouble() ?? 0.0;
                  final int reviews =
                      (product['reviews'] as num?)?.toInt() ?? 0;
                  final bool canBuy = product['canBuy'] as bool? ?? true;
                  final bool canRent = product['canRent'] as bool? ?? false;

                  final heroTag = '${id}_$index';

                  return ReusableProductCard(
                    image: image,
                    title: title,
                    desc: desc,
                    // your card expects a String price — format however you like
                    price: 'INR ${priceNum.toStringAsFixed(0)}',
                    rating: rating,
                    reviewCount: reviews,
                    heroTag: heroTag,
                    onCardTap: () {
                      // navigate/show details using `id` or `product` map
                    },
                    showCartButton: canBuy,
                    showRentButton: canRent,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
