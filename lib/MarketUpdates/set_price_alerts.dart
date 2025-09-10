import 'package:flutter/material.dart';
import 'package:khetihar/Components/CustomAppBar.dart';
import 'package:khetihar/Components/CustomButton.dart';

import '../Theme/AppColors.dart';
import 'input_fields.dart';
import 'market_list.dart';

class SetPriceAlerts extends StatelessWidget {
  const SetPriceAlerts({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: KCenteredActionsAppBar(title: "Set Price Alerts"),
      backgroundColor: Colors.white,
      body: Container(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(8, 16, 8, 16),
          children: [
            SelectCropGridExact(
              items: const [
                CropItem(
                  label: 'Tomato',
                  circleColor: Color(0xFFFF6B5A),
                  icon: Icons.local_florist,
                ),
                CropItem(
                  label: 'Potato',
                  circleColor: Color(0xFFF3D9AA),
                  icon: Icons.cookie_outlined,
                ),
                CropItem(
                  label: 'Onion',
                  circleColor: Color(0xFFD36B85),
                  icon: Icons.water_drop_outlined,
                ),
                CropItem(
                  label: 'Wheat',
                  circleColor: Color(0xFFF3E5C8),
                  icon: Icons.grass,
                ),
                CropItem(
                  label: 'Carrot',
                  circleColor: Color(0xFFFF8748),
                  icon: Icons.emoji_food_beverage,
                ),
                CropItem(
                  label: 'Corn',
                  circleColor: Color(0xFFF6D977),
                  icon: Icons.agriculture,
                ),
              ],
              initialIndex: 0,
              onChanged: (i) {
                // handle selection index i
              },
            ),
            SizedBox(height: 10),
            Container(
              padding: EdgeInsets.symmetric(vertical: 14, horizontal: 12),
              child: PriceConditionSelectorExact(
                value: PriceCondition.fallsBelow,
                onChanged: (v) {
                  // handle selection change
                },
              ),
            ),
            SizedBox(height: 10),
            Container(
              padding: EdgeInsets.symmetric(vertical: 14, horizontal: 12),
              child: PriceAndAreaInputsExact(
                areas: const ['Select Area', 'New Delhi', 'Mumbai', 'Jaipur'],
                area: 'Select Area',
                priceController: TextEditingController(),
                onAreaChanged: (v) {},
                onPriceChanged: (v) {},
              ),
            ),
            SizedBox(height: 10),
            Container(
              padding: EdgeInsets.symmetric(vertical: 14, horizontal: 12),
              child: MarketRadioListExact(
                title: 'Select Markets From Your Preferred Area',
                options: const [
                  'Bihar Market',
                  'Punaichak Sabji Mandi',
                  'Mithapur Sabzi Mandi',
                  'Jakkanpur Gardanibagh',
                ],
                initialIndex: 0,
                onChanged: (i) {
                  /* handle selected index */
                },
              ),
            ),

            SizedBox(height: 10),
            Container(
              padding: EdgeInsets.symmetric(vertical: 14, horizontal: 12),
              child: NotificationPreferencesExact(),
            ),
          ],
        ),
      ),
    );
  }
}

/// One crop entry
class CropItem {
  const CropItem({
    required this.label,
    required this.circleColor,
    this.icon,
    this.asset, // if you prefer assets, pass a 24×24 white icon
  });

  final String label;
  final Color circleColor;
  final IconData? icon;
  final String? asset;
}

/// The whole section (“Select Crop” + grid)
class SelectCropGridExact extends StatefulWidget {
  const SelectCropGridExact({
    super.key,
    required this.items,
    this.title = 'Select Crop',
    this.initialIndex = 0,
    this.onChanged,
  });

  final String title;
  final List<CropItem> items;
  final int initialIndex;
  final ValueChanged<int>? onChanged;

  @override
  State<SelectCropGridExact> createState() => _SelectCropGridExactState();
}

class _SelectCropGridExactState extends State<SelectCropGridExact> {
  late int _index = widget.initialIndex;

