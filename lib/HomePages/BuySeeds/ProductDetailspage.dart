import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khetihar/Components/CustomButton.dart';
import 'package:khetihar/Components/PhotoRow.dart';
import '../../Components/Customerreviewcard.dart';
import '../../Components/InputFields.dart';
import '../../Components/SecondaryAppBar.dart';
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
      appBar: Secondaryappbar(),
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
                    // keep same as card (asset vs network)
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
                    'https://images.unsplash.com/photo-1499951360447-b19be8fe80f5?auto=format&fit=crop&w=800&q=60',
                    'https://images.unsplash.com/photo-1499951360447-b19be8fe80f5?auto=format&fit=crop&w=800&q=60',
                    'https://images.unsplash.com/photo-1499951360447-b19be8fe80f5?auto=format&fit=crop&w=800&q=60',
                    'https://images.unsplash.com/photo-1499951360447-b19be8fe80f5?auto=format&fit=crop&w=800&q=60',
                    'https://images.unsplash.com/photo-1499951360447-b19be8fe80f5?auto=format&fit=crop&w=800&q=60',
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
                // This goes inside your Column where you want to list short summary reviews.

                InkWell(
                  onTap: () {
                    Get.toNamed('/all_reviews', arguments: {'product': product});
                  },
                  borderRadius: BorderRadius.circular(16),
                  child: Card(
                    color: Colors.white,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    elevation: 1,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    child: Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Top row: rating badge, date, stars
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Row(
                                  children: [
                                    Icon(Icons.star, size: 16, color: Colors.white),
                                    const SizedBox(width: 2),
                                    Text(
                                      '4.8',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 10),
                              Text(
                                "2 months ago",
                                style: TextStyle(color: Colors.grey[700], fontSize: 13),
                              ),
                              const Spacer(),
                              Row(
                                children: List.generate(
                                  5,
                                      (idx) => Icon(
                                    Icons.star,
                                    size: 18,
                                    color: idx < 4.8 ? Colors.amber : Colors.grey[300],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          // Review text
                          Text(
                            "The service was excellent and food was delicious!",
                            style: TextStyle(fontSize: tertiary(), color: Colors.black87),
                          ),
                          // const SizedBox(height: 12),
                          // // Like/Dislike row (optional)
                          // Row(
                          //   children: [
                          //     Icon(Icons.thumb_up, size: 18, color: Colors.grey[600]),
                          //     const SizedBox(width: 2),
                          //     Text("12", style: TextStyle(color: Colors.grey[600], fontSize: 14)),
                          //     const SizedBox(width: 12),
                          //     Icon(Icons.thumb_down, size: 18, color: Colors.grey[600]),
                          //     const SizedBox(width: 2),
                          //     Text("12", style: TextStyle(color: Colors.grey[600], fontSize: 14)),
                          //   ],
                          // ),
                        ],
                      ),
                    ),
                  ),
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
