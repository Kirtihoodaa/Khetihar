import 'package:flutter/material.dart';
import 'package:khetihar/Components/CustomButton.dart';
import 'package:khetihar/Components/InputFields.dart';
import 'package:khetihar/Theme/AppColors.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  bool acceptTerms = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Rice image background
          Positioned(
            top: 0,
            right: 0,
            child: Image.asset(
              "Assets/HomeScreens/rice.png",
              height: 200,
              fit: BoxFit.contain,
            ),
          ),

          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ), 
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 12,
                    ),
             
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

                    const SizedBox(height: 10),

              
                    Column(
                      children: [
                        Image.asset(
                          "Assets/HomeScreens/Logo.png",
                          height: 70,
                          width: 70,
                        ),
                        const SizedBox(height: 15),
                        const Text(
                          "Create Your\nKhetihar Account",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: AppColors.green,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

           
                    const Text(
                      "Join Khetihar to make smarter farming\ndecisions with expert help, anytime.",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.black87, fontSize: 14),
                    ),

                    const SizedBox(height: 25),

            
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

              
                    Row(
                      children: [
                        Checkbox(
                          value: acceptTerms,
                          onChanged: (v) {
                            setState(() => acceptTerms = v ?? false);
                          },
                          activeColor: AppColors.green,
                        ),
                        const Expanded(
                          child: Text.rich(
                            TextSpan(
                              text: "Terms of Us ",
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.black87,
                              ),
                              children: [
                                TextSpan(
                                  text: "and Privacy Policy",
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.green,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    CustomButton(
                      text: "Register",
                      expand: true,
                      onPressed: () {
                        if (_formKey.currentState!.validate() && acceptTerms) {
                          debugPrint("Register pressed ✅");
                        }
                      },
                    ),

                    const SizedBox(height: 25),

                    Row(
                      children: const [
                        Expanded(child: Divider(thickness: 1)),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          child: Text(
                            "Or Register with",
                            style: TextStyle(color: Colors.black54),
                          ),
                        ),
                        Expanded(child: Divider(thickness: 1)),
                      ],
                    ),

                    const SizedBox(height: 20),

                    // Social Buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset("Assets/Icons/facebook.png", height: 40),
                        const SizedBox(width: 20),
                        Image.asset("Assets/Icons/google.png", height: 40),
                        const SizedBox(width: 20),
                        Image.asset("Assets/Icons/apple.png", height: 40),
                      ],
                    ),

                    const SizedBox(height: 25),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Already have an account? ",
                          style: TextStyle(fontSize: 14),
                        ),
                        GestureDetector(
                          onTap: () {
                            debugPrint("Login clicked");
                          },
                          child: const Text(
                            "Login Now",
                            style: TextStyle(
                              color: AppColors.green,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
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
