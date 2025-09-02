import 'package:flutter/material.dart';
import 'package:khetihar/Theme/AppColors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.grey,
      elevation: 0,
      automaticallyImplyLeading: false,
      titleSpacing: 0,
      title: Padding(
        padding: const EdgeInsets.only(left: 12),
        child: CircleAvatar(
          radius: 22,
          backgroundColor: Colors.white,
          backgroundImage: const AssetImage('Assets/HomeScreens/Logo.png'),
        ),
      ),
      actions: [
        _circleIconButton(
          icon: Icons.notifications_outlined,
          onTap: () {
            debugPrint("Notification clicked");
          },
        ),
        const SizedBox(width: 8),
        _circleIconButton(
          icon: Icons.shopping_cart_outlined,
          onTap: () {
            debugPrint("Cart clicked");
          },
        ),
        const SizedBox(width: 8),
        GestureDetector(
          onTap: () {
            debugPrint("Profile clicked");
          },
          child: const CircleAvatar(
            radius: 20,
            backgroundImage: AssetImage('Assets/HomeScreens/profile.png'),
          ),
        ),
        const SizedBox(width: 12),
      ],
    );
  }

  Widget _circleIconButton({required IconData icon, VoidCallback? onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(22),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        width: 40,
        height: 40,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
        ),
        child: Icon(icon, color: AppColors.green, size: 22),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
