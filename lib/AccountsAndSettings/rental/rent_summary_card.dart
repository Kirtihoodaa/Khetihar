import 'package:flutter/material.dart';
import '../../Theme/AppColors.dart';
import '../../Theme/FontSize.dart';

class RentSummaryCard extends StatelessWidget {
  const RentSummaryCard({
    super.key,
    this.title = 'Rent Summary',
    required this.itemName, // e.g. 'Power Tiller'
    required this.priceText, // e.g. 'INR 1500'
    required this.rentalDays, // e.g. 3
    required this.returnDateText, // e.g. '12-07-2025'
    required this.securityDepositText, // e.g. 'INR 2000'
    required this.subtotalText, // e.g. 'INR 1500'
    required this.shippingText, // e.g. 'Free'
    required this.totalText, // e.g. 'INR 3500'
    required this.image, // ImageProvider
    this.margin = const EdgeInsets.all(12),
    this.padding = const EdgeInsets.fromLTRB(14, 12, 14, 12),
  });

  final String title;
  final String itemName;
  final String priceText;
  final int rentalDays;
  final String returnDateText;
  final String securityDepositText;
  final String subtotalText;
  final String shippingText;
  final String totalText;
  final ImageProvider image;
  final EdgeInsets margin;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    // lock text scaling for 1:1 rendering
    final mq = MediaQuery.of(context).copyWith(textScaleFactor: 1.0);

    return MediaQuery(
      data: mq,
      child: Container(
        margin: margin,
        padding: padding,
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.greyBorder, width: 1),
          boxShadow: [
            // very soft ambient like the mock
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 8,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            // Title
            Text(
              title,
              style: TextStyle(
                fontSize: primary(), // 18
                fontWeight: FontWeight.w600,
                color: AppColors.green,
                height: 1.2,
              ),
            ),
            const SizedBox(height: 18),

            // Product row
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _Thumb(image: image),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Name
                      Text(
                        itemName,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: secondary(), // 16
                          fontWeight: FontWeight.w700,
                          color: Colors.black87,
                          height: 1.2,
                        ),
                      ),
                      const SizedBox(height: 6),
                      // Price (green)
                      Text(
                        priceText,
                        style: TextStyle(
                          fontSize: tertiary(), // 14
                          fontWeight: FontWeight.w600,
                          color: AppColors.green,
                          height: 1.2,
                        ),
                      ),
                      const SizedBox(height: 6),
                      // Rental period line
                      Text(
                        '$rentalDays Days - Return Date $returnDateText',
                        style: TextStyle(
                          fontSize: tertiary(), // 14
                          color: Colors.black.withOpacity(0.65),
                          height: 1.2,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Summary rows
            _KVRow(
              label: 'Security Deposit (refundable):',
              value: securityDepositText,
            ),
            const SizedBox(height: 14),
            _KVRow(label: 'Subtotal', value: subtotalText),
            const SizedBox(height: 14),
            _KVRow(label: 'Shipping', value: shippingText),

            const SizedBox(height: 14),
            Container(height: 1, color: AppColors.greyBorder), // divider
            const SizedBox(height: 10),

            // Total row (green & larger)
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Total',
                    style: TextStyle(
                      fontSize: primary(), // 18
                      fontWeight: FontWeight.w600,
                      color: AppColors.green,
                    ),
                  ),
                ),
                Text(
                  totalText,
                  style: TextStyle(
                    fontSize: primary(), // 18
                    fontWeight: FontWeight.w600,
                    color: AppColors.green,
                  ),
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
  const _Thumb({required this.image});

  final ImageProvider image;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Container(
        width: 64,
        height: 64,
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.greyBorder, width: 1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Image(image: image, fit: BoxFit.cover),
      ),
    );
  }
}

class _KVRow extends StatelessWidget {
  const _KVRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final bool isGreen =
        value.toLowerCase() == 'free' || value.startsWith('INR');
    return Row(
      children: [
        Expanded(
          child: Text(
            label,
            style: TextStyle(
              fontSize: secondary(), // 16
              color: Colors.black.withOpacity(0.72),
              height: 1.2,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Text(
          value,
          style: TextStyle(
            fontSize: secondary(), // 16
            fontWeight: FontWeight.w600,
            color: isGreen ? AppColors.green : Colors.black87,
            height: 1.2,
          ),
        ),
      ],
    );
  }
}
