import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khetihar/Components/CustomButton.dart';
import 'package:khetihar/Components/InputFields.dart';
import 'package:khetihar/Theme/AppColors.dart';
import 'package:khetihar/Theme/FontSize.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              children: [
                ClipPath(
                  clipper: TopCurveClipper(),
                  child: Image.asset(
                    "Assets/HomeScreens/farmer_login.png",
                    height: 350, // ensures farmer hand is fully visible
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 10,
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

            const SizedBox(height: 20),

            // --- Logo
            Image.asset("Assets/HomeScreens/Logo.png", height: 70),

            const SizedBox(height: 20),

            // --- Welcome Text + rice image
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Welcome back!",
                          style: TextStyle(
                            fontSize: primary(),
                            fontWeight: FontWeight.bold,
                            color: AppColors.green,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          "Login in to your account",
                          style: TextStyle(
                            fontSize: tertiary(),
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Image.asset("Assets/HomeScreens/rice.png", height: 60),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // --- Email/Phone
            CustomInputField(
              labelText: "Enter your email/phone",
              controller: emailController,
              allowedType:
                  AllowedType.email, // ✅ this will accept email style input
            ),
            const SizedBox(height: 15),

            // --- Password
            CustomInputField(
              labelText: "Enter your password",
              controller: passwordController,
              obscureText: true,
            ),

            // --- Forgot Password
            Padding(
              padding: const EdgeInsets.only(right: 20, top: 10),
              child: Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {},
                  child: const Text(
                    "Forgot Password?",
                    style: TextStyle(color: AppColors.green),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 10),

            // --- Login Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: CustomButton(
                text: "Login",
                expand: true,
                onPressed: () {
                  // handle login logic
                },
              ),
            ),

            const SizedBox(height: 20),

            // --- Divider with text
            Row(
              children: [
                const Expanded(child: Divider(thickness: 1)),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    "Or Login with",
                    style: TextStyle(fontSize: tertiary(), color: Colors.grey),
                  ),
                ),
                const Expanded(child: Divider(thickness: 1)),
              ],
            ),

            const SizedBox(height: 20),

            // --- Social Login
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _socialIcon("Assets/icons/facebook.png"),
                const SizedBox(width: 20),
                _socialIcon("Assets/icons/google.png"),
                const SizedBox(width: 20),
                _socialIcon("Assets/icons/apple.png"),
              ],
            ),

            const SizedBox(height: 30),

            // --- Register Now
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Don’t have an account? "),
                GestureDetector(
                  onTap: () {
                    // navigate to register
                  },
                  child: const Text(
                    "Register Now",
                    style: TextStyle(
                      color: AppColors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _socialIcon(String assetPath) {
    return CircleAvatar(
      radius: 22,
      backgroundColor: Colors.white,
      child: Image.asset(assetPath, height: 25, width: 25),
    );
  }
}

class TopCurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final w = size.width;
    final h = size.height;

    Path path = Path();
    path.lineTo(0, h - 60); // left side goes low (to show farmer hand fully)

    // curve upwards to the right
    path.quadraticBezierTo(
      w * 0.5,
      h, // dip in middle
      w,
      h - 180, // right side higher
    );

    path.lineTo(w, 0); // top-right corner
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
