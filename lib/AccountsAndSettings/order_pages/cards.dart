import 'package:flutter/material.dart';
import 'package:khetihar/Components/CustomAppBar.dart';
import 'package:khetihar/Theme/AppColors.dart';
import 'package:khetihar/Theme/FontSize.dart';

class SavedCardsScreen extends StatelessWidget {
  const SavedCardsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: KCenteredActionsAppBar(title: "Saved Cards"),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Saved Cards",
              style: TextStyle(
                fontSize: secondary(),
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 15),
            buildSavedCard(
              context,
              "Assets/Accounts/card.png", // replace with your blue card asset
              onDelete: () {
                // handle delete
              },
            ),
            const SizedBox(height: 16),
            buildSavedCard(
              context,
              "Assets/Accounts/card.png", // replace with your green card asset
              onDelete: () {
                // handle delete
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget buildSavedCard(
    BuildContext context,
    String imagePath, {
    VoidCallback? onDelete,
  }) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey.shade300),
      ),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          children: [
            // Card image
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(imagePath, fit: BoxFit.cover, height: 160),
              ),
            ),

            // Delete button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: InkWell(
                onTap: onDelete,
                borderRadius: BorderRadius.circular(30),
                child: CircleAvatar(
                  radius: 18,
                  backgroundColor: AppColors.red,
                  child: const Icon(
                    Icons.delete,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
