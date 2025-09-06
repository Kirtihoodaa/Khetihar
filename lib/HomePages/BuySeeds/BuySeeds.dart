import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khetihar/Components/CategoryItems.dart';
import 'package:khetihar/Components/GridView.dart';
import 'package:khetihar/Components/ProductCard.dart';
import 'package:khetihar/Components/SecondaryAppBar.dart';
import 'package:khetihar/HomePages/BuySeeds/Controller/SeedsController.dart';
import 'package:khetihar/Theme/AppColors.dart';
import 'package:khetihar/Theme/FontSize.dart';
import 'package:khetihar/HomePages/BuySeeds/CategoryDetails.dart';
import 'package:khetihar/HomePages/BuySeeds/ProductDetailspage.dart';

class SeedsPage extends StatelessWidget {
  const SeedsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SeedPageContent();
  }
}

class SeedPageContent extends StatelessWidget {
  final SeedsController _controller = Get.put(SeedsController());

  SeedPageContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: Secondaryappbar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Search Section
          Padding(padding: EdgeInsets.all(10), child: _buildSearchSection()),

          //const SizedBox(height: 10),
          Expanded(
            child: Obx(() {
              return _controller.isSearching.value
                  ? _buildSearchResultsView()
                  : _buildDefaultView();
            }),
          ),
        ],
      ),
    );
  }

  // Search Section UI
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
              controller: TextEditingController(
                text: _controller.searchQuery.value,
              ),
              onChanged: (query) => _controller.onSearchChanged(query),
              decoration: InputDecoration(
                hintText: "Search For Seeds",
                hintStyle: TextStyle(
                  color: Colors.black,
                  fontSize: secondary(),
                ),
                border: InputBorder.none,
                suffixIcon:
                    _controller.searchQuery.value.isNotEmpty
                        ? IconButton(
                          icon: const Icon(Icons.clear, color: Colors.grey),
                          onPressed: _controller.clearSearch,
                        )
                        : null,
              ),
            ),
          ),
          GestureDetector(
            onTap:
                () =>
                    _controller.onSearchChanged(_controller.searchQuery.value),
            child: CircleAvatar(
              radius: 20,
              backgroundColor: AppColors.green,
              child: const Icon(Icons.search, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  // Default View (Categories + Products)
  Widget _buildDefaultView() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Categories Section
          _buildSectionTitle("Seeds Categories"),
          const SizedBox(height: 16),

          // Categories Grid
          ReusableGridView(
            items: _controller.categories,
            crossAxisCount: 4,
            crossAxisSpacing: 12,
            mainAxisSpacing: 20,
            childAspectRatio: 0.8,
            itemBuilder:
                (context, category, index) => ReusableCategoryItem(
                  image: category['image']!,
                  title: category['title']!,
                  onTap: () => _onCategoryTap(category),
                ),
          ),

          const SizedBox(height: 24),

          // Products Grid with Pagination
          _buildProductsWithPagination(),
        ],
      ),
    );
  }

  // Search Results View
  Widget _buildSearchResultsView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Search Summary
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(
            '${_controller.filteredProducts.length} results found for "${_controller.searchQuery.value}"',
            style: TextStyle(
              fontSize: secondary(),
              fontWeight: FontWeight.w500,
            ),
          ),
        ),

        // Filtered Results Grid
        Expanded(
          child: ReusableGridView(
            items: _controller.filteredProducts,
            crossAxisCount: 2,
            childAspectRatio: 0.65,
            itemBuilder: (context, product, index) {
              final heroTag = '${product['id'] ?? product['title']}_$index';

              return ReusableProductCard(
                image: product['image']!,
                title: product['title']!,
                desc: product['desc']!,
                price: product['price']!,
                rating: product['rating'],
                reviewCount: product['reviewCount'],
                heroTag: heroTag,
                onCardTap: () {
                  Get.toNamed(
                    '/ProductDetailPage',
                    arguments: {'product': product, 'heroTag': heroTag},
                  );
                },
                showCartButton: true,
                showRentButton: false,
              );
            },
          ),
        ),
      ],
    );
  }

  // Products with Pagination (Example: Default View)
  Widget _buildProductsWithPagination() {
    final int itemsPerPage = 8;
    final int currentPage = 1;
    final totalPages = (_controller.products.length / itemsPerPage).ceil();
    final start = (currentPage - 1) * itemsPerPage;
    final end = (start + itemsPerPage).clamp(0, _controller.products.length);
    final pageItems = _controller.products.sublist(start, end);

    return Column(
      children: [
        // Products Grid
        ReusableGridView(
          items: pageItems,
          crossAxisCount: 2,
          childAspectRatio: 0.65,
          itemBuilder: (context, product, index) {
            final heroTag = '${product['id'] ?? product['title']}_$index';

            return ReusableProductCard(
              image: product['image']!,
              title: product['title']!,
              desc: product['desc']!,
              price: product['price']!,
              rating: product['rating'],
              reviewCount: product['reviewCount'],
              heroTag: heroTag,
              onCardTap: () {
                Get.toNamed(
                  '/ProductDetailPage',
                  arguments: {'product': product, 'heroTag': heroTag},
                );
              },
              showCartButton: true,
              showRentButton: false,
            );
          },
        ),

        const SizedBox(height: 16),

        // Pagination
        _buildPagination(totalPages),
      ],
    );
  }

  // Pagination
  Widget _buildPagination(int totalPages) {
    return Center(
      child: Wrap(
        spacing: 10,
        runSpacing: 10,
        children: List.generate(totalPages, (i) {
          final num = i + 1;
          final selected = num == 1; // Currently hardcoded to first page
          return GestureDetector(
            onTap: () {
              // TODO: Implement pagination logic
            },
            child: Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: selected ? AppColors.green : Colors.grey.shade200,
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: Text(
                "$num",
                style: TextStyle(
                  color: selected ? Colors.white : Colors.black87,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  // Section Title
  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: primary(),
        fontWeight: FontWeight.w600,
        color: AppColors.green,
      ),
    );
  }

  // Handle Category Tap
  void _onCategoryTap(Map<String, String> category) {
    Get.to(() => CategoryDetailPage(categoryName: category['title']!));
  }
}
