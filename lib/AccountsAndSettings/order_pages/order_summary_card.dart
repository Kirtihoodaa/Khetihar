import 'package:flutter/material.dart';
import '../../Theme/AppColors.dart';
import '../../Theme/FontSize.dart';

class OrderSummaryCard extends StatelessWidget {
  const OrderSummaryCard({
    super.key,
    this.title = 'Order Summary',
    required this.items,
    required this.subtotalText, // e.g. 'INR 500'
    required this.shippingText, // e.g. 'Free'
    required this.totalText, // e.g. 'INR 500'
    this.margin = const EdgeInsets.all(12),
    this.padding = const EdgeInsets.fromLTRB(16, 14, 16, 12),
  });

  final String title;
  final List<OrderSummaryItem> items;
  final String subtotalText;
  final String shippingText;
  final String totalText;
  final EdgeInsets margin;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.greyBorder, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          Text(
            title,
            style: TextStyle(
              fontSize: primary(), // 18
              fontWeight: FontWeight.w700, // bold like mock
              color: Colors.black87,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 14),

          // Items
          ..._buildItems(),

          const SizedBox(height: 16),

          // Subtotal
          _KVRow(
            label: 'Subtotal',
            value: subtotalText,
            labelStyle: TextStyle(
              fontSize: secondary(), // 16
              color: Colors.black.withOpacity(0.7),
            ),
            valueStyle: TextStyle(
              fontSize: secondary(),
              color: AppColors.green,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 10),

          // Shipping
          _KVRow(
            label: 'Shipping',
            value: shippingText,
            labelStyle: TextStyle(
              fontSize: secondary(),
              color: Colors.black.withOpacity(0.7),
            ),
            valueStyle: TextStyle(
              fontSize: secondary(),
              color: AppColors.green,
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: 12),

          // Divider like the screenshot’s bottom rule
          Container(height: 1, color: AppColors.greyBorder),

          const SizedBox(height: 10),

          // Total (green on both sides)
          _KVRow(
            label: 'Total',
            value: totalText,
            labelStyle: TextStyle(
              fontSize: primary(), // 18
              fontWeight: FontWeight.w600,
              color: AppColors.green,
            ),
            valueStyle: TextStyle(
              fontSize: primary(),
              fontWeight: FontWeight.w600,
              color: AppColors.green,
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildItems() {
    return [
      for (int i = 0; i < items.length; i++) ...[
        _ItemRow(item: items[i]),
        if (i != items.length - 1) const SizedBox(height: 16),
      ],
    ];
  }
}

class OrderSummaryItem {
  const OrderSummaryItem({
    required this.name,
    required this.priceText, // e.g. 'INR 146'
    required this.qty, // e.g. 2
    required this.image, // ImageProvider
  });

  final String name;
  final String priceText;
  final int qty;
  final ImageProvider image;
}

class _ItemRow extends StatelessWidget {
  const _ItemRow({required this.item});

  final OrderSummaryItem item;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _Thumb(image: item.image),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Name
              Text(
                item.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: secondary(), // 16
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                  height: 1.2,
                ),
              ),
              const SizedBox(height: 6),
              // Price (green)
              Text(
                item.priceText,
                style: TextStyle(
                  fontSize: tertiary(), // 14
                  fontWeight: FontWeight.w600,
                  color: AppColors.green,
                  height: 1.2,
                ),
              ),
              const SizedBox(height: 6),
              // Qty
              Text(
                'Qty: ${item.qty}',
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
    );
  }
}

class _Thumb extends StatelessWidget {
  const _Thumb({required this.image});

  final ImageProvider image;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: 72,
        height: 72,
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.greyBorder, width: 1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Image(image: image, fit: BoxFit.cover),
      ),
    );
  }
}

class _KVRow extends StatelessWidget {
  const _KVRow({
    required this.label,
    required this.value,
    required this.labelStyle,
    required this.valueStyle,
  });

  final String label;
  final String value;
  final TextStyle labelStyle;
  final TextStyle valueStyle;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Text(label, style: labelStyle)),
        const SizedBox(width: 12),
        Text(value, style: valueStyle),
      ],
    );
  }
}
