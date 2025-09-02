import 'package:flutter/material.dart';
import 'package:khetihar/Theme/AppColors.dart';

class Secondaryappbar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback? onBack;
  final VoidCallback? onCart;
  final VoidCallback? onAvatarTap;

  const Secondaryappbar({
    super.key,
    this.onBack,
    this.onCart,
    this.onAvatarTap,
  });

  @override
  Size get preferredSize => const Size.fromHeight(64);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.secondarygrey,
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          child: Row(
            children: [
              // Back button
              _PillIconButton(
                icon: Icons.chevron_left_rounded,
                onTap: onBack ?? () => Navigator.of(context).maybePop(),
              ),

              const Spacer(),

              // Cart with count badge
              Stack(
                clipBehavior: Clip.none,
                children: [
                  _PillIconButton(
                    icon: Icons.shopping_cart_outlined,
                    onTap: onCart,
                  ),
                  Positioned(right: -2, top: -2, child: _CartBadge(count: 2)),
                ],
              ),
              const SizedBox(width: 12),

              // Avatar
              CircleAvatar(
                radius: 22,
                backgroundColor: Colors.white,
                backgroundImage: const AssetImage(
                  'Assets/HomeScreens/profile.png',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PillIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onTap;

  const _PillIconButton({required this.icon, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      shape: const CircleBorder(),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(shape: BoxShape.circle),
          alignment: Alignment.center,
          child: Icon(icon, size: 25, color: AppColors.green),
        ),
      ),
    );
  }
}

class _CartBadge extends StatelessWidget {
  final int count;
  const _CartBadge({required this.count});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 16,
      padding: EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        color: AppColors.green,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white, width: 2),
      ),
      alignment: Alignment.center,
      child: Text(
        count > 99 ? '99+' : '$count',
        style: const TextStyle(
          color: Colors.white,
          fontSize: 10,
          fontWeight: FontWeight.w600,
          height: 1.0,
        ),
      ),
    );
  }
}
