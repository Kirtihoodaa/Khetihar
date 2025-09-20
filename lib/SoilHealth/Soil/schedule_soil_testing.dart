import 'package:flutter/material.dart';
import 'package:khetihar/Components/CustomAppBar.dart';
import 'package:khetihar/Components/InputFields.dart';
import 'package:khetihar/Components/calendar.dart';
import 'package:khetihar/Theme/AppColors.dart';
import 'package:khetihar/Theme/FontSize.dart';
import 'package:khetihar/Components/CustomButton.dart'; // ✅ import your custom button

class ScheduleSoilTestingScreen extends StatefulWidget {
  const ScheduleSoilTestingScreen({super.key});

  @override
  State<ScheduleSoilTestingScreen> createState() =>
      _ScheduleSoilTestingScreenState();
}

class _ScheduleSoilTestingScreenState extends State<ScheduleSoilTestingScreen> {
  final TextEditingController addressController = TextEditingController();
  DateTime? selectedDate;
  String? selectedTimeSlot;

  final List<Map<String, dynamic>> timeSlots = [
    {"label": "8:00 - 10:00 AM", "enabled": true},
    {"label": "10:00 - 12:00 PM", "enabled": true},
    {"label": "12:00 - 2:00 PM", "enabled": true},
    {"label": "2:00 - 4:00 PM", "enabled": true},
    {"label": "4:00 - 6:00 PM", "enabled": false}, // disabled slot
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: CustomAppBar(),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            Text(
              "Schedule Soil Testing",
              style: TextStyle(
                fontSize: primary(),
                fontWeight: FontWeight.bold,
                color: AppColors.green,
              ),
            ),
            const SizedBox(height: 16),

            // Stepper Progress
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildStepCircle("Collection\nDetails", true),
                _buildDashedLine(),
                _buildStepCircle("Contact\nInformation", false),
                _buildDashedLine(),
                _buildStepCircle("Payment", false),
              ],
            ),
            const SizedBox(height: 24),

            Text(
              "Collection Details",
              style: TextStyle(
                fontSize: primary(),
                fontWeight: FontWeight.bold,
                color: AppColors.green,
              ),
            ),
            const SizedBox(height: 12),

            // Address Label
            Text(
              "Address",
              style: TextStyle(
                fontSize: secondary(),
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),

            // Address Input
            CustomInputField(
              labelText: "Enter your address",
              controller: addressController,
              allowedType: AllowedType.text,
              maxLines: 3,
            ),

            const SizedBox(height: 24),

            const Text(
              "Collection Date & Time",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            // Calendar widget
            CustomCalendar(
              onDateSelected: (date) {
                setState(() {
                  selectedDate = date;
                });
              },
            ),

            const SizedBox(height: 24),

            // Time Slot Selection
            const Text(
              "Select Time Slot",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            Wrap(
              spacing: 12,
              runSpacing: 12,
              children:
                  timeSlots.map((slot) {
                    final isSelected = selectedTimeSlot == slot["label"];
                    final isEnabled = slot["enabled"] as bool;

                    return GestureDetector(
                      onTap:
                          isEnabled
                              ? () {
                                setState(() {
                                  selectedTimeSlot = slot["label"];
                                });
                              }
                              : null,
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width / 3 - 20,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 22,
                            horizontal: 8,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color:
                                  isSelected
                                      ? AppColors.green
                                      : Colors.grey.shade400,
                              width: isSelected ? 2 : 1,
                            ),
                            color:
                                isEnabled
                                    ? (isSelected
                                        ? Colors.green.withOpacity(0.15)
                                        : Colors.white)
                                    : Colors.grey.shade200,
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            slot["label"],
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: medium(),
                              color:
                                  isEnabled
                                      ? (isSelected
                                          ? AppColors.green
                                          : Colors.black)
                                      : Colors.grey,
                              fontWeight:
                                  isSelected
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
            ),

            const SizedBox(height: 40),

            // ✅ Total Amount + Continue (CustomButton used)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 5,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Amount
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Total Amount",
                        style: TextStyle(
                          fontSize: secondary(),
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        "INR 500",
                        style: TextStyle(
                          fontSize: primary(),
                          fontWeight: FontWeight.bold,
                          color: AppColors.green,
                        ),
                      ),
                    ],
                  ),

                  CustomButton(
                    text: "Continue",
                    onPressed: () {
                      // handle continue
                    },
                    expand: false,
                    variant: ButtonVariant.filled,
                    backgroundColor: AppColors.green,
                    foregroundColor: Colors.white,
                    radius: 20,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
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

  Widget _buildStepCircle(String text, bool isActive) {
    return Column(
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isActive ? AppColors.green : Colors.grey.shade200,
          ),
          alignment: Alignment.center,
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: small(),
              fontWeight: FontWeight.w600,
              color: isActive ? Colors.white : Colors.black,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDashedLine() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      child: Row(
        children: List.generate(
          6,
          (index) => Container(
            margin: const EdgeInsets.symmetric(horizontal: 2),
            width: 6,
            height: 2,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
}
