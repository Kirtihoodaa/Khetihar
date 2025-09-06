import 'package:get/get.dart';

class SeedsController extends GetxController {
  var searchQuery = ''.obs;
  var filteredProducts = <Map<String, dynamic>>[].obs;
  var isSearching = false.obs;

  // Dummy Data
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
  void onInit() {
    super.onInit();

    // Generate dummy products
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

    // Initialize filteredProducts
    filteredProducts.value = products;
  }

  // Function to handle search query change
  void onSearchChanged(String query) {
    searchQuery.value = query.trim().toLowerCase();
    isSearching.value = searchQuery.value.isNotEmpty;

    filteredProducts.value = products.where((product) {
      return product['title']!.toLowerCase().contains(searchQuery.value) ||
          product['category']!.toLowerCase().contains(searchQuery.value) ||
          product['desc']!.toLowerCase().contains(searchQuery.value);
    }).toList();
  }

  // Function to reset search
  void clearSearch() {
    searchQuery.value = '';
    isSearching.value = false;
    filteredProducts.value = products;
  }
}
