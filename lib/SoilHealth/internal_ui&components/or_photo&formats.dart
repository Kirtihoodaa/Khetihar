import 'package:flutter/material.dart';

import '../../Theme/AppColors.dart';
import '../../Theme/FontSize.dart';

/// === tuned neutrals to hit the screenshot precisely ===
const _ruleColor = Color(0x335C7814); // thin greenish divider (20% alpha)
const _orColor = Color(0xFF6B7280); // "OR" muted gray
const _textStrong = Color(0xFF111827);
const _textMuted = Color(0xFF6B7280);

class OrPhotoAndFormats extends StatelessWidget {
  final VoidCallback? onTakePhoto;

  const OrPhotoAndFormats({super.key, this.onTakePhoto});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 323, // exact screenshot width
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // —— OR separator (exact: thin line, muted OR, tight margins) ——
          Padding(
            padding: const EdgeInsets.only(top: 6, bottom: 8),
            child: Row(
              children: [
                Expanded(child: _thinRule()),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    'OR',
                    style: TextStyle(
                      color: _orColor,
                      fontSize: secondary(),
                      // 12
                      fontWeight: FontWeight.w600,
                      height: 1.0,
                      letterSpacing: 0.2,
                    ),
                  ),
                ),
                Expanded(child: _thinRule()),
              ],
            ),
          ),
          SizedBox(height: 8),
          // —— Pill button (outline green, stadium, camera-in-circle) ——
          SizedBox(
            width: double.infinity,
            height: 58, // exact visual height
            child: OutlinedButton(
              onPressed: onTakePhoto,
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: AppColors.green, width: 1.0),
                shape: const StadiumBorder(),
                backgroundColor: Colors.white,
                foregroundColor: AppColors.green,
                elevation: 0,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                textStyle: TextStyle(
                  fontSize: tertiary(), // 14
                  fontWeight: FontWeight.w600,
                  height: 1.0,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // outlined circular camera badge
                  Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.green, width: 1.2),
                    ),
                    alignment: Alignment.center,
                    child: const Icon(
                      Icons.photo_camera_outlined,
                      size: 16,
                      color: AppColors.green,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    'Take a Photo of Report',
                    style: TextStyle(
                      color: AppColors.green,
                      fontSize: tertiary(),
                      fontWeight: FontWeight.w600,
                      height: 1.0,
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 16),

          // —— Supported Formats card (bg, border, spacing exact) ——
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.grey,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.greyBorder, width: 1),
            ),
            padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Supported Formats:',
                  style: TextStyle(
                    color: _textStrong,
                    fontSize: secondary(), // 14
                    fontWeight: FontWeight.w600,
                    height: 1.1,
                  ),
                ),
                const SizedBox(height: 10),

                // three formats spaced evenly like screenshot
                Wrap(
                  spacing: 30,
                  runSpacing: 10,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: const [
                    _FormatRow(icon: Icons.description_outlined, label: 'PDF'),
                    _FormatRow(icon: Icons.image_outlined, label: 'JPG'),
                    _FormatRow(icon: Icons.image_outlined, label: 'PNG'),
                  ],
                ),

                const SizedBox(height: 10),
                Text(
                  'Maximum file size: 10MB',
                  style: TextStyle(
                    color: _textMuted,
                    fontSize: tertiary(), // 12
                    fontWeight: FontWeight.w400,
                    height: 1.1,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _thinRule() => Container(height: 1, color: _ruleColor);
}

class _FormatRow extends StatelessWidget {
  final IconData icon;
  final String label;

  const _FormatRow({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 28, color: _textStrong),
        const SizedBox(width: 8),
        Text(
          label,
          style: TextStyle(
            color: _textStrong,
            fontSize: tertiary(), // 14
            fontWeight: FontWeight.w600,
            height: 1.0,
          ),
        ),
      ],
    );
  }
}
