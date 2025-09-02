import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khetihar/Components/CustomButton.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:khetihar/Theme/AppColors.dart';
import 'package:khetihar/Theme/FontSize.dart';

class OtpVerificationScreen extends StatelessWidget {
  OtpVerificationScreen({super.key});

  final TextEditingController otpController = TextEditingController();

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
                  "OTP Verification",
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
                    "Enter the verification code",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: secondary(),
                      color: Colors.black87,
                    ),
                  ),
                ),

                const SizedBox(height: 25),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: PinCodeTextField(
                    appContext: context,
                    length: 4,
                    controller: otpController,
                    keyboardType: TextInputType.number,
                    autoDismissKeyboard: true,
                    animationType: AnimationType.scale,
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(8),
                      fieldHeight: 55,
                      fieldWidth: 55,
                      inactiveColor: Colors.grey.shade400,
                      activeColor: AppColors.green,
                      selectedColor: AppColors.green,
                      activeFillColor: Colors.white,
                      inactiveFillColor: Colors.white,
                      selectedFillColor: Colors.white,
                    ),
                    enableActiveFill: true,
                    cursorColor: AppColors.green,
                    onChanged: (value) {
                      debugPrint("OTP Changed: $value");
                    },
                  ),
                ),

                const SizedBox(height: 25),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: CustomButton(
                    text: "Verify",
                    foregroundColor: Colors.white,
                    expand: true,
                    height: 50,
                    radius: 30,
                    backgroundColor: AppColors.green,
                    onPressed: () {
                      Get.toNamed('/BookFieldScreen');
                    },
                  ),
                ),

                const SizedBox(height: 15),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Didn’t receive code? ",
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: tertiary(),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        debugPrint("Resend OTP tapped");
                      },
                      child: Text(
                        "Resend",
                        style: TextStyle(
                          color: AppColors.green,
                          fontSize: tertiary(),
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
