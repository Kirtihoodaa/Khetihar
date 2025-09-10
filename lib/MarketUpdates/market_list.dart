import 'package:flutter/material.dart';
import '../../Theme/AppColors.dart';
import '../../Theme/FontSize.dart';

/// Public widget
class MarketRadioListExact extends StatefulWidget {
  const MarketRadioListExact({
    super.key,
    required this.title,
    required this.options,
    this.initialIndex = 0,
    this.onChanged,
  });

  final String title;
  final List<String> options;
  final int initialIndex;
  final ValueChanged<int>? onChanged;

  @override
  State<MarketRadioListExact> createState() => _MarketRadioListExactState();
}

class _MarketRadioListExactState extends State<MarketRadioListExact> {
  late int _selected;

  @override
  void initState() {
    super.initState();
    _selected = widget.initialIndex.clamp(0, widget.options.length - 1);
  }

  @override
  Widget build(BuildContext context) {
    // lock text scale for 1:1 spacing with the mock
    final mq = MediaQuery.of(context).copyWith(textScaleFactor: 1.0);

    return MediaQuery(
      data: mq,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          Text(
            widget.title,
            style: TextStyle(
              fontSize: primary(), // ≈18
              fontWeight: FontWeight.w700, // bold
              color: Colors.black87,
              height: 1.25,
            ),
          ),
          const SizedBox(height: 12),

          // Options (simple Column to avoid ListView constraints)
          ...List.generate(widget.options.length, (i) {
            final selected = i == _selected;
            return Padding(
              padding: EdgeInsets.only(
                bottom: i == widget.options.length - 1 ? 0 : 14,
              ),
              child: _MarketRadioTileExact(
                label: widget.options[i],
                selected: selected,
                onTap: () {
                  setState(() => _selected = i);
                  widget.onChanged?.call(i);
                },
              ),
            );
          }),
        ],
      ),
    );
  }
}

/// One row that perfectly matches the screenshot
class _MarketRadioTileExact extends StatelessWidget {
  const _MarketRadioTileExact({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: Row(
        children: [
          // Custom radio (double ring look)
          SizedBox(
            width: 26,
            height: 26,
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Outer ring (thin dark border for unselected look)
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color:
                          selected
                              ? AppColors.darkGreen
                              : Colors.black.withOpacity(0.55),
                      width: 2,
                    ),
                  ),
                ),
                // Inner white to create the “double ring” gap in the selected state
                if (selected)
                  Container(
                    width: 16,
                    height: 16,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                  ),
                // Filled green dot for selected
                if (selected)
                  Container(
                    width: 10,
                    height: 10,
                    decoration: const BoxDecoration(
                      color: AppColors.darkGreen,
                      shape: BoxShape.circle,
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(width: 12),

          // Label
          Expanded(
            child: Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: secondary(), // ≈16
                fontWeight: FontWeight.w600, // semi-bold like the mock
                color: Colors.black.withOpacity(0.85),
                height: 1.25,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
