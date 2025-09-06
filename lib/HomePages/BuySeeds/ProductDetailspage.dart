import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khetihar/Components/CustomButton.dart';
import 'package:khetihar/Components/PhotoRow.dart';
import '../../Components/Customerreviewcard.dart';
import '../../Components/InputFields.dart';
import '../../Theme/AppColors.dart';
import '../../Theme/FontSize.dart';

class ProductDetailsPage extends StatelessWidget {
  final Map<String, dynamic> product;
  final String heroTag;

  ProductDetailsPage({super.key})
    : product = Get.arguments['product'],
      heroTag = Get.arguments['heroTag'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text(product['title'])),
      body: ListView(
        children: [
          Hero(
            tag: heroTag,
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                  child: Image.asset(
                    product['image'],
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                ),
                Positioned(
                  top: 16,
                  right: 16,
                  child: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    child: IconButton(
                      icon: const Icon(Icons.favorite_border),
                      color: AppColors.green,
                      onPressed: () {
                        // Handle favorite action
                      },
                    ),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product['title'],
                  style: Theme.of(
                    context,
                  ).textTheme.headlineSmall?.copyWith(color: AppColors.green),
                ),
                Text(
                  product['price'],
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: AppColors.green,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.star, color: Colors.amber, size: 20),
                    const SizedBox(width: 4),
                    Text(
                      '${product['rating']} reviews',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  "Product Overview",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: primary(),
                  ),
                ),
                if (product['desc'] != null)
                  Text(
                    product['desc'],
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                const SizedBox(height: 12),
                Text(
                  "About the Product",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: primary(),
                  ),
                ),
                Text(
                  product['desc'],
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 12),
                Text(
                  "Shipping & Services",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: primary(),
                  ),
                ),
                const SizedBox(height: 12),
                CustomInputField(labelText: 'Enter the PIN'),
                const SizedBox(height: 8),
                Align(
                  alignment: Alignment.center,
                  child: CustomButton(
                    text: "Check Availability",
                    onPressed: () {},
                    width: MediaQuery.of(context).size.width * 0.6,
                    backgroundColor: AppColors.green,
                    foregroundColor: Colors.white,
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Icon(
                      Icons.calendar_today_outlined,
                      size: 20,
                      color: AppColors.green,
                    ),
                    const SizedBox(width: 5),
                    Text("Receive by thursday, 21st June"),
                  ],
                ),
                SizedBox(height: 5),

                Row(
                  children: [
                    Icon(Icons.credit_card, size: 20, color: AppColors.green),
                    const SizedBox(width: 5),
                    Text("Cash on delivery not available"),
                  ],
                ),
                SizedBox(height: 5),
                Row(
                  children: [
                    Icon(
                      Icons.local_shipping_outlined,
                      size: 20,
                      color: AppColors.green,
                    ),
                    const SizedBox(width: 5),
                    Text("Return & Exchange within 7 days"),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Text(
                      "Reviews and Ratings",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: primary(),
                      ),
                    ),
                    Spacer(),
                    Row(
                      children: [
                        Icon(Icons.star, color: Colors.amber, size: 20),
                        const SizedBox(width: 4),
                        Text(
                          '${product['rating']}',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Text(
                  "Customer Photos",
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                FullWidthPhotoRow(
                  photos: [
                    'https://images.unsplash.com/photo-1503023345310-bd7c1de61c7d?auto=format&fit=crop&w=800&q=60',
                    'https://images.unsplash.com/photo-1499951360447-b19be8fe80f5?auto=format&fit=crop&w=800&q=60',
                    'https://images.unsplash.com/photo-1506744038136-46273834b3fb?auto=format&fit=crop&w=800&q=60',
                    'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?auto=format&fit=crop&w=800&q=60',
                    'https://images.unsplash.com/photo-1522202176988-66273c2fd55f?auto=format&fit=crop&w=800&q=60',
                    'https://images.unsplash.com/photo-1534081333815-ae5019106622?auto=format&fit=crop&w=800&q=60',
                  ],
                  gap: 8,
                  borderRadius: 12,
                ),
                const SizedBox(height: 12),
                CustomerReviewCard(
                  reviewText:
                      "The service was excellent and food was delicious!",
                  date: "2 months ago",
                  rating: 4.8,
                ),
              ],
            ),
          ),
        ],
      ),
    bottomNavigationBar: Padding(
      padding: const EdgeInsets.all(12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: CustomButton(
                icon: Icons.add_shopping_cart_outlined,
                text: "Add to Cart",
                onPressed: () {},
                backgroundColor: AppColors.brown,
                foregroundColor: Colors.white,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: CustomButton(
                icon: Icons.shopping_bag,
                text: "Buy Now",
                onPressed: () {},
                backgroundColor: AppColors.green,
                foregroundColor: Colors.white,
              ),
            ),
          ),
        ],
      ),
    )
    );

  }
}
