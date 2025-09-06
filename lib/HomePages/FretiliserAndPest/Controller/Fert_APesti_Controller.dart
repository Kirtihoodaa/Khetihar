import 'package:get/get.dart';

enum FPTab { fertilizer, pesticide }

class FertilizerPesticideController extends GetxController {
  // Reactive state for the selected tab
  var selectedTab = FPTab.fertilizer.obs;

  // Data for fertilizer and pesticide categories
  final List<Map<String, String>> fertilizerCategories = [
    {"image": "Assets/Seeds/plant.png", "title": "Organic"},
    {"image": "Assets/Seeds/plant.png", "title": "Chemical"},
    {"image": "Assets/Seeds/plant.png", "title": "Bio"},
    {"image": "Assets/Seeds/plant.png", "title": "Nitrogen-Based"},
    {"image": "Assets/Seeds/plant.png", "title": "Slow-release"},
    {"image": "Assets/Seeds/plant.png", "title": "Composite"},
    {"image": "Assets/Seeds/plant.png", "title": "Liquid"},
    {"image": "Assets/Seeds/plant.png", "title": "Phosphate"},
    {"image": "Assets/Seeds/plant.png", "title": "Foliar"},
    {"image": "Assets/Seeds/plant.png", "title": "Potash"},
  ];

  final List<Map<String, String>> pesticideCategories = const [
    {"image": "Assets/Seeds/chemical.png", "title": "Insecticides"},
    {"image": "Assets/Seeds/chemical.png", "title": "Systemic"},
    {"image": "Assets/Seeds/chemical.png", "title": "Soil"},
    {"image": "Assets/Seeds/chemical.png", "title": "Seed Treatment"},
    {"image": "Assets/Seeds/chemical.png", "title": "Fungicides"},
    {"image": "Assets/Seeds/chemical.png", "title": "Bio"},
  ];

  final List<Map<String, dynamic>> fertilizerProducts = [
    {
      "id": 1,
      "image": "Assets/Seeds/Fertiliser.png",
      "title": "Shovel",
      "desc": "Durable shovel for soil work",
      "price": "INR 120/ Day",
      "rating": 4.4,
      "reviewCount": 40,
    },
    {
      "id": 2,
      "image": "Assets/Seeds/Fertiliser.png",
      "title": "Trowel",
      "desc": "Hand trowel for planting",
      "price": "INR 120/ Day",
      "rating": 4.4,
      "reviewCount": 32,
    },
    {
      "id": 3,
      "image": "Assets/Seeds/Fertiliser.png",
      "title": "Hoe",
      "desc": "Sturdy hoe for weeding",
      "price": "INR 150/ Day",
      "rating": 4.5,
      "reviewCount": 28,
    },
    {
      "id": 4,
      "image": "Assets/Seeds/Fertiliser.png",
      "title": "Rake",
      "desc": "Steel rake for soil leveling",
      "price": "INR 100/ Day",
      "rating": 4.3,
      "reviewCount": 19,
    },
  ];

  final List<Map<String, dynamic>> pesticideProducts = [
    {
      "id": 101,
      "image": "Assets/Seeds/pestiside.png",
      "title": "Knapsack Sprayer",
      "desc": "Manual sprayer for pesticides",
      "price": "INR 450/ Day",
      "rating": 4.6,
      "reviewCount": 58,
    },
    {
      "id": 102,
      "image": "Assets/Seeds/pestiside.png",
      "title": "Power Tiller",
      "desc": "Compact tillage Pestcide",
      "price": "INR 1,500/ Day",
      "rating": 4.5,
      "reviewCount": 73,
    },
    {
      "id": 103,
      "image": "Assets/Seeds/pestiside.png",
      "title": "Knapsack Sprayer",
      "desc": "Manual sprayer for pesticides",
      "price": "INR 450/ Day",
      "rating": 4.6,
      "reviewCount": 58,
    },
    {
      "id": 104,
      "image": "Assets/Seeds/pestiside.png",
      "title": "Power Tiller",
      "desc": "Compact tillage Pestcide",
      "price": "INR 1,500/ Day",
      "rating": 4.5,
      "reviewCount": 73,
    },
  ];

  // Active products and categories based on the selected tab
  List<Map<String, dynamic>> get activeProducts =>
      selectedTab.value == FPTab.fertilizer
          ? fertilizerProducts
          : pesticideProducts;

  List<Map<String, String>> get activeCategories =>
      selectedTab.value == FPTab.fertilizer
          ? fertilizerCategories
          : pesticideCategories;
}
