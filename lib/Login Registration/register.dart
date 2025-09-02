import 'package:flutter/material.dart';
import 'package:flutter_social_button/flutter_social_button.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:khetihar/Components/CustomButton.dart';
import 'package:khetihar/Components/InputFields.dart';
import 'package:khetihar/Theme/AppColors.dart';
import 'package:khetihar/Theme/FontSize.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});

  final _formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  final ValueNotifier<bool> acceptTerms = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned(
            top: 0,
            right: 0,
            child: Image.asset(
              "Assets/HomeScreens/rice.png",
              height: 260,
              fit: BoxFit.contain,
            ),
          ),

          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        height: 36,
                        width: 36,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: const Color.fromRGBO(232, 236, 244, 1),
                            width: 2,
                          ),
                        ),
                        child: IconButton(
                          padding: EdgeInsets.zero,
                          icon: const Icon(
                            Icons.arrow_back_ios,
                            color: AppColors.green,
                          ),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ),
                    ),

                    const SizedBox(height: 8),

                    Column(
                      children: [
                        Image.asset(
                          "Assets/HomeScreens/Logo.png",
                          height: 65,
                          width: 65,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "Create Your\nKhetihar Account",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: large(),
                            fontWeight: FontWeight.bold,
                            color: AppColors.green,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 10),

                    Text(
                      "Join Khetihar to make smarter farming\n"
                      "decisions with expert help, anytime.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: secondary(),
                        color: Colors.black87,
                      ),
                    ),

                    const SizedBox(height: 20),

                    CustomInputField(
                      labelText: "Enter your name",
                      controller: nameController,
                      allowedType: AllowedType.text,
                      validator:
                          (val) =>
                              (val == null || val.isEmpty)
                                  ? "Name required"
                                  : null,
                    ),

                    const SizedBox(height: 12),

                    CustomInputField(
                      labelText: "Enter your email/phone",
                      controller: emailController,
                      allowedType: AllowedType.email,
                      validator:
                          (val) =>
                              (val == null || val.isEmpty)
                                  ? "Email required"
                                  : null,
                    ),

                    const SizedBox(height: 12),

                    CustomInputField(
                      labelText: "Enter your password",
                      controller: passwordController,
                      obscureText: true,
                      allowedType: AllowedType.textNumeric,
                      validator:
                          (val) =>
                              (val == null || val.length < 6)
                                  ? "Min 6 characters"
                                  : null,
                    ),

                    const SizedBox(height: 12),

                    CustomInputField(
                      labelText: "Confirm password",
                      controller: confirmPasswordController,
                      obscureText: true,
                      allowedType: AllowedType.textNumeric,
                      validator:
                          (val) =>
                              val != passwordController.text
                                  ? "Passwords don’t match"
                                  : null,
                    ),

                    const SizedBox(height: 16),

                    ValueListenableBuilder(
                      valueListenable: acceptTerms,
                      builder: (context, value, _) {
                        return Row(
                          children: [
                            Checkbox(
                              value: value,
                              onChanged: (v) {
                                acceptTerms.value = v ?? false;
                              },
                              activeColor: AppColors.green,
                            ),
                            Expanded(
                              child: Text.rich(
                                TextSpan(
                                  text: "Terms of Use ",
                                  style: TextStyle(
                                    fontSize: tertiary(),
                                    color: Colors.black87,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: "and Privacy Policy",
                                      style: TextStyle(
                                        fontSize: tertiary(),
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.green,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),

                    const SizedBox(height: 20),

                    CustomButton(
                      text: "Register",
                      foregroundColor: Colors.white,
                      expand: true,
                      onPressed: () {
                        Get.toNamed('/otpVerification');
                      },
                    ),

                    const SizedBox(height: 25),

                    Row(
                      children: [
                        const Expanded(child: Divider(thickness: 1)),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Text(
                            "Or Register with",
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: tertiary(),
                            ),
                          ),
                        ),
                        const Expanded(child: Divider(thickness: 1)),
                      ],
                    ),

                    const SizedBox(height: 20),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      // crossAxisAlignment: CrossAxisAlignment.,
                      children: [
                        IconButton(
                          icon: FaIcon(
                            FontAwesomeIcons.facebook,
                            color: AppColors.green,
                          ),
                          onPressed: () {},
                        ),
                        IconButton(
                          icon: FaIcon(
                            FontAwesomeIcons.apple,
                            color: AppColors.green,
                          ),
                          onPressed: () {},
                        ),
                        IconButton(
                          icon: FaIcon(
                            FontAwesomeIcons.google,
                            color: AppColors.green,
                          ),
                          onPressed: () {},
                        ),
                      ],
                    ),

                    const SizedBox(height: 25),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already have an account? ",
                          style: TextStyle(fontSize: tertiary()),
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.toNamed('/login');
                          },
                          child: Text(
                            "Login Now",
                            style: TextStyle(
                              color: AppColors.green,
                              fontWeight: FontWeight.bold,
                              fontSize: tertiary(),
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
