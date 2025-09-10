import 'package:flutter/material.dart';
import 'package:khetihar/Components/CustomAppBar.dart';
import 'package:khetihar/Theme/AppColors.dart';
import 'package:khetihar/Theme/FontSize.dart';

class SavedArticlesPage extends StatelessWidget {
  final List<Article> articles = [
    Article(
      imagePath: "Assets/NewsTrends/basket.png", // put your asset image here
      tag: "Saved 2 Days Ago",
      title: "Corn yields expected to increase by 15% this season",
      description:
          "Corn yields expected to increase by 15% this season forecast comes after favorable weather ...",
      date: "June 15, 2023",
      isStarred: false,
    ),
    Article(
      imagePath: "Assets/NewsTrends/basket.png", // put your asset image here
      tag: "Saved Yesterday",
      title: "Climate Change Impact on Regional Crop Patterns",
      description:
          "New research shows shifting growing seasons and changing...",
      date: "June 15, 2023",
      isStarred: true,
    ),
  ];

  SavedArticlesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(),
      body: SafeArea(
        child: ListView.builder(
          padding: const EdgeInsets.all(12),
          itemCount: articles.length,
          itemBuilder: (context, index) {
            return _buildArticleCard(context, articles[index]);
          },
        ),
      ),
    );
  }

  Widget _buildArticleCard(BuildContext context, Article article) {
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image
          Stack(
            children: [
              Image.asset(
                article.imagePath,
                height: 180,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              if (article.isStarred)
                Positioned(
                  top: 8,
                  right: 8,
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Icon(Icons.star, color: Colors.amber),
                  ),
                ),
            ],
          ),

          // Tag
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            color: AppColors.darkGreen,
            child: Text(
              article.tag,
              style: const TextStyle(color: Colors.white, fontSize: 12),
            ),
          ),

          // Content
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  article.title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: primary(),
                    color: AppColors.green,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  article.description,
                  style: TextStyle(color: Colors.black),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                Text(
                  article.date,
                  style: TextStyle(color: Colors.black, fontSize: medium()),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Article {
  final String imagePath;
  final String tag;
  final String title;
  final String description;
  final String date;
  final bool isStarred;

  Article({
    required this.imagePath,
    required this.tag,
    required this.title,
    required this.description,
    required this.date,
    required this.isStarred,
  });
}
