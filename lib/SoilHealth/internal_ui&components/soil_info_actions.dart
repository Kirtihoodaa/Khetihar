import 'package:flutter/material.dart';
import 'package:khetihar/Components/CustomButton.dart';

import '../../Theme/AppColors.dart';
import '../../Theme/FontSize.dart';

// Uses your provided colors & font-size helpers:
// AppColors.green/brown/grey/greyBorder, tertiary(), medium(), secondary()

class SoilInfoAndActionsPerfect extends StatelessWidget {
  final VoidCallback? onCancel;
  final VoidCallback? onUpload;

  const SoilInfoAndActionsPerfect({super.key, this.onCancel, this.onUpload});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 326, // exact screenshot width
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Card
          Container(
            decoration: BoxDecoration(
              color: AppColors.grey,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.greyBorder, width: 1),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x14000000),
                  blurRadius: 8,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title row
                Row(
                  children: [
                    const Icon(
                      Icons.help_outline,
                      // circled question — matches screenshot
                      size: 18,
                      color: Color(0xFFE37D3A),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'What’s a soil test report?',
                        style: TextStyle(
                          fontSize: secondary(), // 16
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF111827),
                          height: 1.1,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                // Divider
                Container(height: 1, color: const Color(0xFFE5E7EB)),
                const SizedBox(height: 10),
                // Body
                Text(
                  'A soil test report provides detailed information '
                  'about your soil’s nutrient levels, pH, and '
                  'composition. This helps determine what '
                  'amendments your soil needs for optimal crop '
                  'growth.',
                  style: TextStyle(
                    fontSize: tertiary(), // 14
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF6B7280),
                    height: 1.45,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 22),

          // Actions (pill buttons)
          Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 45, // matches visual height
                  child: CustomButton(
                    text: "Cancel",
                    onPressed: onCancel,
                    foregroundColor: Colors.white,
                    backgroundColor: AppColors.brown,
                    fontSize: 13,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: SizedBox(
                  height: 45,
                  child: CustomButton(
                    text: "Upload",
                    onPressed: onUpload,
                    foregroundColor: Colors.white,
                    backgroundColor: AppColors.green,
                    fontSize: 13,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
