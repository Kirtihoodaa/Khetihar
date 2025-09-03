import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khetihar/Components/SecondaryAppBar.dart';
import 'package:khetihar/Components/GridView.dart';
import 'package:khetihar/Components/ProductCard.dart';
import 'package:khetihar/Theme/AppColors.dart';
import 'package:khetihar/Theme/FontSize.dart';

class CategoryDetailPage extends StatefulWidget {
  final String categoryName;

  const CategoryDetailPage({super.key, required this.categoryName});

  @override
  State<CategoryDetailPage> createState() => _CategoryDetailPageState();
}

class _CategoryDetailPageState extends State<CategoryDetailPage> {
  final TextEditingController _search = TextEditingController();

  late final List<Map<String, dynamic>> _allProducts;
  List<Map<String, dynamic>> _visible = const [];

  @override
  void initState() {
    super.initState();
    _allProducts = _buildProductsFor(widget.categoryName);
    _visible = _allProducts;
    _search.addListener(_onQueryChanged);
  }

  @override
  void dispose() {
    _search.removeListener(_onQueryChanged);
    _search.dispose();
    super.dispose();
  }

  // ---------- DATA ----------
  List<Map<String, dynamic>> _buildProductsFor(String category) {
    final titles = switch (category) {
      "Cereal Seeds" => ["Wheat", "Rice", "Maize", "Barley"],
      "Vegetable Seeds" => ["Tomato", "Cucumber", "Brinjal", "Okra"],
      "Oilseed Crops" => ["Mustard", "Groundnut", "Sunflower", "Soybean"],
      "Fruit Seeds" => ["Apple", "Mango", "Banana", "Papaya"],
      "Pulse Seeds" => ["Chickpea", "Moong", "Urad", "Arhar"],
      "Spices & Medicinal" => ["Turmeric", "Ginger", "Chili", "Coriander"],
      "Fibre Crops" => ["Cotton", "Jute", "Hemp", "Flax"],
      "Fodder Crops" => ["Lucerne", "Bajra", "Jowar", "Cowpea"],
      _ => ["Wheat", "Rice", "Maize", "Barley"],
    };

    final imageMap = {"Wheat": "Assets/Seeds/rice.png"};

    String descFor(String name) => switch (name) {
      "Wheat" => "Grow high-yield, disease-resistant ...",
      "Rice" => "Cultivate rich, aromatic, and nutr...",
      "Maize" => "Grow high-yield, disease-resistant ...",
      "Barley" => "Cultivate rich, aromatic, and nutr...",

      _ => "Premium, high-germination quality seeds...",
    };

    return titles
        .map<Map<String, dynamic>>(
          (t) => {
            "image": imageMap[t] ?? "Assets/Seeds/rice.png",
            "title": t,
            "desc": descFor(t),
            "price": "INR 120",
            "rating": 4.4,
            "reviewCount": 124,
          },
        )
        .toList(growable: false);
  }

  // ---------- SEARCH ----------
  void _onQueryChanged() {
    final q = _search.text.trim().toLowerCase();
    setState(() {
      _visible =
          q.isEmpty
              ? _allProducts
              : _allProducts
                  .where(
                    (p) =>
                        p['title'].toString().toLowerCase().contains(q) ||
                        p['desc'].toString().toLowerCase().contains(q),
                  )
                  .toList(growable: false);
    });
  }

  // ---------- UI ----------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: Secondaryappbar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Bar (rounded + green search button)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: AppColors.secondarygrey,
                borderRadius: BorderRadius.circular(28),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _search,
                      decoration: InputDecoration(
                        hintText: "Search For Seeds",
                        hintStyle: TextStyle(
                          color: Colors.black,
                          fontSize: secondary(),
                        ),
                        border: InputBorder.none,
                        suffixIcon:
                            _search.text.isNotEmpty
                                ? IconButton(
                                  icon: const Icon(
                                    Icons.clear,
                                    color: Colors.grey,
                                  ),
                                  onPressed: () => _search.clear(),
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
            const SizedBox(height: 20),

            // Green Title
            Text(
              widget.categoryName,
              style: TextStyle(
                fontSize: primary(),
                fontWeight: FontWeight.w600,
                color: AppColors.green,
              ),
            ),
            const SizedBox(height: 12),

            // Products Grid (
      ReusableGridView<Map<String, dynamic>>(
        items: _visible,
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.66,
        itemBuilder: (context, p, i) {
          final heroTag = '${p['id'] ?? p['title']}_$i'; // stable & unique

          return ReusableProductCard(
            image: p['image'], // this is an asset path in your card
            title: p['title'],
            price: p['price'],
            desc: p['desc'],
            rating: p['rating'],
            reviewCount: p['reviewCount'],
            heroTag: heroTag,
            onCardTap: () {
              Get.toNamed(
                '/ProductDetailPage',
                arguments: {
                  'product': p,
                  'heroTag': heroTag,
                },
              );
            },

          );
        },
      )

      ],
        ),
      ),
    );
  }
}
