import 'package:flutter/material.dart';
import 'package:khetihar/Components/CustomAppBar.dart';
import 'package:khetihar/Components/CustomButton.dart';
import 'package:khetihar/Components/InputFields.dart';
import 'package:khetihar/Theme/AppColors.dart';
import 'package:khetihar/Theme/FontSize.dart';

class ContactInformationScreen extends StatefulWidget {
  const ContactInformationScreen({super.key});

  @override
  State<ContactInformationScreen> createState() =>
      _ContactInformationScreenState();
}

class _ContactInformationScreenState extends State<ContactInformationScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController altPhoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: CustomAppBar(),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
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
                      // ✅ First two circles green
                      _buildStepCircle("Collection\nDetails", true),
                      _buildDashedLine(),
                      _buildStepCircle("Contact\nInformation", true),
                      _buildDashedLine(),
                      _buildStepCircle("Payment", false),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Section Title
                  Text(
                    "Contact Information",
                    style: TextStyle(
                      fontSize: primary(),
                      fontWeight: FontWeight.bold,
                      color: AppColors.green,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Full Name
                  labelText("Full Name"),
                  CustomInputField(
                    labelText: "Enter Your Name",
                    controller: nameController,
                    allowedType: AllowedType.text,
                  ),
                  const SizedBox(height: 16),

                  // Phone
                  labelText("Phone"),
                  CustomInputField(
                    labelText: "Enter the phone number",
                    controller: phoneController,
                    allowedType: AllowedType.phone,
                  ),
                  const SizedBox(height: 16),

                  // Alternate Phone
                  labelText("Alternate Phone Number"),
                  CustomInputField(
                    labelText: "Enter the phone number",
                    controller: altPhoneController,
                    allowedType: AllowedType.phone,
                  ),
                  const SizedBox(height: 16),

                  // Email
                  labelText("Email - Optional"),
                  CustomInputField(
                    labelText: "Enter Your Email",
                    controller: emailController,
                    allowedType: AllowedType.email,
                  ),
                  const SizedBox(height: 100), // spacing before bottom bar
                ],
              ),
            ),
          ),

          // Bottom Total Amount + Continue
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              border: Border.all(color: Colors.grey.shade300),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 4,
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
                    const SizedBox(height: 4),
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

                // Continue Button
                CustomButton(
                  text: "Continue",
                  onPressed: () {
                    // Handle continue → go to payment screen
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
    );
  }

  /// Stepper Circle Widget
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

  /// Dashed Line Widget
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