  @override
  Widget build(BuildContext context) {
    // lock scaling for pixel parity
    final mq = MediaQuery.of(context).copyWith(textScaleFactor: 1.1);

    return MediaQuery(
      data: mq,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20),
          // Title
          Padding(
            padding: const EdgeInsets.only(left: 8, bottom: 8),
            child: Text(
              widget.title,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w600,
                height: 1.2,
              ),
            ),
          ),
          SizedBox(height: 10),
          // 3×N grid (non-scrollable, matches mock spacing)
          GridView.builder(
            itemCount: widget.items.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 8),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 14,
              mainAxisSpacing: 14,
              childAspectRatio: 0.9, // tight card like mock
            ),
            itemBuilder: (context, i) {
              final it = widget.items[i];
              final selected = i == _index;
              return _CropCard(
                item: it,
                selected: selected,
                onTap: () {
                  setState(() => _index = i);
                  widget.onChanged?.call(i);
                },
              );
            },
          ),
        ],
      ),
    );
  }
}

/// Single card (rounded, subtle shadow, selected outline)
class _CropCard extends StatelessWidget {
  const _CropCard({
    required this.item,
    required this.selected,
    required this.onTap,
  });

  final CropItem item;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          curve: Curves.easeOut,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: selected ? AppColors.green : AppColors.greyBorder,
              width: selected ? 2 : 1,
            ),
            boxShadow: const [
              BoxShadow(
                offset: Offset(0, 2),
                blurRadius: 8,
                color: AppColors.grey,
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Circle icon
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  color: item.circleColor,
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child:
                    item.asset != null
                        ? Image.asset(
                          item.asset!,
                          width: 24,
                          height: 24,
                          color: Colors.white,
                        )
                        : Icon(
                          item.icon ?? Icons.eco_outlined,
                          size: 24,
                          color: Colors.white,
                        ),
              ),
              const SizedBox(height: 10),

              // Label
              Text(
                item.label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: AppColors.darkGreen,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  height: 1.2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Tiny enum for selected value
enum PriceCondition { fallsBelow, fallsAbove }

/// Colors tuned to the mock
class _Ui {
  static const green = AppColors.darkGreen; // radio + accent
  static const label = Color(0xFF2F2F2F); // dark text
  static const hint = Color(0x99000000); // 60% black
  static const ring = Color(0xFFBFC7CF); // idle ring (light grey)
}

/// Drop-in section
class PriceConditionSelectorExact extends StatefulWidget {
  const PriceConditionSelectorExact({
    super.key,
    this.title = 'Price Condition',
    this.value = PriceCondition.fallsBelow,
    this.onChanged,
  });

  final String title;
  final PriceCondition value;
  final ValueChanged<PriceCondition>? onChanged;

  @override
  State<PriceConditionSelectorExact> createState() =>
      _PriceConditionSelectorExactState();
}

class _PriceConditionSelectorExactState
    extends State<PriceConditionSelectorExact> {
  late PriceCondition _value = widget.value;

  void _set(PriceCondition v) {
    if (_value == v) return;
    setState(() => _value = v);
    widget.onChanged?.call(v);
  }

  @override
  Widget build(BuildContext context) {
    // lock text scale to match pixels
    final mq = MediaQuery.of(context).copyWith(textScaleFactor: 1.18);

    return MediaQuery(
      data: mq,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          const SizedBox(height: 2),
          Text(
            widget.title,
            style: const TextStyle(
              color: _Ui.label,
              fontSize: 14,
              fontWeight: FontWeight.w600,
              height: 1.2,
              letterSpacing: 0.2,
            ),
          ),
          const SizedBox(height: 8),

          // Option 1
          _RadioRowExact(
            selected: _value == PriceCondition.fallsBelow,
            label: 'Alert when price falls below',
            onTap: () => _set(PriceCondition.fallsBelow),
          ),
          const SizedBox(height: 6),

          // Option 2
          _RadioRowExact(
            selected: _value == PriceCondition.fallsAbove,
            label: 'Alert when price falls Above',
            onTap: () => _set(PriceCondition.fallsAbove),
          ),
        ],
      ),
    );
  }
}

/// Single radio row with custom dot
class _RadioRowExact extends StatelessWidget {
  const _RadioRowExact({
    required this.selected,
    required this.label,
    required this.onTap,
  });

