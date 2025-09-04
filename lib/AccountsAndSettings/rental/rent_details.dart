import 'package:flutter/material.dart';
import 'package:khetihar/AccountsAndSettings/rental/rent_summary_card.dart';
import 'package:khetihar/Components/CustomAppBar.dart';
import 'package:khetihar/Theme/AppColors.dart';

import 'package:intl/intl.dart';

import '../../Theme/FontSize.dart';
import '../order_pages/order_details.dart';
import '../order_pages/order_status_timeline.dart';
import '../order_pages/order_summary_card.dart';

class RentDetails extends StatelessWidget {
  RentDetails({super.key});

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
        title: "Rent Details",
        avatarImage: AssetImage("Assets/HomeScreens/Logo.png"),
      ),
      backgroundColor: Colors.white,
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                child: RentEtaSectionExact(
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
                padding: EdgeInsets.symmetric(horizontal: 2),
                child: RentSummaryCard(
                  itemName: 'Power Tiller',
                  priceText: 'INR 1500',
                  rentalDays: 3,
                  returnDateText: '12-07-2025',
                  securityDepositText: 'INR 2000',
                  subtotalText: 'INR 1500',
                  shippingText: 'Free',
                  totalText: 'INR 3500',
                  image: const AssetImage('Assets/Seeds/OilSeed.png'),
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
class RentEtaSectionExact extends StatelessWidget {
  const RentEtaSectionExact({
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
              'Rent ID – #$orderId',
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
