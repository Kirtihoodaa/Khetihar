import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khetihar/Components/CustomButton.dart';
import 'package:khetihar/Components/InputFields.dart'
    show AllowedType, CustomInputField;
import 'package:khetihar/Theme/AppColors.dart';
import 'package:khetihar/Theme/FontSize.dart';

class ForgetPasswordScreen extends StatelessWidget {
  ForgetPasswordScreen({super.key});

  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  children: [
                    ClipPath(
                      clipper: TiltedCurveClipper(),
                      child: Image.asset(
                        "Assets/HomeScreens/farmer_login.png",
                        height: 350,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      top: 40,
                      left: 10,
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        child: IconButton(
                          icon: const Icon(
                            Icons.arrow_back,
                            color: AppColors.green,
                          ),
                          onPressed: () => Get.back(),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 10),

                Image.asset(
                  "Assets/HomeScreens/Logo.png",
                  height: 60,
                  width: 60,
                ),

                const SizedBox(height: 20),

                Text(
                  "Forget Password",
                  style: TextStyle(
                    color: AppColors.green,
                    fontSize: large(),
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 10),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Text(
                    "Don’t worry! It occurs. Please enter the email address linked with your account.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: secondary(),
                      color: Colors.black87,
                    ),
                  ),
                ),

                const SizedBox(height: 25),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: CustomInputField(
                    labelText: "Enter your email/phone",
                    controller: emailController,
                    allowedType: AllowedType.email,
                  ),
                ),

                const SizedBox(height: 25),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: CustomButton(
                    text: "Send Reset Link",
                    expand: true,
                    foregroundColor: Colors.white,
                    backgroundColor: AppColors.green,
                    onPressed: () {},
                  ),
                ),

                const SizedBox(height: 50),
              ],
            ),
          ),

          Positioned(
            top: 300,
            right: 0,
            child: Image.asset(
              "Assets/HomeScreens/rice.png",
              height: 240,
              fit: BoxFit.contain,
            ),
          ),
        ],
      ),
    );
  }
}

class TiltedCurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final w = size.width;
    final h = size.height;

    Path path = Path();
    path.lineTo(0, h - 60);

    path.quadraticBezierTo(w * 0.5, h, w, h - 150);

    path.lineTo(w, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
