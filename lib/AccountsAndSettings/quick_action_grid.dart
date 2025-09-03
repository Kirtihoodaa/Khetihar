import 'dart:ffi';

import 'package:flutter/material.dart';

import '../Theme/AppColors.dart';
import '../Theme/FontSize.dart';
import 'package:flutter/material.dart';
// assumes AppColors + font helpers: secondary() => 16, tertiary() => 14

class QuickActionsGrid extends StatelessWidget {
  const QuickActionsGrid({
    super.key,
    required this.items,
    this.crossAxisCount = 2,
  });

  final List<QuickActionItem> items;
  final int crossAxisCount;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: items.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12, // matches visual gap in mock
        mainAxisSpacing: 16,
        mainAxisExtent: 54, // tile height in mock
      ),
      itemBuilder: (context, i) {
        final it = items[i];
        return _OutlineTileExact(
          label: it.label,
          icon: it.icon,
          onTap: it.onTap,
        );
      },
    );
  }
}

class QuickActionItem {
  const QuickActionItem({required this.label, required this.icon, this.onTap});

  final String label;
  final Widget icon; // pass Icon or SvgPicture for exact glyphs
  final VoidCallback? onTap;
}

// Single tile tuned to screenshot (radius 12, border #E8ECF4, paddings)
class _OutlineTileExact extends StatelessWidget {
  const _OutlineTileExact({
    required this.label,
    required this.icon,
    this.onTap,
  });

  final String label;
  final Widget icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(
          color: AppColors.greyBorder,
          width: 1,
        ), // #E8ECF4
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          // left/right inset
          child: Row(
            children: [
              SizedBox(
                width: 22,
                height: 22, // icon box ~22px
                child: Center(child: icon),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: primary(), // 16 to match mock
                    fontWeight: FontWeight.w600, // semi-bold
                    color: Colors.black87,
                    height: 1.1,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AccountSettingsSection extends StatelessWidget {
  const AccountSettingsSection({
    super.key,
    this.title = 'Account Settings',
    required this.items,
  });

  final String title;
  final List<SettingsItem> items;

  @override
  Widget build(BuildContext context) {
    // lock text scaling so rows don’t shift
    final mq = MediaQuery.of(context).copyWith(textScaleFactor: 1.0);
    return MediaQuery(
      data: mq,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Section title (green, 18, w600)
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 10),
            child: Text(
              title,
              style: TextStyle(
                fontSize: primary(), // 18
                fontWeight: FontWeight.w600, // semibold
                color: AppColors.green,
                height: 1.2,
              ),
            ),
          ),

          // Items list (non-scrollable so you can place in any screen)
          ListView.separated(
            padding: EdgeInsets.zero,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: items.length,
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            // vertical gap
            itemBuilder: (_, i) => _SettingsTileExact(item: items[i]),
          ),
        ],
      ),
    );
  }
}

class SettingsItem {
  const SettingsItem({required this.label, required this.iconData, this.onTap});

  final String label;
  final IconData iconData; // Flutter Material icon
  final VoidCallback? onTap;
}

class _SettingsTileExact extends StatelessWidget {
  const _SettingsTileExact({required this.item});

  final SettingsItem item;

  @override
  Widget build(BuildContext context) {
    return Padding(
      // horizontal insets match the mock
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: item.onTap,
        child: SizedBox(
          height: 50, // row height tuned to screenshot
          child: Row(
            children: [
              // Leading icon (green outline look via Material icons)
              SizedBox(
                width: 24,
                height: 24,
                child: Center(
                  child: Icon(
                    item.iconData,
                    size: 24, // icon size in mock
                    color: AppColors.green,
                  ),
                ),
              ),
              const SizedBox(width: 12),

              // Label
              Expanded(
                child: Text(
                  item.label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: secondary(), // 16
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                    height: 1.2,
                  ),
                ),
              ),

              // Chevron
              Icon(
                Icons.chevron_right,
                size: 24,
                color: Colors.black.withOpacity(0.55),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
