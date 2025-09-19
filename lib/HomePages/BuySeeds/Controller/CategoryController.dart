import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:khetihar/HomePages/BuySeeds/Controller/CartController.dart';
import 'package:khetihar/HomePages/BuySeeds/MyCart.dart';

class CategoryController extends GetxController {
  CategoryController(this.categoryName);

  final String categoryName;

  final TextEditingController search = TextEditingController();
  final RxString query = ''.obs;

  late final List<Map<String, dynamic>> _allProducts;
  final RxList<Map<String, dynamic>> visible = <Map<String, dynamic>>[].obs;

  final CartController _cart = Get.put(CartController(), permanent: true);

  @override
  void onInit() {
    super.onInit();
    _allProducts = _buildProductsFor(categoryName);
    visible.assignAll(_allProducts);

    search.addListener(() => query.value = search.text);
  }

  @override
  void onClose() {
    search.dispose();
    super.onClose();
  }

  void clearSearch() {
    search.clear();
    filter('');
  }

  void filter(String q) {
    final s = q.trim().toLowerCase();
    if (s.isEmpty) {
      visible.assignAll(_allProducts);
    } else {
      visible.assignAll(
        _allProducts.where((p) =>
            p['title'].toString().toLowerCase().contains(s) ||
            p['desc'].toString().toLowerCase().contains(s)),
      );
    }
  }

  void addToCart(Map<String, dynamic> product) {
    _cart.addToCart(product);
    Get.to(() => MyCartPage());
  }

  // ---------- seed/mock data ----------
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

    final imageMap = {
      "Wheat": "Assets/Seeds/rice.png",
      "Rice": "Assets/Seeds/rice.png",
      "Maize": "Assets/Seeds/rice.png",
      "Barley": "Assets/Seeds/rice.png",
      "Tomato": "Assets/Seeds/rice.png",
      "Cucumber": "Assets/Seeds/rice.png",
      "Brinjal": "Assets/Seeds/rice.png",
      "Okra": "Assets/Seeds/rice.png",
      "Mustard": "Assets/Seeds/rice.png",
      "Groundnut": "Assets/Seeds/rice.png",
      "Sunflower": "Assets/Seeds/rice.png",
      "Soybean": "Assets/Seeds/rice.png",
      "Apple": "Assets/Seeds/rice.png",
      "Mango": "Assets/Seeds/rice.png",
      "Banana": "Assets/Seeds/rice.png",
      "Papaya": "Assets/Seeds/rice.png",
      "Chickpea": "Assets/Seeds/rice.png",
      "Moong": "Assets/Seeds/rice.png",
      "Urad": "Assets/Seeds/rice.png",
      "Arhar": "Assets/Seeds/rice.png",
      "Turmeric": "Assets/Seeds/rice.png",
      "Ginger": "Assets/Seeds/rice.png",
      "Chili": "Assets/Seeds/rice.png",
      "Coriander": "Assets/Seeds/rice.png",
      "Cotton": "Assets/Seeds/rice.png",
      "Jute": "Assets/Seeds/rice.png",
      "Hemp": "Assets/Seeds/rice.png",
      "Flax": "Assets/Seeds/rice.png",
      "Lucerne": "Assets/Seeds/rice.png",
      "Bajra": "Assets/Seeds/rice.png",
      "Jowar": "Assets/Seeds/rice.png",
      "Cowpea": "Assets/Seeds/rice.png",
    };

    String descFor(String name) => switch (name) {
          "Wheat" => "Grow high-yield, disease-resistant ...",
          "Rice" => "Cultivate rich, aromatic, and nutr...",
          "Maize" => "Grow high-yield, disease-resistant ...",
          "Barley" => "Cultivate rich, aromatic, and nutr...",
          _ => "Premium, high-germination quality seeds...",
        };

    return List.generate(titles.length, (i) {
      final t = titles[i];
      return {
        "id": i + 1, // replace with backend id later
        "image": imageMap[t] ?? "Assets/Seeds/rice.png",
        "title": t,
        "desc": descFor(t),
        "price": 146, // keep numeric for calculations
        "rating": 4.4,
        "reviewCount": 124,
      };
    });
  }
}