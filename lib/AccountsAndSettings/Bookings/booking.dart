import 'package:flutter/material.dart';
import 'package:khetihar/Components/CustomAppBar.dart';
import '../../Theme/AppColors.dart';
import '../../Theme/FontSize.dart';

class Booking extends StatelessWidget {
  const Booking({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: KCenteredActionsAppBar(title: "Bookings"),
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        child: Column(
          children: [
            BookingDetailsCardExact(
              confirmationNumber: '12344u5',
              purpose: 'Soil Test Collection Details',
              soilCollector: 'Rajesh Kumar',
              contact: '+91 9988765543',
              date: 'Monday, July 19, 2025',
              collectionTime: '12:00 PM',
              address:
                  '123 Farm Road, Green Fields, Agriculture District, Karnataka 560001',
              priceText: 'INR 600',
            ),
            ExpertConsultationCard(
              bookingId: 'TBA12344u5sd2240',
              purpose: 'Crop Selection Consultation',
              date: 'Monday, July 19, 2025',
              time: '12:00 PM',
              address:
                  '123 Farm Road, Green Fields, Agriculture District, Karnataka 560001',
              priceText: 'INR 600',
            ),
          ],
        ),
      ),
    );
  }
}

class BookingDetailsCardExact extends StatelessWidget {
  const BookingDetailsCardExact({
    super.key,
    required this.confirmationNumber,
    required this.purpose,
    required this.soilCollector,
    required this.contact,
    required this.date,
    required this.collectionTime,
    required this.address,
    required this.priceText,
    this.status = 'Pending', // default status
  });

  final String confirmationNumber;
  final String purpose;
  final String soilCollector;
  final String contact;
  final String date;
  final String collectionTime;
  final String address;
  final String priceText;
  final String status;

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).copyWith(textScaleFactor: 1.0);

    return MediaQuery(
      data: mq,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.greyBorder, width: 1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Confirmation Number and Status (e.g., "Pending" green badge)
            Row(
              children: [
                Text(
                  'Conformation       #$confirmationNumber',
                  style: TextStyle(
                    fontSize: secondary(), // 16
                    fontWeight: FontWeight.w600,
                    color: Colors.black.withOpacity(0.7),
                  ),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.green,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    status,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                      height: 1.0,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),

            // Booking Purpose and Soil Collector
            _KeyValueRow(keyText: 'Booking Purpose', valueText: purpose),
            const SizedBox(height: 8),
            _KeyValueRow(
              keyText: 'Soil Collector       ',
              valueText: soilCollector,
            ),
            const SizedBox(height: 8),
            _KeyValueRow(
              keyText: 'Contact                ',
              valueText: contact,
            ),
            const SizedBox(height: 8),

            // Date and Collection Time
            _KeyValueRow(
              keyText: 'Date                      ',
              valueText: date,
            ),
            const SizedBox(height: 8),
            _KeyValueRow(
              keyText: 'Collection Time   ',
              valueText: collectionTime,
            ),
            const SizedBox(height: 12),

            // Address
            Text(
              'Address',
              style: TextStyle(
                fontSize: secondary(), // 16
                fontWeight: FontWeight.w600,
                color: Colors.black.withOpacity(0.75),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              address,
              style: TextStyle(
                fontSize: tertiary(), // 14
                color: Colors.black.withOpacity(0.70),
                height: 1.35,
              ),
            ),
            const SizedBox(height: 12),

            // Price row at the bottom
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  priceText,
                  style: TextStyle(
                    fontSize: primary(), // 18
                    fontWeight: FontWeight.w700,
                    color: AppColors.green,
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

class _KeyValueRow extends StatelessWidget {
  const _KeyValueRow({required this.keyText, required this.valueText});

  final String keyText;
  final String valueText;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '$keyText  :',
          style: TextStyle(
            fontSize: secondary(), // 16
            fontWeight: FontWeight.w600,
            color: Colors.black.withOpacity(0.75),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            valueText,
            style: TextStyle(
              fontSize: tertiary(),
              // 14
              fontWeight: FontWeight.w400,
              color: Colors.black.withOpacity(0.70),
              height: 2.35,
            ),
          ),
        ),
      ],
    );
  }
}

class ExpertConsultationCard extends StatelessWidget {
  const ExpertConsultationCard({
    super.key,
    required this.bookingId,
    required this.purpose,
    required this.date,
    required this.time,
    required this.address,
    required this.priceText,
    this.status = 'Pending', // default status
  });

  final String bookingId;
  final String purpose;
  final String date;
  final String time;
  final String address;
  final String priceText;
  final String status;

  @override
  Widget build(BuildContext context) {
    // Lock scaling for exact 1:1 parity
    final mq = MediaQuery.of(context).copyWith(textScaleFactor: 1.0);

    return MediaQuery(
      data: mq,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.greyBorder, width: 1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title and Status
            Row(
              children: [
                Text(
                  'Expert Consultation details',
                  style: TextStyle(
                    fontSize: secondary(), // 16
                    fontWeight: FontWeight.w600,
                    color: AppColors.green,
                  ),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.green,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    status,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                      height: 1.0,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Key-Value rows for Booking ID, Purpose, etc.
            _KeyValueRow2(
              keyText: 'Booking ID             ',
              valueText: bookingId,
            ),
            const SizedBox(height: 8),
            _KeyValueRow2(keyText: 'Booking Purpose  ', valueText: purpose),
            const SizedBox(height: 8),
            _KeyValueRow2(
              keyText: 'Date                        ',
              valueText: date,
            ),
            const SizedBox(height: 8),
            _KeyValueRow2(
              keyText: 'Time                        ',
              valueText: time,
            ),
            const SizedBox(height: 8),

            // Address section
            Text(
              'Address',
              style: TextStyle(
                fontSize: secondary(), // 16
                fontWeight: FontWeight.w600,
                color: Colors.black.withOpacity(0.85),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              address,
              style: TextStyle(
                fontSize: tertiary(), // 14
                color: Colors.black.withOpacity(0.70),
                height: 1.35,
              ),
            ),
            const SizedBox(height: 12),

            // Price section at the bottom
            Row(
              children: [
                Text(
                  priceText,
                  style: TextStyle(
                    fontSize: primary(), // 18
                    fontWeight: FontWeight.w700,
                    color: AppColors.green,
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

class _KeyValueRow2 extends StatelessWidget {
  const _KeyValueRow2({required this.keyText, required this.valueText});

  final String keyText;
  final String valueText;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          '$keyText :',
          style: TextStyle(
            fontSize: secondary(), // 16
            fontWeight: FontWeight.w600,
            color: Colors.black.withOpacity(0.85),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            valueText,
            style: TextStyle(
              fontSize: secondary(), // 16
              fontWeight: FontWeight.w400,
              color: Colors.black.withOpacity(0.70),
              height: 1.55,
            ),
          ),
        ),
      ],
    );
  }
}
