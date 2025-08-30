import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khetihar/Components/CustomButton.dart';
import 'package:khetihar/Components/InputFields.dart'
    show AllowedType, CustomInputField;
import 'package:khetihar/Theme/AppColors.dart';

import 'package:khetihar/Theme/Snackbar.dart';

class CompleteProfileScreen extends StatelessWidget {
  CompleteProfileScreen({super.key});

  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController landController = TextEditingController();
  final TextEditingController cropsController = TextEditingController();
  final TextEditingController yieldController = TextEditingController();
  final TextEditingController profitController = TextEditingController();

  final RxString gender = "".obs;

  final FocusNode dropdownFocusNode = FocusNode();

  // Size functions
  double large() => 26; // For large heading
  double primary() => 18; // Main headings
  double secondary() => 16; // Paragraph heading
  double tertiary() => 14; // Paragraph body
  double small() => 10; // Small text

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  height: 250, // Background image height
                  width: double.infinity,
                  child: Image.asset(
                    "Assets/HomeScreens/profile_background.png",
                    fit: BoxFit.cover,
                  ),
                ),

                Positioned(
                  top: 10,
                  left: 10,
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.white, // White background
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppColors.green,
                        width: 2,
                      ), // Green border
                    ),
                    child: IconButton(
                      icon: const Icon(
                        Icons.arrow_back,
                        color: AppColors.green,
                      ),
                      onPressed: () => Get.back(),
                    ),
                  ),
                ),

                Positioned(
                  top: 100, // Centering the text vertically
                  left:
                      MediaQuery.of(context).size.width / 2 -
                      120, // Center horizontally
                  child: Text(
                    "Complete Your Profile",
                    style: TextStyle(
                      fontSize: large(),
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),

                Positioned(
                  bottom: -45,
                  left: MediaQuery.of(context).size.width / 2 - 45,
                  child: Container(
                    width: 90, // Width of the circle
                    height: 90, // Height of the circle
                    decoration: BoxDecoration(
                      color: Colors.white, // White inside the circle
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.green, width: 4),
                    ),
                    child: const CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.person,
                        size: 50,
                        color: AppColors.green,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 60), // space for avatar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  CustomInputField(
                    labelText: "Enter your full name",
                    controller: nameController,
                    allowedType: AllowedType.text,
                  ),
                  const SizedBox(height: 14),

                  CustomInputField(
                    labelText: "Enter your phone number",
                    controller: phoneController,
                    allowedType: AllowedType.phone,
                    maxLength: 10,
                  ),
                  const SizedBox(height: 14),

                  Obx(
                    () => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color:
                                dropdownFocusNode.hasFocus
                                    ? AppColors.green
                                    : AppColors.greyBorder,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(10),
                          color: AppColors.grey,
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            focusNode: dropdownFocusNode,
                            value: gender.value.isEmpty ? null : gender.value,
                            hint: const Text("Select your gender"),
                            isExpanded: true,
                            items:
                                ["Male", "Female", "Other"]
                                    .map(
                                      (g) => DropdownMenuItem(
                                        value: g,
                                        child: Text(g),
                                      ),
                                    )
                                    .toList(),
                            onChanged: (val) => gender.value = val ?? "",
                            dropdownColor: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 14),

                  CustomInputField(
                    labelText: "DD/MM/YYYY",
                    controller: dobController,
                    isDatePicker: true,
                  ),
                  const SizedBox(height: 14),

                  CustomInputField(
                    labelText: "Enter your location",
                    controller: locationController,
                    allowedType: AllowedType.text,
                  ),
                  const SizedBox(height: 14),

                  CustomInputField(
                    labelText: "Enter area in acres",
                    controller: landController,
                    allowedType: AllowedType.numeric,
                  ),
                  const SizedBox(height: 14),

                  CustomInputField(
                    labelText: "E.g., Wheat, Rice, Cotton",
                    controller: cropsController,
                    allowedType: AllowedType.textNumeric,
                  ),
                  const SizedBox(height: 14),

                  CustomInputField(
                    labelText: "Enter yield in tons",
                    controller: yieldController,
                    allowedType: AllowedType.numeric,
                  ),
                  const SizedBox(height: 14),

                  CustomInputField(
                    labelText: "Enter amount in INR",
                    controller: profitController,
                    allowedType: AllowedType.numeric,
                  ),

                  const SizedBox(height: 28),

                  // Button
                  CustomButton(
                    text: "Book Your Field Agent",
                    expand: true,
                    onPressed: () {
                      SnackbarService.showSnack(
                        title: 'Success',
                        message: 'Profile Completed!',
                        type: SnackType.success,
                      );
                    },
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
