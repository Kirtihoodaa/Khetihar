import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:khetihar/Components/CustomButton.dart';
import 'package:khetihar/Login%20Registration/confirm_booking_field_agent.dart';

import '../Theme/AppColors.dart';
import '../Theme/FontSize.dart';

class FieldAgentSchedulePicker extends StatefulWidget {
  const FieldAgentSchedulePicker({
    super.key,
    this.dates,
    this.timeSlots,
    this.initialDate,
    this.initialTime,
    this.onDateChanged,
    this.onTimeChanged,
    this.onConfirm,
    this.buttonLabel = 'Book Field Agent',
    this.padding = const EdgeInsets.all(16),
    this.showButton = true,
  });

  /// Provide dates; defaults to next 7 days.
  final List<DateTime>? dates;

  /// Provide time slots; defaults to 10:00–17:00 hourly.
  final List<TimeOfDay>? timeSlots;

  final DateTime? initialDate;
  final TimeOfDay? initialTime;

  final ValueChanged<DateTime>? onDateChanged;
  final ValueChanged<TimeOfDay>? onTimeChanged;

  final VoidCallback? onConfirm;
  final String buttonLabel;
  final EdgeInsets padding;
  final bool showButton;

  @override
  State<FieldAgentSchedulePicker> createState() =>
      _FieldAgentSchedulePickerState();
}

class _FieldAgentSchedulePickerState extends State<FieldAgentSchedulePicker> {
  late final List<DateTime> _dates;
  late final List<TimeOfDay> _times;
  late DateTime _selectedDate;
  TimeOfDay? _selectedTime;

  @override
  void initState() {
    super.initState();
    _dates = widget.dates ?? _generateNextDays(7);
    _times = widget.timeSlots ?? _defaultTimes();
    _selectedDate = widget.initialDate ?? _dates.first;
    _selectedTime = widget.initialTime;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Dates row (horizontal list)
          SizedBox(
            height: 86,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: _dates.length,
              separatorBuilder: (_, __) => const SizedBox(width: 12),
              itemBuilder: (_, i) {
                final d = _dates[i];
                final selected = _isSameDay(d, _selectedDate);
                return _DateCard(
                  date: d,
                  selected: selected,
                  onTap: () {
                    setState(() => _selectedDate = d);
                    widget.onDateChanged?.call(d);
                  },
                );
              },
            ),
          ),

          const SizedBox(height: 16),
          // --- replace the Wrap(...) with this ---
          GridView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            // important inside Column
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _times.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3, // like the mock (3 per row)
              crossAxisSpacing: 14,
              mainAxisSpacing: 14,
              mainAxisExtent: 44, // chip height
            ),
            itemBuilder: (_, i) {
              final t = _times[i];
              final selected =
                  _selectedTime != null && _equalsTime(t, _selectedTime!);
              return _TimeChip(
                label: _formatTime(t),
                selected: selected,
                onTap: () {
                  setState(() => _selectedTime = t);
                  widget.onTimeChanged?.call(t);
                },
                fullWidth: true, // fill grid cell width
              );
            },
          ),

          if (widget.showButton) ...[
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 56,
              child: CustomButton(
                text: "Book Field Agent",
                onPressed: () {
                  // Get.to(() => ConfirmBookingFieldAgent());
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return ConfirmBookingFieldAgent();
                      },
                    ),
                  );
                },
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ],
      ),
    );
  }

  // Helpers
  static List<DateTime> _generateNextDays(int count) {
    final now = DateTime.now();
    return List.generate(
      count,
      (i) => DateTime(now.year, now.month, now.day).add(Duration(days: i)),
    );
  }

  static List<TimeOfDay> _defaultTimes() {
    return List.generate(8, (i) => TimeOfDay(hour: 10 + i, minute: 0)); // 10–17
  }

  static bool _isSameDay(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;

  static bool _equalsTime(TimeOfDay a, TimeOfDay b) =>
      a.hour == b.hour && a.minute == b.minute;

  String _formatTime(TimeOfDay t) {
    final now = DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, t.hour, t.minute);
    // Use dot between hour/minute to match your mock: 12.00 PM
    return DateFormat('hh.mm a').format(dt).toUpperCase();
  }
}

/// DATE PILL
class _DateCard extends StatelessWidget {
  const _DateCard({
    required this.date,
    required this.selected,
    required this.onTap,
  });

  final DateTime date;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final dow = DateFormat('EEE').format(date); // Mon
    final day = DateFormat('d').format(date); // 19
    final mon = DateFormat('MMMM').format(date); // July

    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: onTap,
      child: Container(
        width: 82,
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: selected ? AppColors.green : AppColors.grey,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: selected ? AppColors.green : AppColors.greyBorder,
            width: 1,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              dow,
              style: TextStyle(
                fontSize: tertiary(),
                fontWeight: FontWeight.w600,
                color: selected ? Colors.white : Colors.black87,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              day,
              style: TextStyle(
                fontSize: primary(), // a bit bigger
                fontWeight: FontWeight.w700,
                color: selected ? Colors.white : Colors.black87,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              mon,
              style: TextStyle(
                fontSize: small(),
                color: selected ? Colors.white : Colors.black54,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// TIME CHIP
class _TimeChip extends StatelessWidget {
  const _TimeChip({
    required this.label,
    required this.selected,
    required this.onTap,
    this.fullWidth = false,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;
  final bool fullWidth;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: onTap,
      child: Container(
        width: fullWidth ? double.infinity : 110,
        height: fullWidth ? double.infinity : 44,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: selected ? AppColors.green : AppColors.grey,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: selected ? AppColors.green : AppColors.greyBorder,
            width: 1,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: tertiary(),
            fontWeight: FontWeight.w600,
            color: selected ? Colors.white : Colors.black87,
          ),
        ),
      ),
    );
  }
}
