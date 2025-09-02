import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:khetihar/Components/CustomButton.dart';
import 'package:khetihar/Login Registration/Field.dart';
import 'package:khetihar/Theme/AppColors.dart';
import 'package:khetihar/Theme/FontSize.dart';

class BookFieldScreen extends StatelessWidget {
  BookFieldScreen({super.key});

  final ValueNotifier<int> _periodIndex = ValueNotifier<int>(0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Choose Your Farm Plan',
                style: TextStyle(
                  fontSize: primary(),
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'Select the plan that works best for your\nagricultural needs',
                style: TextStyle(
                  fontSize: secondary(),
                  height: 1.35,
                  color: Colors.black.withOpacity(0.6),
                ),
              ),
              const SizedBox(height: 16),

              // Toggle with ValueListenableBuilder
              ValueListenableBuilder<int>(
                valueListenable: _periodIndex,
                builder: (context, index, _) {
                  return _PlanPeriodToggle(
                    index: index,
                    onChanged: (i) => _periodIndex.value = i,
                  );
                },
              ),
              const SizedBox(height: 16),

              // Free Plan Card
              _FreePlanCard(
                onGetStarted: () {
                  Get.toNamed('/FieldInspection');
                },
              ),
              const SizedBox(height: 16),

              // Premium Plan Card (reactive with ValueListenable)
              ValueListenableBuilder<int>(
                valueListenable: _periodIndex,
                builder: (context, index, _) {
                  return _PremiumPlanCard(
                    periodIndex: index,
                    onStartTrial: () {
                      debugPrint("Premium plan selected");
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// ------------------ PERIOD TOGGLE ------------------
class _PlanPeriodToggle extends StatelessWidget {
  final int index;
  final ValueChanged<int> onChanged;
  const _PlanPeriodToggle({required this.index, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44,
      decoration: BoxDecoration(
        color: AppColors.grey,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: AppColors.greyBorder),
      ),
      child: Stack(
        children: [
          // animated pill background
          AnimatedAlign(
            duration: const Duration(milliseconds: 220),
            curve: Curves.easeOut,
            alignment:
                index == 0 ? Alignment.centerLeft : Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.all(4),
              child: Container(
                width: (MediaQuery.of(context).size.width - 16 * 2 - 8) * 0.5,
                decoration: BoxDecoration(
                  color: AppColors.green,
                  borderRadius: BorderRadius.circular(24),
                ),
              ),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: InkWell(
                  borderRadius: BorderRadius.circular(28),
                  onTap: () => onChanged(0),
                  child: Center(
                    child: Text(
                      'Monthly',
                      style: TextStyle(
                        fontSize: secondary(),
                        fontWeight: FontWeight.w600,
                        color: index == 0 ? Colors.white : Colors.black87,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: InkWell(
                  borderRadius: BorderRadius.circular(28),
                  onTap: () => onChanged(1),
                  child: Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Annual',
                          style: TextStyle(
                            fontSize: secondary(),
                            fontWeight: FontWeight.w600,
                            color: index == 1 ? Colors.white : Colors.black87,
                          ),
                        ),
                        const SizedBox(width: 6),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color:
                                index == 1
                                    ? Colors.white.withOpacity(0.2)
                                    : AppColors.brown,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            'Save 20%',
                            style: TextStyle(
                              fontSize: small(),
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// ------------------ FREE PLAN CARD ------------------
class _FreePlanCard extends StatelessWidget {
  final VoidCallback onGetStarted;
  const _FreePlanCard({required this.onGetStarted});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: AppColors.brown, width: 1),
        borderRadius: BorderRadius.circular(14),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Free',
            style: TextStyle(
              fontSize: primary(),
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 6),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                'INR 0',
                style: TextStyle(
                  fontSize: large(),
                  fontWeight: FontWeight.w800,
                  color: Colors.black,
                ),
              ),
              SizedBox(width: 4),
              Padding(
                padding: EdgeInsets.only(bottom: 4),
                child: Text(
                  '/month',
                  style: TextStyle(fontSize: tertiary(), color: Colors.black54),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _feature('Basic crop advisory'),
          _feature('Community access'),
          _feature('Market price updates'),
          _feature('Community support'),
          const SizedBox(height: 14),
          CustomButton(
            text: 'Get Started',
            onPressed: onGetStarted,
            variant: ButtonVariant.outline,
            foregroundColor: AppColors.brown,
            borderColor: AppColors.brown,
            width: double.infinity,
            height: 40,
            radius: 28,
          ),
        ],
      ),
    );
  }
}

/// ------------------ PREMIUM PLAN CARD ------------------
class _PremiumPlanCard extends StatelessWidget {
  final int periodIndex;
  final VoidCallback onStartTrial;
  const _PremiumPlanCard({
    required this.periodIndex,
    required this.onStartTrial,
  });

  @override
  Widget build(BuildContext context) {
    final priceText = periodIndex == 0 ? 'INR 120' : 'INR 1150';

    return Container(
      decoration: BoxDecoration(
        color: AppColors.green,
        borderRadius: BorderRadius.circular(14),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Premium',
                style: TextStyle(
                  fontSize: primary(),
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: AppColors.darkGreen,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  'MOST POPULAR',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: small(),
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                priceText,
                style: TextStyle(
                  fontSize: large(),
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                ),
              ),
              SizedBox(width: 4),
              Padding(
                padding: EdgeInsets.only(bottom: 4),
                child: Text(
                  '/month',
                  style: TextStyle(fontSize: tertiary(), color: Colors.white70),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _feature('All Normal Plan features', light: true),
          _feature('Premium seeds & fertilizers', light: true),
          _feature('Expert advice priority', light: true),
          _feature('Loan application assistance', light: true),
          _feature('Tools rental discount', light: true),
          _feature('Individual Chat', light: true),
          const SizedBox(height: 14),
          CustomButton(
            text: 'Start 7–Day Free Trial',
            onPressed: onStartTrial,
            backgroundColor: Colors.white,
            foregroundColor: AppColors.brown,
            width: double.infinity,
            height: 40,
            radius: 28,
            fontWeight: FontWeight.w700,
          ),
        ],
      ),
    );
  }
}

/// ------------------ FEATURE ROW ------------------
Widget _feature(String text, {bool light = false}) {
  final tickColor = light ? Colors.white : Colors.black87;
  final borderColor = light ? Colors.white70 : AppColors.greyBorder;

  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 6),
    child: Row(
      children: [
        Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            border: Border.all(color: borderColor, width: 1.3),
            shape: BoxShape.circle,
          ),
          child: Icon(Icons.check, size: 14, color: tickColor),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: tertiary(),
              color: light ? Colors.white : Colors.black87,
              height: 1.35,
            ),
          ),
        ),
      ],
    ),
  );
}
