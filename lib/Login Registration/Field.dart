import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:khetihar/Components/CustomButton.dart';
import 'package:khetihar/Theme/AppColors.dart';
import 'package:khetihar/Theme/FontSize.dart';

class FieldInspectionIntro extends StatelessWidget {
  const FieldInspectionIntro({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background image (full bleed)
          Image.asset('Assets/HomeScreens/Field.png', fit: BoxFit.cover),

          // Foreground card
          Align(
            alignment: const Alignment(0, 0.35),
            child: _FrostedCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 64,
                    height: 64,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.green,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.20),
                          blurRadius: 16,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: ClipOval(
                      child: Image.asset(
                        'Assets/HomeScreens/Logo.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Main copy
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 18),
                    child: Text(
                      'Book a field inspection with us to '
                      'unlock your premium membership and '
                      'become eligible for hidden seeds',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: primary(),
                        height: 1.35,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 18),
                    child: Text(
                      'We will send our agricultural expert to '
                      'your field and they will inspect it',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: secondary(),
                        height: 1.4,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                  ),

                  const SizedBox(height: 18),

                  // Continue button (pill)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    child: CustomButton(
                      text: 'Continue Field Inspection',
                      onPressed: () {},
                      backgroundColor: AppColors.brown,
                      foregroundColor: Colors.white,
                      width: double.infinity,
                      height: 50,
                      radius: 28,
                      //fontWeight: FontWeight.w700,
                    ),
                  ),

                  const SizedBox(height: 10),

                  Padding(
                    padding: const EdgeInsets.fromLTRB(14, 6, 14, 6),
                    child: Row(
                      children: [
                        // Wheat sticker
                        // Image.asset(
                        //   'Assets/HomeScreens/Logo.png',
                        //   width: 60,
                        //   height: 60,
                        //   fit: BoxFit.contain,
                        // ),
                        const Spacer(),
                        TextButton.icon(
                          onPressed: () {},
                          icon: const SizedBox.shrink(),
                          label: Row(
                            children: [
                              Text(
                                'Skip',
                                style: TextStyle(
                                  fontSize: tertiary(),
                                  color: Colors.black87,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(width: 4),
                              Icon(
                                Icons.chevron_right,
                                size: 18,
                                color: Colors.black87,
                              ),
                            ],
                          ),
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 6,
                            ),
                            foregroundColor: Colors.black87,
                          ),
                        ),
                      ],
                    ),
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

/// Frosted / glass card with gradient & rounded corners
class _FrostedCard extends StatelessWidget {
  final Widget child;
  const _FrostedCard({required this.child});

  @override
  Widget build(BuildContext context) {
    // Card width responsive
    final width = MediaQuery.of(context).size.width - 24;

    return ClipRRect(
      borderRadius: BorderRadius.circular(22),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 14, sigmaY: 14),
        child: Container(
          width: width,
          padding: const EdgeInsets.only(top: 14, bottom: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(22),
            // Subtle gradient like the mock (cool blue -> warm green)
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                const Color(0xFFBFD9FF).withOpacity(0.38), // skyish
                const Color(0xFFA8D5A0).withOpacity(0.36), // greenish
              ],
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.12),
                blurRadius: 16,
                offset: const Offset(0, 6),
              ),
            ],
            border: Border.all(
              color: Colors.white.withOpacity(0.65),
              width: 1.2,
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}
