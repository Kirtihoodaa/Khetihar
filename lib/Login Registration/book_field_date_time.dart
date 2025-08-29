import 'package:flutter/material.dart';
import 'package:khetihar/Components/InputFields.dart';
import 'package:khetihar/Login%20Registration/field_agent_schedule_picker.dart';

import '../Theme/AppColors.dart';
import '../Theme/FontSize.dart';

class BookFieldDateTime extends StatelessWidget {
  const BookFieldDateTime({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        child: Column(children: [ScheduleAddressWidget()]),
      ),
    );
  }
}

// Uses your AppColors and size helpers from the snippet you shared.

class ScheduleAddressWidget extends StatelessWidget {
  const ScheduleAddressWidget({super.key, this.onBack, this.controller});

  final VoidCallback? onBack;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Back button in a subtle circle
            _CircleBackButton(onPressed: onBack),

            const SizedBox(height: 16),

            // Top heading
            Text(
              'Choose a Date and Time',
              style: TextStyle(
                fontSize: primary(), // 18
                fontWeight: FontWeight.w600,
                color: AppColors.green,
                height: 1.25,
              ),
            ),

            const SizedBox(height: 12),
            AppTextField(hintText: "Enter Your Address", height: 100),
            const SizedBox(height: 26),
            // Second heading + helper text
            Text(
              'When should the field agent arrive?',
              style: TextStyle(
                fontSize: primary(), // 18
                fontWeight: FontWeight.w600,
                color: AppColors.green,
                height: 1.25,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              'The inspection will take approximately 2–3 hours',
              style: TextStyle(
                fontSize: tertiary(), // 14
                color: Colors.black.withOpacity(0.70),
                height: 1.35,
              ),
            ),
            const SizedBox(height: 26),
            FieldAgentSchedulePicker(),
          ],
        ),
      ),
    );
  }
}

class _CircleBackButton extends StatelessWidget {
  const _CircleBackButton({this.onPressed});

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(24),
      onTap: onPressed ?? () => Navigator.maybePop(context),
      child: Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: AppColors.green, width: 1.2),
        ),
        alignment: Alignment.center,
        child: const Icon(
          Icons.arrow_back_ios_new_rounded,
          size: 16,
          color: AppColors.green,
          weight: 30,
        ),
      ),
    );
  }
}
