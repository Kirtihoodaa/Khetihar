import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Theme/AppColors.dart';

class ProductDetailsPage extends StatelessWidget {
  final Map<String, dynamic> product;
  final String heroTag;

  ProductDetailsPage({super.key})
      : product = Get.arguments['product'],
        heroTag = Get.arguments['heroTag'];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text(product['title'])),
      body: ListView(
        children: [
          Hero(
            tag: heroTag,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
              child: Image.asset( // keep same as card (asset vs network)
                product['image'],
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(product['title'],
                    style: Theme.of(context).textTheme.headlineSmall),
                const SizedBox(height: 8),
                if (product['desc'] != null)
                  Text(product['desc'],
                      style: Theme.of(context).textTheme.bodyMedium),
                const SizedBox(height: 12),
                Text(
                  product['price'],
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(color: AppColors.green, fontWeight: FontWeight.w700),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
