import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'package:intl/intl.dart';
import 'package:khetihar/AccountsAndSettings/internal_pagez/order_details.dart';

import '../../Theme/AppColors.dart';
import '../../Theme/FontSize.dart';
import '../../Components/CustomAppBar.dart';

class MyOrders extends StatelessWidget {
  const MyOrders({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: KCenteredActionsAppBar(
        title: "My Orders",
        avatarImage: AssetImage('Assets/HomeScreens/Logo.png'),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: Column(
          children: [
            OrderCard(
              orderId: 'FO-39845',
              status: OrderStatus.delivered,
              date: DateTime(2025, 7, 1),
              productName: 'Wheat Seed',
              imageProvider: const AssetImage('Assets/Seeds/rice.png'),
              onTap: () {
                Get.to(() => OrderDetails());
              },
              onReviewTap: () {},
            ),
            OrderCard(
              orderId: 'FO-39845',
              status: OrderStatus.shipped,
              date: DateTime(2025, 7, 1),
              productName: 'Wheat Seed',
              imageProvider: const AssetImage('Assets/Seeds/rice.png'),
              onTap: () {
                Get.to(() => OrderDetails());
              },
              // onReviewTap omitted (disabled state like mock)
            ),
          ],
        ),
      ),
    );
  }
}

enum OrderStatus { delivered, shipped }

class OrderCard extends StatelessWidget {
  const OrderCard({
    super.key,
    required this.orderId,
    required this.status,
    required this.date,
    required this.productName,
    required this.imageProvider,
    this.onTap,
    this.onReviewTap,
  });

  final String orderId;
  final OrderStatus status;
  final DateTime date;
  final String productName;
  final ImageProvider imageProvider;
  final VoidCallback? onTap;
  final VoidCallback? onReviewTap;

  @override
  Widget build(BuildContext context) {
    // exact tones used in the UI
    const blue = Color(0xFF2F6BE6); // "Shipped"
    const starGrey = Color(0xFFCfd3DA); // stars
    final isDelivered = status == OrderStatus.delivered;
    final statusColor = isDelivered ? Colors.green : blue;

    return InkWell(
      borderRadius: BorderRadius.circular(14),
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        padding: const EdgeInsets.fromLTRB(16, 14, 12, 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14), // <= radius
          border: Border.all(color: AppColors.greyBorder, width: 1),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06), // soft shadow
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title (use en-dash like mock)
            Text(
              'Order ID – #$orderId',
              style: TextStyle(
                fontSize: secondary(), // 16
                fontWeight: FontWeight.w700,
                color: Colors.black87,
                height: 1.2,
              ),
            ),
            const SizedBox(height: 6),

            // Status
            Text(
              isDelivered ? 'Delivered' : 'Shipped',
              style: TextStyle(
                fontSize: tertiary(), // 14
                fontWeight: FontWeight.w600,
                color: statusColor,
              ),
            ),
            const SizedBox(height: 10),

            // Row: thumb + details + chevron
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _Thumb(imageProvider: imageProvider), // 52×52
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        isDelivered
                            ? 'Delivered on ${DateFormat('MMMM dd, yyyy').format(date)}'
                            : DateFormat('MMMM dd, yyyy').format(date),
                        style: TextStyle(
                          fontSize: tertiary(),
                          color: Colors.black87,
                          height: 1.25,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        productName,
                        style: TextStyle(
                          fontSize: tertiary(),
                          color: Colors.black.withOpacity(0.66),
                          height: 1.25,
                        ),
                      ),
                      const SizedBox(height: 6),
                      // Stars
                      Row(
                        children: List.generate(
                          5,
                          (_) => const Padding(
                            padding: EdgeInsets.only(right: 4),
                            child: Icon(
                              Icons.star_rounded,
                              size: 18,
                              color: starGrey,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 6),
                      // Write a Review (green only when delivered)
                      GestureDetector(
                        onTap: isDelivered ? onReviewTap : null,
                        child: Text(
                          'Write a Review',
                          style: TextStyle(
                            fontSize: tertiary(),
                            fontWeight: FontWeight.w600,
                            color:
                                isDelivered
                                    ? AppColors.green
                                    : Colors.black.withOpacity(0.28),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.chevron_right,
                  size: 20, // <= 20
                  color: Colors.black.withOpacity(0.45),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _Thumb extends StatelessWidget {
  const _Thumb({required this.imageProvider});

  final ImageProvider imageProvider;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Container(
        width: 52, // <= 52
        height: 52,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColors.greyBorder, width: 1),
        ),
        child: Image(image: imageProvider, fit: BoxFit.cover),
      ),
    );
  }
}
