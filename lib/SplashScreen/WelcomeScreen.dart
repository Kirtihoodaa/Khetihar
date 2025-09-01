import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:khetihar/Components/CustomButton.dart';
import 'package:khetihar/Theme/AppColors.dart';
import 'package:khetihar/Theme/FontSize.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Image with curved bottom
          ClipPath(
            clipper: BottomDoubleWaveClipper(),
            child: Image.asset(
              'Assets/HomeScreens/Welcome.png',
              fit: BoxFit.cover,
              height: MediaQuery.of(context).size.height * 0.55,
              width: double.infinity,
            ),
          ),

          // Bottom Section
          Expanded(
            flex: 4,
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 22, vertical: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // Logo
                  CircleAvatar(
                    radius: 36,
                    backgroundColor: Colors.white,
                    backgroundImage: AssetImage('Assets/HomeScreens/Logo.png'),
                  ),
                  const SizedBox(height: 20),

                  // Title
                  Text(
                    "Welcome to Khetihar",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.green,
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Subtitle
                  Text(
                    "Your smart farming partner — get crop advice, weather updates, and government schemes in your language.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: secondary(),
                      fontWeight: FontWeight.w400,
                      color: Colors.black87,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 22),

                  // Login Button
                  CustomButton(
                    text: "Login",
                    onPressed: () {
                      Get.offAllNamed('/login');
                    },
                    backgroundColor: AppColors.green,
                    foregroundColor: Colors.white,
                    width: double.infinity,
                    height: 50,
                  ),
                  SizedBox(height: 14),

                  // Register Button
                  CustomButton(
                    text: "Register",
                    onPressed: () {
                      Get.offAllNamed('/register');
                    },
                    backgroundColor: AppColors.brown,
                    foregroundColor: Colors.white,
                    width: double.infinity,
                    height: 50,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BottomDoubleWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final w = size.width;
    final h = size.height;

    final Path path = Path();
    path.lineTo(0, h - 20);

    path.cubicTo(
      w * 0.10,
      h - 60, // control 1 (lift)
      w * 0.20,
      h - 100, // control 2 (peak up)
      w * 0.35,
      h - 50, // end of first small "u"
    );

    // Deeper "U" on the right
    path.cubicTo(
      w * 0.55,
      h, // control 1 (dip down)
      w * 0.75,
      h - 200, // control 2 (deep peak up)
      w,
      h * 0.70, // end on right side
    );

    path.lineTo(w, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
