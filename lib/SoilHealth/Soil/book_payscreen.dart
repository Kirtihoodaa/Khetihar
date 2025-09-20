import 'package:flutter/material.dart';
import 'package:khetihar/Theme/AppColors.dart';
import 'package:khetihar/Theme/FontSize.dart';

import '../../Components/CustomButton.dart'; // <-- your custom button file

class BookingConfirmedPage extends StatelessWidget {
  const BookingConfirmedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 40),

              CircleAvatar(
                radius: 36,
                backgroundColor: AppColors.green,
                child: const Icon(Icons.check, color: Colors.white, size: 32),
              ),

              const SizedBox(height: 20),

              Text(
                "Booking Confirmed!",
                style: TextStyle(
                  fontSize: primary(),
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),

              const SizedBox(height: 6),

              Text(
                "Confirmation #ST24051687",
                style: TextStyle(fontSize: secondary(), color: Colors.black54),
              ),

              const SizedBox(height: 24),

              Card(
                color: AppColors.secondarygrey,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Collection Details",
                        style: TextStyle(
                          fontSize: primary(),
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Name
                      Row(
                        children: [
                          Icon(
                            Icons.person_outline,
                            size: 20,
                            color: AppColors.green,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            "Rajesh Kumar",
                            style: TextStyle(
                              fontSize: tertiary(),
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),

                      // Phone
                      Row(
                        children: [
                          Icon(
                            Icons.phone_outlined,
                            size: 20,
                            color: AppColors.green,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            "+91 9988765543",
                            style: TextStyle(
                              fontSize: tertiary(),
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),

                      // Date
                      Row(
                        children: [
                          Icon(
                            Icons.calendar_today_outlined,
                            size: 20,
                            color: AppColors.green,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            "Monday, July 19, 2025",
                            style: TextStyle(
                              fontSize: tertiary(),
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),

                      // Time
                      Row(
                        children: [
                          Icon(
                            Icons.access_time,
                            size: 20,
                            color: AppColors.green,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            "12:00 PM",
                            style: TextStyle(
                              fontSize: tertiary(),
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),

                      // Address
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.location_on_outlined,
                            size: 20,
                            color: AppColors.green,
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              "123 Farm Road, Green Fields, Agriculture District, Karnataka 560001",
                              style: TextStyle(
                                fontSize: tertiary(),
                                color: Colors.black87,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              const Spacer(),

              CustomButton(
                text: "Book To Home",
                expand: true,
                backgroundColor: AppColors.green,
                foregroundColor: Colors.white,
                radius: 30,
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
