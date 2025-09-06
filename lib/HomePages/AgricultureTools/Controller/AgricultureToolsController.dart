import 'package:get/get.dart';

enum FPTab { Tools, Equipments }

class ToollsEquipmentController extends GetxController {
  // Reactive state for the selected tab
  var selectedTab = FPTab.Tools.obs;

  // Data for tools and Equipments categories
  final List<Map<String, String>> ToolsCategories = [
    {"image": "Assets/Seeds/Tools1.png", "title": "Hand"},
    {"image": "Assets/Seeds/Tools1.png", "title": "Cutting"},
    {"image": "Assets/Seeds/Tools1.png", "title": "Measuring"},
    {"image": "Assets/Seeds/Tools1.png", "title": "Irrigation"},
    {"image": "Assets/Seeds/Tools1.png", "title": "Planting"},
    {"image": "Assets/Seeds/Tools1.png", "title": "Weeding"},
    {"image": "Assets/Seeds/Tools1.png", "title": "Soil Preparation"},
  ];

  final List<Map<String, String>> EquipmentsCategories = const [
    {"image": "Assets/Seeds/Equipment1.png", "title": "Sprayers"},
    {"image": "Assets/Seeds/Equipment1.png", "title": "Power Tiller"},
    {"image": "Assets/Seeds/Equipment1.png", "title": "Harvester"},
    {"image": "Assets/Seeds/Equipment1.png", "title": "Seed Drill"},
    {"image": "Assets/Seeds/Equipment1.png", "title": "Thresher"},
    {"image": "Assets/Seeds/Equipment1.png", "title": "Rotavator"},
  ];

  final List<Map<String, dynamic>> ToolsProducts = [
    {
      "id": 1,
      "image": "Assets/Seeds/Equipment.png",
      "title": "Shovel",
      "desc": "Durable shovel for soil work",
      "price": "INR 120/ Day",
      "rating": 4.4,
      "reviewCount": 40,
    },
    {
      "id": 2,
      "image": "Assets/Seeds/Equipment.png",
      "title": "Trowel",
      "desc": "Hand trowel for planting",
      "price": "INR 120/ Day",
      "rating": 4.4,
      "reviewCount": 32,
    },
    {
      "id": 3,
      "image": "Assets/Seeds/Equipment.png",
      "title": "Hoe",
      "desc": "Sturdy hoe for weeding",
      "price": "INR 150/ Day",
      "rating": 4.5,
      "reviewCount": 28,
    },
    {
      "id": 4,
      "image": "Assets/Seeds/Equipment.png",
      "title": "Rake",
      "desc": "Steel rake for soil leveling",
      "price": "INR 100/ Day",
      "rating": 4.3,
      "reviewCount": 19,
    },
  ];

  final List<Map<String, dynamic>> EquipmentsProducts = [
    {
      "id": 101,
      "image": "Assets/Seeds/Tools.png",
      "title": "Knapsack Sprayer",
      "desc": "Manual sprayer for pesticides",
      "price": "INR 450/ Day",
      "rating": 4.6,
      "reviewCount": 58,
    },
    {
      "id": 102,
      "image": "Assets/Seeds/Tools.png",
      "title": "Power Tiller",
      "desc": "Compact tillage Pestcide",
      "price": "INR 1,500/ Day",
      "rating": 4.5,
      "reviewCount": 73,
    },
    {
      "id": 103,
      "image": "Assets/Seeds/Tools.png",
      "title": "Knapsack Sprayer",
      "desc": "Manual sprayer for pesticides",
      "price": "INR 450/ Day",
      "rating": 4.6,
      "reviewCount": 58,
    },
    {
      "id": 104,
      "image": "Assets/Seeds/Tools.png",
      "title": "Power Tiller",
      "desc": "Compact tillage Pestcide",
      "price": "INR 1,500/ Day",
      "rating": 4.5,
      "reviewCount": 73,
    },
  ];

  // Active products and categories based on the selected tab
  List<Map<String, dynamic>> get activeProducts =>
      selectedTab.value == FPTab.Tools ? ToolsProducts : EquipmentsProducts;

  List<Map<String, String>> get activeCategories =>
      selectedTab.value == FPTab.Tools ? ToolsCategories : EquipmentsCategories;
}
