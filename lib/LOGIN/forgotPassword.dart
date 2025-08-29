import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khetihar/Components/CustomButton.dart';
import 'package:khetihar/Components/InputFields.dart'
    show AllowedType, CustomInputField;
import 'package:khetihar/Theme/AppColors.dart';

class ForgetPasswordScreen extends StatelessWidget {
  ForgetPasswordScreen({super.key});

  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                ClipPath(
                  clipper: TopCurveClipper(),
                  child: Image.asset(
                    "Assets/HomeScreens/farmer_login.png",
                    height: 350,
                    width: double.infinity,
                    fit: BoxFit.fitWidth,
                  ),
                ),
                Positioned(
                  top: 40,
                  left: 10,
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.black),
                      onPressed: () => Get.back(),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),

            Image.asset("Assets/HomeScreens/Logo.png", height: 60, width: 60),

            const SizedBox(height: 20),

            Text(
              "Forget Password",
              style: TextStyle(
                color: AppColors.green,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                "Don’t worry! It occurs. Please enter the email address linked with your account.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: Colors.black87),
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

            // ---------- BUTTON ----------
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: CustomButton(
                text: "Send Reset Link",
                expand: true,
                onPressed: () {
                  // TODO: reset password API
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------- CURVED CLIPPER ----------
class TopCurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final w = size.width;
    final h = size.height;

    Path path = Path();

    // Start from top-left
    path.lineTo(0, h - 100);

    // First smooth curve (center dip)
    path.quadraticBezierTo(
      w * 0.4,
      h, // control point
      w * 0.75,
      h - 120, // mid end point
    );

    // Second curve (lift at right corner then slope down)
    path.quadraticBezierTo(
      w * 0.95,
      h - 200, // control point (up at corner)
      w,
      h - 90, // end point (down again near right edge)
    );

    // Finish the shape
    path.lineTo(w, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
