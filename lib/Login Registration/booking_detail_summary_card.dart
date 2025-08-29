import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:khetihar/Components/CustomButton.dart';

import '../Theme/AppColors.dart';
import '../Theme/FontSize.dart';

// Assumes your helpers exist:
// double primary() => 18; double tertiary() => 14;

class BookingDetailsExact extends StatelessWidget {
  const BookingDetailsExact({
    super.key,
    required this.bookingId,
    required this.date, // e.g., DateTime(2025, 7, 19)
    required this.time, // e.g., const TimeOfDay(hour: 12, minute: 0)
    required this.address, // e.g., '123 pune'
    required this.onHomeTap,
    this.buttonLabel = 'Book To Home',
  });

  final String bookingId;
  final DateTime date;
  final TimeOfDay time;
  final String address;
  final VoidCallback onHomeTap;
  final String buttonLabel;

  @override
  Widget build(BuildContext context) {
    // Formats that match the UI: "Monday, July 19, 2025" & "12:00 PM"
    final dateStr = DateFormat('EEEE, MMMM d, yyyy').format(date);
    final dt = DateTime(
      date.year,
      date.month,
      date.day,
      time.hour,
      time.minute,
    );
    final timeStr = DateFormat('hh:mm a').format(dt);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Card
        Container(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 14),
          decoration: BoxDecoration(
            color: AppColors.grey, // #F7F8F9
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: AppColors.greyBorder), // #E8ECF4
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title
              Text(
                'Booking Details',
                style: TextStyle(
                  fontSize: primary(), // 18
                  fontWeight: FontWeight.w600, // semibold like mock
                  color: AppColors.green,
                  height: 1.2,
                ),
              ),
              const SizedBox(height: 12),

              // Booking ID row
              Row(
                children: [
                  Text(
                    'Booking ID:',
                    style: TextStyle(
                      fontSize: tertiary(), // 14
                      fontWeight: FontWeight.w500,
                      color: Colors.black.withOpacity(0.82),
                      height: 1.3,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    bookingId,
                    style: TextStyle(
                      fontSize: tertiary(),
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                      height: 1.3,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Date row
              _InfoRowExact(icon: Icons.calendar_today_rounded, text: dateStr),
              const SizedBox(height: 10),

              // Time row
              _InfoRowExact(icon: Icons.access_time_rounded, text: timeStr),
              const SizedBox(height: 10),

              // Address row
              _InfoRowExact(icon: Icons.place_rounded, text: address),
            ],
          ),
        ),

        // Spacing between card and button (matches screenshot)
        const SizedBox(height: 18),

        // Stadium CTA button
        SizedBox(
          height: 56, // rounded pill look
          child: CustomButton(
            text: buttonLabel,
            onPressed: () {},
            foregroundColor: Colors.white,
          ),
        ),
      ],
    );
  }
}

// Small circular green-outlined badge + label (tight like mock)
class _InfoRowExact extends StatelessWidget {
  const _InfoRowExact({required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Badge matches proportions in screenshot
        Container(
          width: 22,
          height: 22,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.green, width: 1.6),
          ),
          child: Icon(icon, size: 13, color: AppColors.green),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: tertiary(), // 14
              color: Colors.black87,
              height: 1.35,
            ),
          ),
        ),
      ],
    );
  }
}
