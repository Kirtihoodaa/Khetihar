import 'package:flutter/material.dart';
import 'package:khetihar/Components/CustomAppBar.dart';
import 'package:khetihar/Theme/AppColors.dart';
import 'package:khetihar/Theme/FontSize.dart';

class LoanRequestAccount extends StatelessWidget {
  const LoanRequestAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: KCenteredActionsAppBar(title: "Loan Request"),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          color: Colors.white,
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(14.0),
            child: Column(
              mainAxisSize: MainAxisSize.min, // 👈 ensures card fits content
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Request ID : #12344u5",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: secondary(),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.green,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text(
                        "Under Review",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                const Text("Loan Type: Agriculture Equipment Loan"),
                const SizedBox(height: 4),
                const Text("Requested On: 12 July 2025"),
                const SizedBox(height: 4),
                const Text("Amount: ₹1,50,000"),
                const SizedBox(height: 4),
                const Text("Tenure: 12 Months"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
