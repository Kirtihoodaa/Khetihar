import 'package:flutter/material.dart';
import 'package:khetihar/Theme/AppColors.dart';

class BottomPillNav extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  final List<BottomPillItem> items;

  const BottomPillNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        left: 20,
        right: 20,
        bottom: 24, // 🔥 this makes it float above bottom
      ),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: AppColors.green.withOpacity(0.18),
            blurRadius: 16,
            spreadRadius: -2,
            offset: const Offset(0, 6),
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(items.length, (i) {
          final selected = i == currentIndex;
          return InkResponse(
            onTap: () => onTap(i),
            radius: 26,
            highlightShape: BoxShape.circle,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: selected ? AppColors.green : Colors.transparent,
              ),
              alignment: Alignment.center,
              child: Icon(
                items[i].icon,
                size: 24,
                color: selected ? Colors.white : AppColors.green,
              ),
            ),
          );
        }),
      ),
    );
  }
}

class BottomPillItem {
  final IconData icon;
  const BottomPillItem({required this.icon});
}
