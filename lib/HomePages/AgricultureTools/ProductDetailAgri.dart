import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khetihar/Components/CustomButton.dart';
import 'package:khetihar/Components/PhotoRow.dart';
import '../../Components/InputFields.dart';
import '../../Components/SecondaryAppBar.dart';
import '../../Theme/AppColors.dart';
import '../../Theme/FontSize.dart';

class ProductDetailAgri extends StatelessWidget {
  final Map<String, dynamic> product;
  final String heroTag;

  ProductDetailAgri({super.key})
    : product = Get.arguments['product'],
      heroTag = Get.arguments['heroTag'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: Secondaryappbar(),
      body: ListView(
        children: [
          Hero(
            tag: heroTag,
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                  child: Image.asset(
                    product['image'],
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                ),
                Positioned(
                  top: 16,
                  right: 16,
                  child: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    child: IconButton(
                      icon: const Icon(Icons.favorite_border),
                      color: AppColors.green,
                      onPressed: () {
                        // Handle favorite action
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product['title'],
                  style: Theme.of(
                    context,
                  ).textTheme.headlineSmall?.copyWith(color: AppColors.green),
                ),
                Text(
                  product['price'],
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: AppColors.green,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "Description",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: primary(),
                  ),
                ),
                if (product['desc'] != null)
                  Text(
                    product['desc'],
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                const SizedBox(height: 12),
                Text(
                  "Specifications",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: primary(),
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(child: buildSpecItem("Engine Power", "9 HP")),
                    Expanded(child: buildSpecItem("Fuel Type", "Diesel")),
                    Expanded(child: buildSpecItem("Weight", "160 kg")),
                  ],
                ),
                const SizedBox(height: 16),

                // Row 2
                Row(
                  children: [
                    Expanded(child: buildSpecItem("Working Depth", "8 inches")),
                    Expanded(
                      child: buildSpecItem("Tilling Width", "36 inches"),
                    ),
                    const Spacer(), // balances alignment with Row 1
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  "Rental Terms",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: primary(),
                  ),
                ),

                const SizedBox(height: 8),

                Text(
                  "• Minimum rental period: 1 day\n"
                  "• Security deposit required\n"
                  "• Equipment must be returned in good condition\n"
                  "• Late returns may incur additional charges",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: CustomButton(
                width: MediaQuery.sizeOf(context).width*0.7,
                text: "Rent Now",
                onPressed: () {},
                backgroundColor: AppColors.green,
                foregroundColor: Colors.white,
              ),
            ),

          ],
        ),
      ),
    );
  }

  Widget buildSpecItem(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: tertiary(),
            color: Colors.black54, // lighter for label
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontSize: tertiary(),
            fontWeight: FontWeight.bold,
            color: Colors.black, // bold for value
          ),
        ),
      ],
    );
  }
}
