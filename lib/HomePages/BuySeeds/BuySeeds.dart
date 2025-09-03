import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:khetihar/Components/CategoryItems.dart';
import 'package:khetihar/Components/GridView.dart';
import 'package:khetihar/Components/ProductCard.dart';
import 'package:khetihar/Components/SecondaryAppBar.dart';
import 'package:khetihar/HomePages/BuySeeds/CategoryDetails.dart';
import 'package:khetihar/Theme/AppColors.dart';
import 'package:khetihar/Theme/FontSize.dart';

class SeedsPage extends StatelessWidget {
  const SeedsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SeedPageContent();
  }
}

class SeedPageContent extends StatefulWidget {
  const SeedPageContent({super.key});

  @override
  State<SeedPageContent> createState() => _SeedPageContentState();
}

class _SeedPageContentState extends State<SeedPageContent> {
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> _filteredProducts = [];
  bool _isSearching = false;

  // ---- DUMMY DATA ----
  final List<Map<String, String>> categories = const [
    {"image": "Assets/Seeds/Cereal.png", "title": "Cereal Seeds"},
    {"image": "Assets/Seeds/Vegetable.png", "title": "Vegetable Seeds"},
    {"image": "Assets/Seeds/OilSeed.png", "title": "Oilseed Crops"},
    {"image": "Assets/Seeds/Fruit.png", "title": "Fruit Seeds"},
    {"image": "Assets/Seeds/Pulse.png", "title": "Pulse Seeds"},
    {"image": "Assets/Seeds/Pulse.png", "title": "Spices & Medicinal"},
    {"image": "Assets/Seeds/Pulse.png", "title": "Fibre Crops"},
    {"image": "Assets/Seeds/Pulse.png", "title": "Fodder Crops"},
  ];

  late List<Map<String, dynamic>> products;

  @override
  void initState() {
    super.initState();
    products = List.generate(
      30,
      (i) => {
        "image": "Assets/Seeds/rice.png",
        "title": ["Wheat", "Rice", "Maize", "Barley"][i % 4],
        "desc": "High yield, disease-resistant… item #${i + 1}",
        "price": "INR ${120 + (i % 5) * 10}",
        "rating": 4.4,
        "reviewCount": 124 + (i % 10) * 5,
        "category": ["Cereal", "Vegetable", "Oilseed", "Pulse"][i % 4],
      },
    );
    _filteredProducts = products;
    _searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    final q = _searchController.text.trim().toLowerCase();
    setState(() {
      _isSearching = q.isNotEmpty;
      _filteredProducts =
          products.where((p) {
            return p['title'].toString().toLowerCase().contains(q) ||
                p['category'].toString().toLowerCase().contains(q) ||
                p['desc'].toString().toLowerCase().contains(q);
          }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: Secondaryappbar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Search Section
          Padding(
            padding: const EdgeInsets.all(16),
            child: _buildSearchSection(),
          ),
          const SizedBox(height: 20),

          // Expanded content based on search state
          Expanded(
            child:
                _isSearching ? _buildSearchResultsView() : _buildDefaultView(),
          ),
        ],
      ),
    );
  }

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
              decoration: InputDecoration(
                hintText: "Search For Seeds",
                hintStyle: TextStyle(
                  color: Colors.black,
                  fontSize: secondary(),
                ),
                border: InputBorder.none,
                suffixIcon:
                    _searchController.text.isNotEmpty
                        ? IconButton(
                          icon: const Icon(Icons.clear, color: Colors.grey),
                          onPressed: () {
                            _searchController.clear();
                          },
                        )
                        : null,
              ),
            ),
          ),
          GestureDetector(
            onTap: _onSearchChanged,
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
            items: categories,
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

  Widget _buildSearchResultsView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Search Summary
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(
            '${_filteredProducts.length} results found for "${_searchController.text}"',
            style: TextStyle(
              fontSize: secondary(),
              fontWeight: FontWeight.w500,
            ),
          ),
        ),

        // Filtered Results Grid
        Expanded(
          child: ReusableGridView(
            items: _filteredProducts,
            crossAxisCount: 2,
            childAspectRatio: 0.65,
            itemBuilder:
                (context, product, index) => ReusableProductCard(
                  image: product['image']!,
                  title: product['title']!,
                  desc: product['desc']!,
                  price: product['price']!,
                  rating: product['rating'],
                  reviewCount: product['reviewCount'],
                  onCardTap: () => _onProductTap(product),
                ),
          ),
        ),

        // Optional: Filter and Sort Options
        _buildSearchFilterOptions(),
      ],
    );
  }

  Widget _buildProductsWithPagination() {
    final int itemsPerPage = 8;
    final int currentPage = 1;
    final totalPages = (products.length / itemsPerPage).ceil();
    final start = (currentPage - 1) * itemsPerPage;
    final end = (start + itemsPerPage).clamp(0, products.length);
    final pageItems = products.sublist(start, end);

    return Column(
      children: [
        // Products Grid
        ReusableGridView(
          items: pageItems,
          crossAxisCount: 2,
          childAspectRatio: 0.65,
          itemBuilder:
              (context, product, index) => ReusableProductCard(
                image: product['image']!,
                title: product['title']!,
                desc: product['desc']!,
                price: product['price']!,
                rating: product['rating'],
                reviewCount: product['reviewCount'],
                onCardTap: () => _onProductTap(product),
              ),
        ),

        const SizedBox(height: 16),

        // Pagination
        _buildPagination(totalPages),
      ],
    );
  }

  Widget _buildSearchFilterOptions() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Category Filter
          ElevatedButton.icon(
            onPressed: _showCategoryFilter,
            icon: const Icon(Icons.filter_list),
            label: Text('Filter', style: TextStyle(fontSize: medium())),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
            ),
          ),

          // Sort Option
          ElevatedButton.icon(
            onPressed: _showSortOptions,
            icon: const Icon(Icons.sort),
            label: Text('Sort', style: TextStyle(fontSize: medium())),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

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
              // setState(() => currentPage = num);
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

  // Event Handlers
  void _onCategoryTap(Map<String, String> category) {
    Get.to(() => CategoryDetailPage(categoryName: category['title']!));
  }

  void _onProductTap(Map<String, dynamic> product) {
    print("Product tapped: ${product['title']}");
    // Navigate to product details
  }

  void _showCategoryFilter() {
    showModalBottomSheet(
      context: context,
      builder:
          (context) => Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Filter Categories',
                  style: TextStyle(
                    fontSize: primary(),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                
              ],
            ),
          ),
    );
  }

  void _showSortOptions() {
    showModalBottomSheet(
      context: context,
      builder:
          (context) => Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Sort Options',
                  style: TextStyle(
                    fontSize: primary(),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                // Add sort radio buttons
              ],
            ),
          ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
