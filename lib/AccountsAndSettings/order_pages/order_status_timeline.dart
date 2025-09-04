import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../Theme/AppColors.dart';
import '../../Theme/FontSize.dart';

class OrderStatusTimeline extends StatelessWidget {
  const OrderStatusTimeline({
    super.key,
    required this.steps,
    this.title = 'Order Status',
    this.padding = const EdgeInsets.fromLTRB(16, 8, 16, 0),
  });

  final String title;
  final List<TimelineStep> steps;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    // lock text scale so pixels don’t drift
    final mq = MediaQuery.of(context).copyWith(textScaleFactor: 1.2);

    return MediaQuery(
      data: mq,
      child: Padding(
        padding: padding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: primary(), // 18
                fontWeight: FontWeight.w600,
                color: AppColors.green,
                height: 2.2,
              ),
            ),
            const SizedBox(height: 8),

            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: steps.length,
              itemBuilder: (context, i) {
                final s = steps[i];

                // rail logic to match the mock precisely
                final Color topColor = s.color; // current
                final Color bottomColor =
                    (i < steps.length - 1)
                        ? steps[i + 1].color
                        : s.color; // next (tail on last)

                return _TimelineItem(
                  title: s.title,
                  subtitle: s.formattedSubtitle ?? s.subtitle,
                  icon: s.icon,
                  topColor: topColor,
                  bottomColor: bottomColor,
                  dimSubtitle: s.dimSubtitle,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class TimelineStep {
  const TimelineStep({
    required this.title,
    required this.color,
    required this.icon,
    this.dateTime,
    this.subtitle,
    this.dimSubtitle = false,
  });

  final String title;
  final Color color;
  final IconData icon;
  final DateTime? dateTime;
  final String? subtitle;
  final bool dimSubtitle;

  String? get formattedSubtitle {
    if (subtitle != null) return subtitle;
    if (dateTime == null) return null;
    final d = DateFormat('MMMM dd, yyyy').format(dateTime!);
    final t = DateFormat('h:mm a').format(dateTime!);
    return '$d • $t';
  }
}

class _TimelineItem extends StatelessWidget {
  const _TimelineItem({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.topColor,
    required this.bottomColor,
    required this.dimSubtitle,
  });

  final String title;
  final String? subtitle;
  final IconData icon;
  final Color topColor; // above badge (current step)
  final Color bottomColor; // below badge (next step) — last = current for tail
  final bool dimSubtitle;

  // tuned to the screenshot
  static const double _badge = 26; // 26dp circle
  static const double _rail = 3; // thicker rail

  @override
  Widget build(BuildContext context) {
    final subColor =
        dimSubtitle
            ? Colors.black.withOpacity(0.50)
            : Colors.black.withOpacity(0.70);

    return Padding(
      padding: const EdgeInsets.only(bottom: 22), // row gap in mock
      child: IntrinsicHeight(
        // keeps rail centered & sized
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // ---- left rail ----
            SizedBox(
              width: 40, // rail column width
              child: Column(
                children: [
                  Expanded(
                    child: Align(
                      alignment: Alignment.center,
                      child: Container(width: _rail, color: topColor),
                    ),
                  ),
                  // badge (filled, tiny white border like the mock)
                  Container(
                    width: _badge,
                    height: _badge,
                    decoration: BoxDecoration(
                      color: topColor,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.04),
                          blurRadius: 1,
                          offset: const Offset(0, 0),
                        ),
                      ],
                    ),
                    alignment: Alignment.center,
                    child: Icon(icon, size: 15, color: Colors.white),
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.center,
                      child: Container(width: _rail, color: bottomColor),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(width: 12),

            // ---- right content ----
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: secondary(), // 16
                      fontWeight: FontWeight.w700, // bold
                      color: Colors.black87,
                      height: 1.2,
                    ),
                  ),
                  if (subtitle != null) ...[
                    const SizedBox(height: 6),
                    Text(
                      subtitle!,
                      style: TextStyle(
                        fontSize: tertiary(), // 14
                        color: subColor,
                        height: 2.25,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
