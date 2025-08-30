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
                  height: 65,
                  width: 65,
                ),

                const SizedBox(height: 20),

           
                Column(
                  children: [
                    Text(
                      "Welcome back!",
                      style: TextStyle(
                        fontSize: large(),
                        fontWeight: FontWeight.bold,
                        color: AppColors.green,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      "Login to your account",
                      style: TextStyle(
                        fontSize: tertiary(),
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 25),

            
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: CustomInputField(
                    labelText: "Enter your email/phone",
                    controller: emailController,
                    allowedType: AllowedType.email,
                  ),
                ),

                const SizedBox(height: 15),

         
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: CustomInputField(
                    labelText: "Enter your password",
                    controller: passwordController,
                    obscureText: true,
                  ),
                ),

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


                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: CustomButton(
                    text: "Login",
                    expand: true,
                    onPressed: () {
                      debugPrint("Login pressed ✅");
                    },
                  ),
                ),

                const SizedBox(height: 20),

         
                Row(
                  children: [
                    const Expanded(child: Divider(thickness: 1)),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        "Or Login with",
                        style: TextStyle(
                          fontSize: tertiary(),
                          color: Colors.black,
                        ),
                      ),
                    ),
                    const Expanded(child: Divider(thickness: 1)),
                  ],
                ),

                const SizedBox(height: 20),

 
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _socialIcon("Assets/Icons/facebook.png"),
                    const SizedBox(width: 20),
                    _socialIcon("Assets/Icons/google.png"),
                    const SizedBox(width: 20),
                    _socialIcon("Assets/Icons/apple.png"),
                  ],
                ),

                const SizedBox(height: 30),

           
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don’t have an account? "),
                    GestureDetector(
                      onTap: () {
                        debugPrint("Register clicked ✅");
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

  Widget _socialIcon(String assetPath) {
    return CircleAvatar(
      radius: 22,
      backgroundColor: Colors.white,
      child: Image.asset(assetPath, height: 25, width: 25),
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

    // curve from bottom-left → dip → up to right
    path.quadraticBezierTo(w * 0.5, h, w, h - 150);

    path.lineTo(w, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
