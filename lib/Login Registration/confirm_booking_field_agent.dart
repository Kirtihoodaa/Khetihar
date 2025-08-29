import 'package:flutter/material.dart';

import '../Theme/AppColors.dart';
import '../Theme/FontSize.dart';
import 'booking_detail_summary_card.dart';

class ConfirmBookingFieldAgent extends StatelessWidget {
  const ConfirmBookingFieldAgent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Transform.translate(
        offset: Offset(0, 90),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
          child: Center(
            child: Column(
              children: [
                BookingConfirmed(),
                SizedBox(height: 20),
                BookingDetailsExact(
                  bookingId: 'FLD-29875',
                  date: DateTime(2025, 7, 19),
                  time: const TimeOfDay(hour: 12, minute: 0),
                  address: '123 pune',
                  onHomeTap: () {
                    // navigate to home
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Uses your AppColors and size helpers (primary()/tertiary()).

class BookingConfirmed extends StatelessWidget {
  const BookingConfirmed({
    super.key,
    this.message = 'Your Booking is Confirmed!',
    this.color = AppColors.green,
    this.diameter = 56, // circle size from the mock
    this.iconSize = 38, // check size
    this.gap = 12, // space between icon and text
  });

  final String message;
  final Color color;
  final double diameter;
  final double iconSize;
  final double gap;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: diameter,
          height: diameter,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          child: Icon(
            Icons.check, // simple check mark like the image
            size: iconSize,
            color: Colors.white,
          ),
        ),
        SizedBox(height: gap),
        Text(
          message,
          style: TextStyle(
            fontSize: secondary(), // 14 per your scale (looks like the mock)
            fontWeight: FontWeight.w600,
            color: color,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
