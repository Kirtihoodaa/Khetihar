import 'package:flutter/material.dart';
import 'package:khetihar/Components/CustomAppBar.dart';
import 'package:khetihar/Components/CustomButton.dart';
import 'package:khetihar/Theme/AppColors.dart';
import 'package:khetihar/Theme/FontSize.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  String selectedMethod = "Card";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: CustomAppBar(),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Schedule Soil Testing",
                    style: TextStyle(
                      fontSize: primary(),
                      fontWeight: FontWeight.bold,
                      color: AppColors.green,
                    ),
                  ),
                  const SizedBox(height: 16),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildStepCircle("Collection\nDetails", true),
                      _buildDashedLine(),
                      _buildStepCircle("Contact\nInformation", true),
                      _buildDashedLine(),
                      _buildStepCircle("Payment", true),
                    ],
                  ),
                  const SizedBox(height: 24),

                  Text(
                    "Payments Method",
                    style: TextStyle(
                      fontSize: primary(),
                      fontWeight: FontWeight.bold,
                      color: AppColors.green,
                    ),
                  ),
                  const SizedBox(height: 16),

                  _buildPaymentOption("Credit/Debit Card", "Card"),
                  const SizedBox(height: 12),
                  _buildPaymentOption("UPI", "UPI"),
                  const SizedBox(height: 20),

                  Text(
                    "Saved Card",
                    style: TextStyle(
                      fontSize: primary(),
                      fontWeight: FontWeight.bold,
                      color: AppColors.green,
                    ),
                  ),
                  const SizedBox(height: 12),

                  Row(
                    children: [
                      Expanded(child: _buildSavedCard("ICICI Bank", "1234")),
                      const SizedBox(width: 12),
                      Expanded(child: _buildSavedCard("ICICI Bank", "5678")),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Request Soil Testing Section
                  Card(
                    color: AppColors.secondarygrey,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Request Soil Testing",
                            style: TextStyle(
                              fontSize: primary(),
                              fontWeight: FontWeight.bold,
                              color: AppColors.green,
                            ),
                          ),
                          const SizedBox(height: 12),

                          Row(
                            children: [
                              const Icon(Icons.eco, color: Colors.green),
                              const SizedBox(width: 8),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text("Soil Testing"),
                                  Text(
                                    "INR 300",
                                    style: TextStyle(
                                      color: AppColors.green,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),

                          Row(
                            children: const [
                              Icon(
                                Icons.calendar_today,
                                color: Colors.black54,
                                size: 18,
                              ),
                              SizedBox(width: 8),
                              Text("Monday, July 19, 2025"),
                            ],
                          ),
                          const SizedBox(height: 8),

                          Row(
                            children: const [
                              Icon(
                                Icons.access_time,
                                color: Colors.black54,
                                size: 18,
                              ),
                              SizedBox(width: 8),
                              Text("12:00 PM"),
                            ],
                          ),
                          const SizedBox(height: 8),

                          Row(
                            children: const [
                              Icon(
                                Icons.location_on,
                                color: Colors.black54,
                                size: 18,
                              ),
                              SizedBox(width: 8),
                              Text("123 Pune"),
                            ],
                          ),
                          const SizedBox(height: 16),

                          // Subtotal & Total
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [Text("Subtotal"), Text("INR 500")],
                          ),
                          const SizedBox(height: 6),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Total",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "INR 500",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.green,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),

          // Bottom Pay Button
          Container(
            padding: const EdgeInsets.all(16),
            child: CustomButton(
              text: "Pay",
              onPressed: () {
                // Handle payment action
              },
              expand: true,
              variant: ButtonVariant.filled,
              backgroundColor: AppColors.green,
              foregroundColor: Colors.white,
              radius: 30,
              padding: const EdgeInsets.symmetric(vertical: 14),
            ),
          ),
        ],
      ),
    );
  }

  /// Stepper Circle Widget
  Widget _buildStepCircle(String text, bool isActive) {
    return Column(
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isActive ? AppColors.green : Colors.grey.shade200,
          ),
          alignment: Alignment.center,
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: small(),
              fontWeight: FontWeight.w600,
              color: isActive ? Colors.white : Colors.black,
            ),
          ),
        ),
      ],
    );
  }

  /// Dashed Line Widget
  Widget _buildDashedLine() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      child: Row(
        children: List.generate(
          6,
          (index) => Container(
            margin: const EdgeInsets.symmetric(horizontal: 2),
            width: 6,
            height: 2,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }

  Widget _buildPaymentOption(String title, String method) {
    return InkWell(
      onTap: () {
        setState(() {
          selectedMethod = method;
        });
      },
      child: Card(
        color: AppColors.secondarygrey,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              Icon(
                selectedMethod == method
                    ? Icons.radio_button_checked
                    : Icons.radio_button_off,
                color: AppColors.green,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(title, style: TextStyle(fontSize: secondary())),
              ),
              if (method == "Card")
                Row(
                  children: const [
                    Icon(Icons.credit_card, color: Colors.black54),
                    SizedBox(width: 6),
                    Icon(Icons.payment, color: Colors.black54),
                  ],
                ),
              if (method == "UPI")
                const Icon(Icons.account_balance_wallet, color: Colors.black54),
            ],
          ),
        ),
      ),
    );
  }

  /// Saved Card Widget
  Widget _buildSavedCard(String bank, String lastDigits) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 3,
      child: Container(
        padding: const EdgeInsets.all(16),
        height: 120,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: const LinearGradient(
            colors: [Colors.purple, Colors.green],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              bank,
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
            const Spacer(),
            Text(
              "**** **** **** $lastDigits",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                letterSpacing: 2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
