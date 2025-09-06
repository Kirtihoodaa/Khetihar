import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:khetihar/AccountsAndSettings/internal_pagez/my_orders.dart';
import 'package:khetihar/AccountsAndSettings/quick_action_grid.dart';
import 'package:khetihar/Components/CustomButton.dart';

import '../Theme/AppColors.dart';
import '../Theme/FontSize.dart';

class Accounts extends StatelessWidget {
  const Accounts({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: KAppBar(title: "Account"),
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 5),
        child: SingleChildScrollView(
          child: Column(
            children: [
              ProfileSummaryCardExact(
                name: "Alex Thomson",
                subscriptionText: "Subscription: Free",
                imageProvider: NetworkImage(
                  'https://images.unsplash.com/photo-1607746882042-944635dfe10e?w=400',
                ),
              ),
              SizedBox(height: 10),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                child: QuickActionsGrid(
                  items: [
                    QuickActionItem(
                      onTap: () {
                        Get.to(() => MyOrders());
                      },
                      label: 'Orders',
                      icon: const Icon(
                        Icons.inventory_2_outlined,
                        size: 22,
                        color: AppColors.green,
                      ),
                    ),
                    QuickActionItem(
                      label: 'Wishlist',
                      icon: const Icon(
                        Icons.favorite_border_rounded,
                        size: 22,
                        color: AppColors.green,
                      ),
                    ),
                    QuickActionItem(
                      label: 'Subscription',
                      icon: const Icon(
                        Icons.confirmation_number_outlined,
                        size: 22,
                        color: AppColors.green,
                      ),
                    ),
                    QuickActionItem(
                      label: 'Rental',
                      icon: const Icon(
                        Icons.directions_car_outlined,
                        size: 22,
                        color: AppColors.green,
                      ),
                    ),
                    QuickActionItem(
                      label: 'Loan Request',
                      icon: const Icon(
                        Icons.description_outlined,
                        size: 22,
                        color: AppColors.green,
                      ),
                    ),
                    QuickActionItem(
                      label: 'Bookings',
                      icon: const Icon(
                        Icons.water_drop_outlined,
                        size: 22,
                        color: AppColors.green,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: AccountSettingsSection(
                  items: const [
                    SettingsItem(
                      label: 'Edit Profile',
                      iconData: Icons.person_outline,
                    ),
                    SettingsItem(
                      label: 'Saved Addresses',
                      iconData: Icons.location_on_outlined,
                    ),
                    SettingsItem(
                      label: 'Language',
                      iconData: Icons.translate_rounded,
                    ),
                    SettingsItem(
                      label: 'Saved Cards',
                      iconData: Icons.credit_card_outlined,
                    ),
                    SettingsItem(
                      label: 'Change Password',
                      iconData: Icons.lock_reset_rounded,
                    ),
                    SettingsItem(
                      label: 'Notification Settings',
                      iconData: Icons.notifications_none_rounded,
                    ),
                    SettingsItem(
                      label: 'Help & Support',
                      iconData: Icons.headset_mic_outlined,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 14),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 46),
                child: SizedBox(
                  width: double.infinity,
                  child: CustomButton(
                    text: "Logout",
                    onPressed: () {},
                    foregroundColor: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: 14),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 46),
                child: SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () {},
                    child: Text(
                      "Delete Account",
                      style: TextStyle(color: AppColors.green),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 130),
            ],
          ),
        ),
      ),
    );
  }
}

class KAppBar extends StatelessWidget implements PreferredSizeWidget {
  const KAppBar({
    super.key,
    required this.title,
    this.showBack = false,
    this.onBack,
    this.height = 56,
  });

  final String title;
  final bool showBack;
  final VoidCallback? onBack;
  final double height;

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.secondarygrey,
      elevation: 0,
      scrolledUnderElevation: 0,
      automaticallyImplyLeading: false,
      toolbarHeight: height,
      titleSpacing: 35,
      leadingWidth: showBack ? 48 : 0,
      leading:
          showBack
              ? _CircleBack(
                onPressed: onBack ?? () => Navigator.maybePop(context),
              )
              : null,
      title: Text(
        title,
        style: TextStyle(
          fontSize: primary(), // 18
          fontWeight: FontWeight.w600, // semibold like the image
          color: AppColors.green,
          height: 1.2,
        ),
      ),
      // shape: const Border(
      //   bottom: BorderSide(color: AppColors.greyBorder, width: 1),
      // ),
    );
  }
}

class _CircleBack extends StatelessWidget {
  const _CircleBack({required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onPressed,
        child: Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.greyBorder, width: 1),
          ),
          alignment: Alignment.center,
          child: const Icon(
            Icons.arrow_back_ios_new_rounded,
            size: 16,
            color: AppColors.green,
          ),
        ),
      ),
    );
  }
}

/// Profile card tuned to the screenshot (radii, shadow, paddings, avatar ring).
class ProfileSummaryCardExact extends StatelessWidget {
  const ProfileSummaryCardExact({
    super.key,
    required this.name,
    required this.subscriptionText, // 'Subscription : Free'
    required this.imageProvider,
  });

  final String name;
  final String subscriptionText;
  final ImageProvider imageProvider;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 12, 16, 0),
      padding: const EdgeInsets.fromLTRB(16, 14, 14, 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.greyBorder, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05), // very soft
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Texts (left)
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Name in green, 16, semibold
                Text(
                  name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: secondary(), // 16
                    fontWeight: FontWeight.w600,
                    color: AppColors.green,
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 6), // tighter like the mock
                Text(
                  subscriptionText,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: tertiary(), // 14
                    color: Colors.black.withOpacity(0.70),
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),

          // Avatar (right) with double ring feel
          _AvatarRing(image: imageProvider, size: 70),
        ],
      ),
    );
  }
}

class _AvatarRing extends StatelessWidget {
  const _AvatarRing({required this.image, this.size = 56});

  final ImageProvider image;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: const BoxDecoration(shape: BoxShape.circle),
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Outer thin grey ring
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.greyBorder, width: 1),
            ),
          ),
          // Inner white ring + image
          Padding(
            padding: const EdgeInsets.all(2), // creates subtle white ring
            child: ClipOval(child: Image(image: image, fit: BoxFit.cover)),
          ),
        ],
      ),
    );
  }
}
