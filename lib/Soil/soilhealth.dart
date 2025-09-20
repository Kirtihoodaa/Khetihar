import 'package:flutter/material.dart';
import 'package:khetihar/Theme/AppColors.dart';
import 'package:khetihar/Theme/FontSize.dart';

class SoilCarePage extends StatelessWidget {
  final List<SoilCareItem> items = [
    SoilCareItem(
      imagePath: "Assets/Soil/soil.png",
      title: "Season: Pre-Sowing",
      subtitle: "3 steps to prepare your soil",
    ),
    SoilCareItem(
      imagePath: "Assets/Soil/soil.png",
      title: "Preparing Clay Soil",
      subtitle: "Breaking up compacted soil",
    ),
    SoilCareItem(
      imagePath: "Assets/Soil/soil.png",
      title: "Nutrient Basics",
      subtitle: "Adding key nutrients before planting",
    ),
  ];

  SoilCarePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Soil Care",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: secondary(),
                  color: AppColors.green,
                ),
              ),
              const SizedBox(height: 12),
              Column(children: items.map((item) => _buildCard(item)).toList()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCard(SoilCareItem item) {
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 3,
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image
          Image.asset(
            item.imagePath,
            height: 160,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          // Title + Subtitle
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: secondary(),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  item.subtitle,
                  style: TextStyle(fontSize: medium(), color: Colors.black),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SoilCareItem {
  final String imagePath;
  final String title;
  final String subtitle;

  SoilCareItem({
    required this.imagePath,
    required this.title,
    required this.subtitle,
  });
}
