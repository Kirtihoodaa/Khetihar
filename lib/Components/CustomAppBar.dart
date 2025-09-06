import 'package:flutter/material.dart';
import 'package:khetihar/Theme/AppColors.dart';

import '../Theme/FontSize.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.secondarygrey,
      elevation: 0,
      automaticallyImplyLeading: false,
      titleSpacing: 0,
      title: Padding(
        padding: EdgeInsets.only(left: 12),
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

class KCenteredActionsAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const KCenteredActionsAppBar({
    super.key,
    required this.title,
    this.onBack,
    this.onBell,
    this.onAvatarTap,
    this.avatarImage,
    this.height = 56,
  });

  final String title;
  final VoidCallback? onBack;
  final VoidCallback? onBell;
  final VoidCallback? onAvatarTap;
  final ImageProvider? avatarImage;
  final double height;

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.secondarygrey,
      // light bar
      elevation: 0,
      scrolledUnderElevation: 0,
      automaticallyImplyLeading: false,
      toolbarHeight: height,
      // subtle bottom divider like your UI
      shape: const Border(
        bottom: BorderSide(color: AppColors.greyBorder, width: 1),
      ),
      // Build our centered layout inside the real AppBar & SafeArea
      flexibleSpace: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Center title (truly centered regardless of actions width)
              Text(
                title,
                style: TextStyle(
                  fontSize: primary(), // 18
                  fontWeight: FontWeight.w600, // semi-bold
                  color: AppColors.green,
                  height: 1.2,
                ),
              ),

              // Left circular back
              Align(
                alignment: Alignment.centerLeft,
                child: _CircleIconButton(
                  icon: Icons.arrow_back_ios_new_rounded,
                  onTap: onBack ?? () => Navigator.maybePop(context),
                ),
              ),

              // Right: bell + avatar
              Align(
                alignment: Alignment.centerRight,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _CircleIconButton(
                      icon: Icons.notifications_none_rounded,
                      onTap: onBell,
                    ),
                    const SizedBox(width: 10),
                    _AvatarCircle(image: avatarImage, onTap: onAvatarTap),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CircleIconButton extends StatelessWidget {
  const _CircleIconButton({required this.icon, this.onTap});

  final IconData icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      shape: const CircleBorder(),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.greyBorder, width: 1),
          ),
          alignment: Alignment.center,
          child: Icon(icon, size: 20, color: AppColors.green),
        ),
      ),
    );
  }
}

class _AvatarCircle extends StatelessWidget {
  const _AvatarCircle({this.image, this.onTap});

  final ImageProvider? image;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      shape: const CircleBorder(),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.greyBorder, width: 1),
          ),
          clipBehavior: Clip.antiAlias,
          child:
              image == null
                  ? const Icon(Icons.person, color: AppColors.green, size: 20)
                  : Image(image: image!, fit: BoxFit.cover),
        ),
      ),
    );
  }
}
