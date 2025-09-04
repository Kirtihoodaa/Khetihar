import 'package:flutter/material.dart';
import 'package:khetihar/Components/CustomAppBar.dart';
import 'package:khetihar/Components/CustomButton.dart';
import 'package:khetihar/Components/InputFields.dart';
import 'package:khetihar/Theme/AppColors.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _currentPasswordController =
      TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool _isLoading = false;

  void _updatePassword() {
    if (_formKey.currentState?.validate() ?? false) {
      if (_newPasswordController.text != _confirmPasswordController.text) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("New Password and Confirm Password must match"),
          ),
        );
        return;
      }

      setState(() {
        _isLoading = true;
      });

      // Simulate API call
      Future.delayed(const Duration(seconds: 2), () {
        setState(() {
          _isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Password updated successfully!")),
        );
      });
    }
  }

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: KCenteredActionsAppBar(title: "Chnage Password"),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              labelText("Current Password"),
              CustomInputField(
                controller: _currentPasswordController,
                labelText: "Enter the password",
                obscureText: true,
                validator:
                    (val) =>
                        val == null || val.isEmpty
                            ? "Please enter current password"
                            : null,
              ),
              const SizedBox(height: 16),

              labelText("New Password"),
              CustomInputField(
                controller: _newPasswordController,
                labelText: "Enter the password",
                obscureText: true,
                validator:
                    (val) =>
                        val == null || val.isEmpty
                            ? "Please enter new password"
                            : null,
              ),
              const SizedBox(height: 16),

              labelText("Confirm Password"),
              CustomInputField(
                controller: _confirmPasswordController,
                labelText: "Enter the password",
                obscureText: true,
                validator:
                    (val) =>
                        val == null || val.isEmpty
                            ? "Please confirm password"
                            : null,
              ),
              const SizedBox(height: 32),

              CustomButton(
                text: "Update Password",
                expand: true,
                isLoading: _isLoading,
                onPressed: _isLoading ? null : _updatePassword,
                backgroundColor: AppColors.green,
                foregroundColor: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
