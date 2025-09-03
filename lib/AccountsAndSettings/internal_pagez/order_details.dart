import 'package:flutter/material.dart';
import 'package:khetihar/AccountsAndSettings/internal_pagez/order_status_timeline.dart';
import 'package:khetihar/Components/CustomAppBar.dart';
import 'package:khetihar/Theme/AppColors.dart';

import 'package:intl/intl.dart';

import '../../Theme/FontSize.dart';
import 'order_summary_card.dart';

class OrderDetails extends StatelessWidget {
  OrderDetails({super.key});

  final steps = [
    TimelineStep(
      title: 'Order Placed',
      color: AppColors.green,
      icon: Icons.check, // white check in green circle
      dateTime: DateTime(2025, 7, 1, 10, 32),
    ),
    TimelineStep(
      title: 'Processing',
      color: const Color(0xFFF59E0B), // amber
      icon: Icons.access_time_filled,
      dateTime: DateTime(2025, 7, 1, 14, 45),
    ),
    TimelineStep(
      title: 'Shipped',
      color: const Color(0xFF2563EB), // blue
      icon: Icons.local_shipping_rounded,
      dateTime: DateTime(2025, 7, 1, 18, 45),
    ),
    TimelineStep(
      title: 'Delivered',
      color: AppColors.green,
      icon: Icons.inventory_2_rounded,
      subtitle: 'Pending',
      // or pass dateTime for timestamp
      dimSubtitle: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: KCenteredActionsAppBar(
        title: "Order Details",
        avatarImage: AssetImage("Assets/HomeScreens/Logo.png"),
      ),
      backgroundColor: Colors.white,
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                child: OrderEtaSectionExact(
                  orderId: 'FO-39845',
                  orderDate: DateTime(2025, 7, 1),
                  statusText: 'Shipped',
                  etaDate: DateTime(2025, 7, 11),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 18),
                child: OrderStatusTimeline(steps: steps),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: ShippingAndPaymentDetails(
                  addressText:
                      'John Doe123 Garden Street, Apt 4BGreenville,\nCA 94582 India',
                  cardBrand: 'Visa',
                  cardLast4: '4242',
                  cardExpiry: '12/25',
                ),
              ),
              SizedBox(height: 16),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 6),
                child: OrderSummaryCard(
                  items: [
                    OrderSummaryItem(
                      name: 'Wheat Seed',
                      priceText: 'INR 146',
                      qty: 2,
                      image: const AssetImage('Assets/Seeds/OilSeed.png'),
                    ),
                    OrderSummaryItem(
                      name: 'Turmeric',
                      priceText: 'INR 146',
                      qty: 2,
                      image: const AssetImage('Assets/Seeds/OilSeed.png'),
                    ),
                    OrderSummaryItem(
                      name: 'Berseem',
                      priceText: 'INR 146',
                      qty: 2,
                      image: const AssetImage('Assets/Seeds/OilSeed.png'),
                    ),
                  ],

                  subtotalText: 'INR 500',
                  shippingText: 'Free',
                  totalText: 'INR 500',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ===== Order header + ETA card (exact-match) =====
class OrderEtaSectionExact extends StatelessWidget {
  const OrderEtaSectionExact({
    super.key,
    required this.orderId, // e.g. 'FO-39845'
    required this.orderDate, // e.g. DateTime(2025, 7, 1)
    required this.etaDate, // e.g. DateTime(2025, 7, 11)
    this.statusText = 'Shipped',
    this.statusColor = const Color(0xFF2563EB), // blue in the mock
    this.padding = const EdgeInsets.fromLTRB(16, 12, 16, 0),
  });

  final String orderId;
  final DateTime orderDate;
  final DateTime etaDate;
  final String statusText;
  final Color statusColor;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    // lock text scale for pixel parity
    final mq = MediaQuery.of(context).copyWith(textScaleFactor: 1.0);
    final orderDateStr = DateFormat('MMMM dd, yyyy').format(orderDate);
    final etaDateStr = DateFormat('MMMM dd, yyyy').format(etaDate);

    return MediaQuery(
      data: mq,
      child: Padding(
        padding: padding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title (en dash, bold, dark)
            Text(
              'Order ID – #$orderId',
              style: TextStyle(
                fontSize: primary(), // 18
                fontWeight: FontWeight.w700, // bold like image
                color: Colors.black87,
                height: 1.2,
              ),
            ),
            const SizedBox(height: 6),

            // Date + Status (single line)
            Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Text(
                  orderDateStr,
                  style: TextStyle(
                    fontSize: tertiary(), // 14
                    color: Colors.black.withOpacity(0.75),
                    height: 1.25,
                  ),
                ),
                const SizedBox(width: 10), // exact gap
                Text(
                  statusText,
                  style: TextStyle(
                    fontSize: tertiary(), // 14
                    fontWeight: FontWeight.w600, // semi-bold blue
                    color: statusColor,
                    height: 1.25,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 14),

            // ETA card (rounded, thin border, soft shadow)
            Container(
              width: double.infinity,
              height: 100,
              padding: const EdgeInsets.fromLTRB(16, 18, 16, 14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14), // radius = 14
                border: Border.all(color: AppColors.greyBorder, width: 1),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.06), // soft
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Estimated Delivery',
                    style: TextStyle(
                      fontSize: secondary(), // 16
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    etaDateStr,
                    style: TextStyle(
                      fontSize: tertiary(), // 14
                      color: Colors.black.withOpacity(0.70),
                      height: 1.25,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Drop-in section that renders:
///  - Shipping Address (title + pin icon + multiline address)
///  - Payment Information (title + card icon + brand+last4 + expiry)
class ShippingAndPaymentDetails extends StatelessWidget {
  const ShippingAndPaymentDetails({
    super.key,
    required this.addressText,
    required this.cardBrand, // e.g. 'Visa'
    required this.cardLast4, // e.g. '4242'
    required this.cardExpiry, // e.g. '12/25'
    this.padding = const EdgeInsets.fromLTRB(16, 8, 16, 0),
  });

  final String addressText;
  final String cardBrand;
  final String cardLast4;
  final String cardExpiry;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    // lock scaling for strict visual match (optional)
    final mq = MediaQuery.of(context).copyWith(textScaleFactor: 1.0);

    return MediaQuery(
      data: mq,
      child: Padding(
        padding: padding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Shipping Address
            _SectionTitle('Shipping Address'),
            const SizedBox(height: 6),
            _IconBlock(
              icon: Icons.location_on_outlined,
              child: Text(
                addressText,
                style: TextStyle(
                  fontSize: secondary(), // 16
                  color: Colors.black.withOpacity(0.80), // like screenshot
                  height: 1.35,
                ),
              ),
            ),

            const SizedBox(height: 18),

            // Payment Information
            _SectionTitle('Payment Information'),
            const SizedBox(height: 6),
            _IconBlock(
              icon: Icons.credit_card_outlined,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // "Visa •••• 4242"
                  RichText(
                    text: TextSpan(
                      style: TextStyle(
                        fontSize: secondary(), // 16
                        color: Colors.black87,
                        height: 1.2,
                      ),
                      children: [
                        TextSpan(
                          text: '$cardBrand ',
                          style: const TextStyle(fontWeight: FontWeight.w700),
                        ),
                        const TextSpan(text: '•••• '),
                        TextSpan(
                          text: cardLast4,
                          style: const TextStyle(fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Expires $cardExpiry',
                    style: TextStyle(
                      fontSize: tertiary(), // 14
                      color: Colors.black.withOpacity(0.65),
                      height: 1.3,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Green section title (18 / w600)
class _SectionTitle extends StatelessWidget {
  const _SectionTitle(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: primary(), // 18
        fontWeight: FontWeight.w600,
        color: AppColors.green,
        height: 1.2,
      ),
    );
  }
}

/// Left icon gutter + content (keeps icon aligned to both lines)
class _IconBlock extends StatelessWidget {
  const _IconBlock({required this.icon, required this.child});

  final IconData icon;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Icon column
        SizedBox(
          width: 28,
          child: Align(
            alignment: Alignment.topLeft,
            child: Icon(icon, size: 20, color: AppColors.green),
          ),
        ),
        const SizedBox(width: 4),
        // Texts
        Expanded(child: child),
      ],
    );
  }
}
