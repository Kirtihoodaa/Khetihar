import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khetihar/Theme/AppColors.dart';

enum SnackType { success, error, warning }

class SnackbarService {
  static void showSnack({
    required String message,
    required String title,
    required SnackType type,
    SnackPosition position = SnackPosition.TOP,
    SnackStyle style = SnackStyle.FLOATING,
    Duration duration = const Duration(seconds: 3),
  }) {
    final title =
        {
          SnackType.success: 'Success',
          SnackType.error: 'Error',
          SnackType.warning: 'Warning',
        }[type]!;

    final backgroundColor =
        {
          SnackType.success: AppColors.green.withOpacity(0.5),
          SnackType.error: AppColors.red.withOpacity(0.5),
          SnackType.warning: AppColors.yellow.withOpacity(0.5),
        }[type]!;

    final iconData =
        {
          SnackType.success: Icons.check_circle_outline,
          SnackType.error: Icons.error_outline,
          SnackType.warning: Icons.warning_amber_outlined,
        }[type]!;

    Get.snackbar(
      title,
      message,
      snackPosition: position,
      snackStyle: style,
      isDismissible: true,
      backgroundColor: backgroundColor,
      colorText: Colors.white,
      icon: Icon(iconData, color: Colors.white),
      borderRadius: 10,
      margin: const EdgeInsets.all(12),
      duration: duration,
    );
  }
}
