import 'package:flutter/material.dart';
import 'package:khetihar/Components/CustomButton.dart';
import 'package:khetihar/Components/InputFields.dart';
import 'package:khetihar/Theme/AppColors.dart';

class demo extends StatelessWidget {
  const demo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(top: 50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 1) Filled primary, full width
            CustomButton(
              text: 'Continue',
              onPressed: () {},
              foregroundColor: Colors.white,
              expand: true,
            ),

            // 2) Outline  custom colors and icon at end
            CustomButton(
              text: 'View Details',
              onPressed: () {},
              variant: ButtonVariant.outline,
              foregroundColor: Colors.black,
              borderColor: AppColors.green,
              radius: 999, // pill
              icon: Icons.chevron_right,
              iconPosition: IconPosition.end,
            ),

            // 3) Compact text button
            CustomButton(
              text: 'Skip',
              onPressed: () {},
              variant: ButtonVariant.text,
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
              fontSize: 13,
            ),

            // 4 ) Show bottom two buttons in a row
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: CustomButton(
                    text: 'Pay',
                    onPressed: () {},
                    height: 44,
                    radius: 12,
                    elevation: 1,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  flex: 2,
                  child: CustomButton(
                    text: 'Continue with Google',
                    onPressed: () {},
                    iconWidget: Image.asset(
                      'Assets/HomeScreens/Onbording1.png',
                      width: 18,
                      height: 18,
                    ),
                    iconGap: 10,
                    radius: 8,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      // 1) Only numbers (e.g., age), 1–3 digits
                      CustomInputField(
                        labelText: 'Age',
                        allowedType: AllowedType.numeric,
                        maxLength: 3,
                        minNumber: 1,
                        maxNumber: 120,

                        validator:
                            (v) =>
                                v == null || v.isEmpty
                                    ? 'Age is required'
                                    : null,
                      ),
                      SizedBox(height: 8),

                      // 2) Decimal up to 2 places, no negatives
                      CustomInputField(
                        labelText: 'Amount',
                        allowedType: AllowedType.decimal,
                        decimalPlaces: 2,
                        allowNegative: false,
                      ),

                      SizedBox(height: 8),

                      // 3) Text + numbers + spaces
                      CustomInputField(
                        labelText: 'Address line',
                        allowedType: AllowedType.textNumeric,
                        maxLength: 80,
                      ),
                      SizedBox(height: 8),

                      // 4) Email
                      CustomInputField(
                        labelText: 'Email',
                        allowedType: AllowedType.email,
                      ),
                      SizedBox(height: 8),

                      // 5) Phone (+91… or digits)
                      CustomInputField(
                        labelText: 'Phone',
                        allowedType: AllowedType.phone,
                        allowSpaces: false,
                        maxLength: 15,
                        // controller: phoneCtrl,
                      ),
                      SizedBox(height: 8),

                      // 6) Uppercase alphanumeric code (e.g., IFSC/GST partials)
                      CustomInputField(
                        labelText: 'Code',
                        allowedType: AllowedType.uppercaseAlphaNum,
                        maxLength: 11,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
