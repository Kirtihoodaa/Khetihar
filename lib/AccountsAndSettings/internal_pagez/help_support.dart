import 'package:flutter/material.dart';
import 'package:khetihar/Components/CustomAppBar.dart';
import 'package:khetihar/Theme/AppColors.dart';
import 'package:khetihar/Theme/FontSize.dart';

class HelpSupportScreen extends StatefulWidget {
  const HelpSupportScreen({super.key});

  @override
  State<HelpSupportScreen> createState() => _HelpSupportScreenState();
}

class _HelpSupportScreenState extends State<HelpSupportScreen> {
  // Track which tile is expanded
  int? expandedIndex;

  final List<Map<String, String>> faqs = [
    {
      "question": "What documents are required?",
      "answer":
          "You will need valid ID proof, address proof, and relevant financial documents depending on the scheme.",
    },
    {
      "question": "How long is the approval process?",
      "answer":
          "Approval usually takes 7–15 days, depending on the bank and verification.\nSome schemes like KCC offer faster processing.",
    },
    {
      "question": "How Long Does It Take to Apply?",
      "answer":
          "The application process usually takes less than 30 minutes if all documents are ready.",
    },
    {
      "question": "What if my application is rejected?",
      "answer":
          "If rejected, you will receive an explanation. You may reapply after correcting the issues.",
    },
    {
      "question": "What are the repayment options?",
      "answer":
          "Repayments can be made monthly, quarterly, or annually depending on your loan scheme.",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: KCenteredActionsAppBar(title: "Help & Support"),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: faqs.length,
        itemBuilder: (context, index) {
          final isExpanded = expandedIndex == index;
          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: () {
                setState(() {
                  expandedIndex = isExpanded ? null : index;
                });
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 12,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Question row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            faqs[index]["question"]!,
                            style: TextStyle(
                              fontSize: tertiary(),
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        Icon(
                          isExpanded ? Icons.close : Icons.add,
                          color: isExpanded ? AppColors.red : AppColors.green,
                          size: 20,
                        ),
                      ],
                    ),
                    // Answer (only when expanded)
                    if (isExpanded) ...[
                      const SizedBox(height: 8),
                      Text(
                        faqs[index]["answer"]!,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade800,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
