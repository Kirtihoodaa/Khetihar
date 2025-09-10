import 'package:flutter/material.dart';
import 'package:khetihar/Components/CustomButton.dart';
import '../../Theme/AppColors.dart';
import '../../Theme/FontSize.dart';

/// ----------  Title: "Set Price Alerts" ----------
class SetPriceAlertsTitle extends StatelessWidget {
  const SetPriceAlertsTitle({super.key, this.text = 'Set Price Alerts'});

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

/// ----------  Mint Panel Shell (light green card) ----------
class AlertsMintPanel extends StatelessWidget {
  const AlertsMintPanel({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      // matches mock
      decoration: BoxDecoration(
        color: Colors.blue.withOpacity(0.05), // slightly brighter mint
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.greyBorder, width: 1),
      ),
      child: child,
    );
  }
}

/// ----------  One alert row (white card + text + pills) ----------
class AlertItemCard extends StatelessWidget {
  const AlertItemCard({
    super.key,
    required this.text,
    this.onEdit,
    this.onDelete,
  });

  final String text;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12), // inner padding like mock
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.greyBorder, width: 1),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            text,
            style: TextStyle(
              fontSize: secondary(), // 14
              color: Colors.black.withOpacity(0.90),
              height: 1.35, // same text leading feel
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              CustomButton(
                fontSize: 14,
                padding: EdgeInsets.symmetric(),
                width: 100,
                height: 36,
                text: "Edit",
                onPressed: () {},
                foregroundColor: Colors.white,
              ),
              SizedBox(width: 20),
              CustomButton(
                fontSize: 14,
                padding: EdgeInsets.symmetric(),
                width: 100,
                height: 36,
                text: "Delete",
                onPressed: () {},
                foregroundColor: Colors.white,
                backgroundColor: AppColors.brown,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// ----------  Bottom full-width CTA ----------
class AddNewAlertButton extends StatelessWidget {
  const AddNewAlertButton({super.key, required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 44, // matches pill height in mock
      child: CustomButton(
        text: "Add new Alert",
        onPressed: onPressed,
        foregroundColor: Colors.white,
      ),
    );
  }
}