  final bool selected;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(6),
      child: Padding(
        // breathing space that matches the mock
        padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 4),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _RadioDot(selected: selected),
            const SizedBox(width: 10),
            Flexible(
              child: Text(
                label,
                style: const TextStyle(
                  color: _Ui.label,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  height: 1.35,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// The small ring + inner filled circle
class _RadioDot extends StatelessWidget {
  const _RadioDot({required this.selected});

  final bool selected;

  @override
  Widget build(BuildContext context) {
    // exact sizes to match the screenshot
    const double outer = 20; // ring diameter
    const double stroke = 1.8; // ring width
    const double inner = 10; // filled dot diameter when selected

    return SizedBox(
      width: outer,
      height: outer,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // ring
          Container(
            width: outer,
            height: outer,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              border: Border.all(
                color: selected ? _Ui.green : _Ui.ring,
                width: stroke,
              ),
            ),
          ),
          // inner filled circle
          if (selected)
            Container(
              width: inner,
              height: inner,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: _Ui.green,
              ),
            ),
        ],
      ),
    );
  }
}

class NotificationPreferencesExact extends StatefulWidget {
  const NotificationPreferencesExact({
    super.key,
    this.title = 'Notification Preferences',
    this.pushEnabled = true,
    this.smsEnabled = false,
    this.emailEnabled = false,
    this.onPushChanged,
    this.onSmsChanged,
    this.onEmailChanged,
    this.onCreateAlert,
  });

  final String title;
  final bool pushEnabled;
  final bool smsEnabled;
  final bool emailEnabled;
  final ValueChanged<bool>? onPushChanged;
  final ValueChanged<bool>? onSmsChanged;
  final ValueChanged<bool>? onEmailChanged;
  final VoidCallback? onCreateAlert;

  @override
  State<NotificationPreferencesExact> createState() =>
      _NotificationPreferencesExactState();
}

class _NotificationPreferencesExactState
    extends State<NotificationPreferencesExact> {
  static const _green = Color(0xFF55761D);
  static const _greyText = Color(0x99000000); // 60% black
  static const _border = Color(0xFFE8EDF4);
  static const _trackOff = Color(0xFFE9ECF3);

  late bool _push = widget.pushEnabled;
  late bool _sms = widget.smsEnabled;
  late bool _email = widget.emailEnabled;

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).copyWith(textScaleFactor: 1.0);
    return MediaQuery(
      data: mq,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 2),
          const Text(
            'Notification Preferences',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Color(0xFF222222),
              height: 1.2,
            ),
          ),
          const SizedBox(height: 10),

          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: _border, width: 1),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.04),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            padding: const EdgeInsets.fromLTRB(14, 12, 12, 12),
            child: Column(
              children: [
                _ToggleRow(
                  title: 'Push Notifications',
                  subtitle: 'Receive alerts on your device',
                  value: _push,
                  onChanged: (v) {
                    setState(() => _push = v);
                    widget.onPushChanged?.call(v);
                  },
                ),
                const SizedBox(height: 12),
                _ToggleRow(
                  title: 'SMS Alerts',
                  subtitle: 'Receive text messages',
                  value: _sms,
                  onChanged: (v) {
                    setState(() => _sms = v);
                    widget.onSmsChanged?.call(v);
                  },
                ),
                const SizedBox(height: 12),
                _ToggleRow(
                  title: 'Email Alerts',
                  subtitle: 'Receive email notifications',
                  value: _email,
                  onChanged: (v) {
                    setState(() => _email = v);
                    widget.onEmailChanged?.call(v);
                  },
                ),
              ],
            ),
          ),

          const SizedBox(height: 14),
          SizedBox(
            width: double.infinity,
            height: 44,
            child: CustomButton(
              text: "Create Alert",
              onPressed: () {},
              foregroundColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

class _ToggleRow extends StatelessWidget {
  const _ToggleRow({
    required this.title,
    required this.subtitle,
    required this.value,
    required this.onChanged,
  });

  static const _green = AppColors.darkGreen;
  static const _greyText = Color(0x99000000);
  static const _trackOff = Color(0xFFE9ECF3);

  final String title;
  final String subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    final switchWidget = Transform.scale(
      scale: 0.95, // compact like the mock
      child: Switch(
        value: value,
        onChanged: onChanged,
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        splashRadius: 0,
        trackOutlineColor: MaterialStateProperty.all(Colors.transparent),
        trackColor: MaterialStateProperty.resolveWith(
          (states) =>
              states.contains(MaterialState.selected) ? _green : _trackOff,
        ),
        thumbColor: MaterialStateProperty.all(Colors.white),
      ),
    );

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 2),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF222222),
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 13,
                    color: _greyText,
                    height: 1.25,
                  ),
                ),
              ],
            ),
          ),
        ),
        switchWidget,
      ],
    );
  }
}
