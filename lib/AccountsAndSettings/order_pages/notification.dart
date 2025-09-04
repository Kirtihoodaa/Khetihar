import 'package:flutter/material.dart';
import 'package:khetihar/Components/CustomAppBar.dart';
import 'package:khetihar/Components/CustomTogglebutton.dart';

class NotificationSettingsPage extends StatelessWidget {
  const NotificationSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: KCenteredActionsAppBar(title: "Notifications"),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          color: Colors.white,
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                buildRow("Assets/Accounts/push.png", "Push Notification"),
                buildRow("Assets/Accounts/email.png", "Email Notification"),
                buildRow("Assets/Accounts/sms.png", "SMS Notification"),
                buildRow(
                  "Assets/Accounts/whatsapp.png",
                  "Whatsapp Notification",
                ),
                buildRow("Assets/Accounts/inapp.png", "Inapp Notification"),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildRow(String imagePath, String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Image.asset(imagePath, height: 40, width: 40),
              const SizedBox(width: 12),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          CustomToggleButton(
            initialValue: true,
            onChanged: (val) {
              debugPrint("$title: $val");
            },
          ),
        ],
      ),
    );
  }
}
