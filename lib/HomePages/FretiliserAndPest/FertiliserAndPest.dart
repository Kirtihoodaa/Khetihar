import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khetihar/Components/CategoryItems.dart';
import 'package:khetihar/Components/GridView.dart';
import 'package:khetihar/Components/SecondaryAppBar.dart';
import 'package:khetihar/Components/CustomButton.dart';
import 'package:khetihar/Components/ProductCard.dart';
import 'package:khetihar/HomePages/FretiliserAndPest/Controller/Fert_APesti_Controller.dart';
import 'package:khetihar/Theme/AppColors.dart';
import 'package:khetihar/Theme/FontSize.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FertilizerAndPest extends StatelessWidget {
  final FertilizerPesticideController _controller = Get.put(
    FertilizerPesticideController(),
  );

  final TextEditingController _searchController = TextEditingController();

  FertilizerAndPest({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: Secondaryappbar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Section
            Padding(
              padding: const EdgeInsets.all(16),
              child: _buildSearchSection(),
            ),

            // Toggle Tabs for fertilizer/Pesticide
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Expanded(
                    child: Obx(
                      () => CustomButton(
                        text: "Fertilizer",
                        onPressed:
                            () =>
                                _controller.selectedTab.value =
                                    FPTab.fertilizer,
                        variant:
                            _controller.selectedTab.value == FPTab.fertilizer
                                ? ButtonVariant.filled
                                : ButtonVariant.outline,
                        backgroundColor:
                            _controller.selectedTab.value == FPTab.fertilizer
                                ? AppColors.green
                                : Colors.white,
                        foregroundColor:
                            _controller.selectedTab.value == FPTab.fertilizer
                                ? Colors.white
                                : AppColors.green,
                        borderColor: AppColors.green,
                        radius: 30,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        icon: FontAwesomeIcons.seedling,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Obx(
                      () => CustomButton(
                        text: "Pesticide",
                        onPressed:
                            () =>
                                _controller.selectedTab.value = FPTab.pesticide,
                        variant:
                            _controller.selectedTab.value == FPTab.pesticide
                                ? ButtonVariant.filled
                                : ButtonVariant.outline,
                        backgroundColor:
                            _controller.selectedTab.value == FPTab.pesticide
                                ? AppColors.green
                                : Colors.white,
                        foregroundColor:
                            _controller.selectedTab.value == FPTab.pesticide
                                ? Colors.white
                                : AppColors.green,
                        borderColor: AppColors.green,
                        radius: 30,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        icon: FontAwesomeIcons.sprayCan,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Category Heading
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Obx(
                () => Text(
                  _controller.selectedTab.value == FPTab.fertilizer
                      ? "Fertilizer Categories"
                      : "Pesticide Categories",
                  style: TextStyle(
                    fontSize: primary(),
                    fontWeight: FontWeight.w600,
                    color: AppColors.green,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Categories Grid (Reusable)
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Obx(
                () => ReusableGridView(
                  items: _controller.activeCategories,
                  crossAxisCount: 4,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 20,
                  childAspectRatio: 0.8,
                  itemBuilder:
                      (context, category, index) => ReusableCategoryItem(
                        image: category['image']!,
                        title: category['title']!,
                        onTap: () {
                          print("Tapped category: ${category['title']}");
                        },
                      ),
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Products Grid (Scrollable)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Obx(() {
                final filteredProducts = _filteredActiveProducts(
                  _searchController.text,
                );
                return ReusableGridView(
                  items: filteredProducts,
                  crossAxisCount: 2,
                  childAspectRatio: 0.70,
                  itemBuilder: (context, p, index) {
                    final heroTag = '${p['id']}_${p['title']}';

                    return ReusableProductCard(
                      image: p['image'] ?? '',
                      title: p['title'] ?? '',
                      desc: p['desc'] ?? '',
                      price: p['price'] ?? '',
                      rating: p['rating'],
                      reviewCount: p['reviewCount'],
                      heroTag: heroTag,
                      onCardTap: () {
                        Get.toNamed(
                          '/ProductDetailPage',
                          arguments: {'product': p, 'heroTag': heroTag},
                        );
                      },
                      showRentButton: false,
                      showCartButton: true,
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  // ---- UI bits ----
  Widget _buildSearchSection() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.secondarygrey,
        borderRadius: BorderRadius.circular(28),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _searchController,
              onChanged: (_) {},
              textInputAction: TextInputAction.search,
              decoration: InputDecoration(
                hintText: "Search For Fertilizer/Pesticides",
                hintStyle: TextStyle(
                  color: Colors.black,
                  fontSize: secondary(),
                ),
                border: InputBorder.none,
              ),
            ),
          ),
          CircleAvatar(
            radius: 20,
            backgroundColor: AppColors.green,
            child: const Icon(Icons.search, color: Colors.white),
          ),
        ],
      ),
    );
  }

  // Filtering products based on search query
  List<Map<String, dynamic>> _filteredActiveProducts(String query) {
    final products = _controller.activeProducts;
    if (query.isEmpty) return products;

    final lowerQuery = query.toLowerCase();
    return products.where((product) {
      return product['title']!.toLowerCase().contains(lowerQuery) ||
          product['desc']!.toLowerCase().contains(lowerQuery) ||
          product['price']!.toLowerCase().contains(lowerQuery);
    }).toList();
  }
}
