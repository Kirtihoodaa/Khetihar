import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:khetihar/Components/SecondaryAppBar.dart';
import 'package:khetihar/Components/GridView.dart';
import 'package:khetihar/Components/ProductCard.dart';
import 'package:khetihar/HomePages/BuySeeds/Controller/CategoryController.dart';
import 'package:khetihar/Theme/AppColors.dart';
import 'package:khetihar/Theme/FontSize.dart';

class CategoryDetailPage extends GetView<CategoryController> {
  CategoryDetailPage({super.key, required this.categoryName}) {
    Get.put(CategoryController(categoryName), tag: categoryName);
  }

  final String categoryName;

  @override
  String? get tag => categoryName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: Secondaryappbar(),
      body: ListView(
        padding: const EdgeInsets.all(10),
        children: [
          // Search
          Obx(
            () => Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: AppColors.secondarygrey,
                borderRadius: BorderRadius.circular(28),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: controller.search,
                      onChanged: controller.filter,
                      textInputAction: TextInputAction.search,
                      decoration: InputDecoration(
                        hintText: "Search For Seeds",
                        hintStyle: TextStyle(
                          color: Colors.black,
                          fontSize: secondary(),
                        ),
                        border: InputBorder.none,
                        suffixIcon:
                            controller.query.isNotEmpty
                                ? IconButton(
                                  icon: const Icon(
                                    Icons.clear,
                                    color: Colors.grey,
                                  ),
                                  onPressed: controller.clearSearch,
                                )
                                : null,
                      ),
                    ),
                  ),
                  CircleAvatar(
                    radius: 22,
                    backgroundColor: AppColors.green,
                    child: const Icon(Icons.search, color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Title
          Text(
            categoryName,
            style: TextStyle(
              fontSize: primary(),
              fontWeight: FontWeight.w600,
              color: AppColors.green,
            ),
          ),
          const SizedBox(height: 12),

          // Grid
          Obx(
            () =>
                controller.visible.isEmpty
                    ? Padding(
                      padding: const EdgeInsets.only(top: 40.0),
                      child: Center(
                        child: Text(
                          "No items found",
                          style: TextStyle(
                            fontSize: secondary(),
                            color: Colors.black54,
                          ),
                        ),
                      ),
                    )
                    : ReusableGridView<Map<String, dynamic>>(
                      items: controller.visible,
                      crossAxisCount: 2,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: 0.66,
                      itemBuilder: (context, p, i) {
                        final heroTag = '${p['id']}_${p['title']}_$i';
                        return ReusableProductCard(
                          image: p['image'],
                          title: p['title'],
                          price: "INR ${p['price']}",
                          desc: p['desc'],
                          rating: p['rating'],
                          reviewCount: p['reviewCount'],
                          heroTag: heroTag,
                          onCardTap: () {
                            Get.toNamed(
                              '/ProductDetailPage',
                              arguments: {'product': p, 'heroTag': heroTag},
                            );
                          },
                          showCartButton: true,
                          showRentButton: false,
                          onCartTap: () => controller.addToCart(p),
                        );
                      },
                    ),
          ),
        ],
      ),
    );
  }
}
