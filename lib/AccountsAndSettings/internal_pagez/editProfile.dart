import 'package:flutter/material.dart';
import 'package:khetihar/Components/CustomAppBar.dart';
import 'package:khetihar/Components/InputFields.dart';
import 'package:khetihar/Components/CustomButton.dart';
import 'package:khetihar/Theme/AppColors.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final nameController = TextEditingController();
  final genderController = TextEditingController();
  final phoneController = TextEditingController();

  String selectedGender = "Male";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: KCenteredActionsAppBar(title: "Edit Profile"),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            /// Profile Image
            Center(
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  CircleAvatar(
                    radius: 55,
                    backgroundImage: const AssetImage("assets/profile.jpg"),
                  ),
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.green,
                    ),
                    child: const Icon(
                      Icons.edit,
                      color: Colors.white,
                      size: 18,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "Rajesh Kumar",
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
            ),
            const SizedBox(height: 24),

            /// Name
            labelText("Name"),
            CustomInputField(
              controller: nameController,
              labelText: "Enter your name",
            ),
            const SizedBox(height: 16),

            /// Gender Input (optional field)
            labelText("Password"),
            CustomInputField(
              controller: genderController,
              labelText: "Enter the password",
            ),
            const SizedBox(height: 16),

            /// Gender Selection (Styled like InputField)
            labelText("Gender"),
            Row(
              children: [
                Expanded(
                  child: CustomGenderField(
                    label: "Male",
                    icon: Icons.male,
                    iconColor: Colors.blue,
                    isSelected: selectedGender == "Male",
                    onTap: () => setState(() => selectedGender = "Male"),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: CustomGenderField(
                    label: "Female",
                    icon: Icons.female,
                    iconColor: Colors.pink,
                    isSelected: selectedGender == "Female",
                    onTap: () => setState(() => selectedGender = "Female"),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            /// Phone Number
            labelText("Phone Number"),
            CustomInputField(
              controller: phoneController,
              labelText: "Enter phone number",
              allowedType: AllowedType.phone,
            ),
            const SizedBox(height: 24),

            /// Save Button
            CustomButton(
              text: "Save Changes",
              foregroundColor: Colors.white,
              variant: ButtonVariant.filled,
              onPressed: () {},
              expand: true,
            ),
          ],
        ),
      ),
    );
  }
}

/// ✅ CustomGenderField styled like CustomInputField
class CustomGenderField extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color iconColor;
  final bool isSelected;
  final VoidCallback onTap;

  const CustomGenderField({
    super.key,
    required this.label,
    required this.icon,
    required this.iconColor,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected ? AppColors.green : Colors.grey.shade300,
            width: 1.5,
          ),
          color: AppColors.grey,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: iconColor),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: isSelected ? AppColors.green : Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
