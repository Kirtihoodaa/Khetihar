import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khetihar/Components/CustomButton.dart';
import 'package:khetihar/Theme/AppColors.dart';
import 'package:khetihar/Theme/FontSize.dart';

class OnboardingSlide {
  final String imageAsset;
  final String title;
  final String subtitle;
  OnboardingSlide({
    required this.imageAsset,
    required this.title,
    required this.subtitle,
  });
}

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int _index = 0;

  final List<OnboardingSlide> _slides = [
    OnboardingSlide(
      imageAsset: 'Assets/HomeScreens/Onbording1.png',
      title: 'Grow Smarter with Expert\nCrop Advic',
      subtitle:
          'Get instant, personalized\nrecommendations for your crops using AI\n+ expert analysis.',
    ),
    OnboardingSlide(
      imageAsset: 'Assets/HomeScreens/Onbording2.png',
      title: 'Plan with Weather & Soil Insights',
      subtitle:
          'Stay prepared with local weather\n forecasts and soil health reports before\n you plant.',
    ),
    OnboardingSlide(
      imageAsset: 'Assets/HomeScreens/Onbording3.png',
      title: 'Detect Pests & Diseases Early',
      subtitle:
          'Upload crop images to diagnose issues\n fast and get expert treatment advice\n instantly.',
    ),
  ];

  void _goNext() {
    if (_index < _slides.length - 1) {
      _controller.animateToPage(
        _index + 1,
        duration: Duration(milliseconds: 280),
        curve: Curves.ease,
      );
    } else {
      Get.offAllNamed('/welcome');
    }
  }

  void _skip() {
    Get.offAllNamed('/welcome');
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _dots() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(_slides.length, (i) {
        final bool isActive = i == _index;
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 6),
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isActive ? Colors.white : AppColors.greyBorder,
            border: Border.all(
              color: isActive ? AppColors.green : Colors.transparent,
              width: 6,
            ),
          ),
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(top: 20, left: 10, right: 10),
          child: Column(
            children: [
              // Card with image + Skip
              Stack(
                children: [
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(28),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(28),
                      child: AspectRatio(
                        aspectRatio: 0.75,
                        child: PageView.builder(
                          controller: _controller,
                          physics: const NeverScrollableScrollPhysics(),
                          onPageChanged: (i) => setState(() => _index = i),
                          itemCount: _slides.length,
                          itemBuilder: (context, i) {
                            return Stack(
                              fit: StackFit.expand,
                              children: [
                                // Illustration (covers top part)
                                Align(
                                  alignment: Alignment.topCenter,
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(28),
                                      topRight: Radius.circular(28),
                                    ),
                                    child: Image.asset(
                                      _slides[i].imageAsset,
                                      fit: BoxFit.cover,
                                      height: double.infinity,
                                      width: double.infinity,
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  // Skip button
                  Positioned(
                    right: 5,
                    top: 8,
                    child: TextButton.icon(
                      onPressed: _skip,
                      style: TextButton.styleFrom(
                        foregroundColor: AppColors.green,
                        padding: EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                      ),
                      icon: const SizedBox.shrink(),
                      label: Row(
                        children: [
                          Text(
                            'Skip',
                            style: TextStyle(
                              fontSize: primary(),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: 2),
                          Icon(Icons.chevron_right, size: 20),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 22),

              // Title
              Text(
                _slides[_index].title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  height: 1.25,
                  fontWeight: FontWeight.bold,
                  color: AppColors.green,
                ),
              ),

              const SizedBox(height: 14),

              // Subtitle
              Text(
                _slides[_index].subtitle,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: secondary(),
                  height: 1.5,
                  fontWeight: FontWeight.w300,
                ),
              ),

              const Spacer(),

              // Next button
              SizedBox(
                width: double.infinity,
                child: CustomButton(
                  text: 'Next',
                  onPressed: _goNext,
                  variant: ButtonVariant.filled,
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  fontSize: primary(),
                  fontWeight: FontWeight.w700,
                  radius: 32,
                  backgroundColor: AppColors.green,
                  foregroundColor: Colors.white,
                ),
              ),

              const SizedBox(height: 14),

              // Dots
              _dots(),
            ],
          ),
        ),
      ),
    );
  }
}
