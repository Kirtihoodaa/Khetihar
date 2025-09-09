import 'package:flutter/material.dart';
import '../../Theme/AppColors.dart';
import '../../Theme/FontSize.dart';

/// Wrap this where you need it.
/// - [areas] is your dropdown list
/// - [area] is the currently selected value
class PriceAndAreaInputsExact extends StatelessWidget {
  const PriceAndAreaInputsExact({
    super.key,
    required this.areas,
    this.area,
    this.onAreaChanged,
    this.priceController,
    this.onPriceChanged,
  });

  final List<String> areas;
  final String? area;
  final ValueChanged<String?>? onAreaChanged;
  final TextEditingController? priceController;
  final ValueChanged<String>? onPriceChanged;

  @override
  Widget build(BuildContext context) {
    // lock text scale for pixel-parity with the mock
    final mq = MediaQuery.of(context).copyWith(textScaleFactor: 1.15);

    return MediaQuery(
      data: mq,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SectionLabel('Enter The Price'),
          const SizedBox(height: 8),
          _PriceBox(controller: priceController, onChanged: onPriceChanged),

          const SizedBox(height: 28),

          _SectionLabel('Select The Area'),
          const SizedBox(height: 8),
          _AreaDropdown(items: areas, value: area, onChanged: onAreaChanged),
        ],
      ),
    );
  }
}

/// ---------- small pieces (easy to reuse anywhere) ----------

class _SectionLabel extends StatelessWidget {
  const _SectionLabel(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: tertiary(), // ~14
        fontWeight: FontWeight.w600,
        color: const Color(0xFF222222),
        height: 1.2,
      ),
    );
  }
}

class _PriceBox extends StatelessWidget {
  const _PriceBox({this.controller, this.onChanged});

  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      onChanged: onChanged,
      style: TextStyle(
        fontSize: tertiary(),
        color: Colors.black87,
        height: 1.25,
      ),
      decoration: InputDecoration(
        hintText: 'Enter Price',
        hintStyle: TextStyle(
          fontSize: tertiary(),
          color: Colors.black.withOpacity(0.45),
        ),
        isDense: true,
        filled: true,
        fillColor: const Color(0xFFF6F8FA),
        // soft grey like the mock
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 18,
        ),
        suffixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
        suffixIcon: Padding(
          padding: const EdgeInsets.only(right: 14),
          child: Text(
            '/kg',
            style: TextStyle(
              fontSize: tertiary(),
              color: Colors.black.withOpacity(0.70),
            ),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.greyBorder, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.green, width: 1.4),
        ),
      ),
      cursorColor: AppColors.green,
    );
  }
}

class _AreaDropdown extends StatelessWidget {
  const _AreaDropdown({required this.items, this.value, this.onChanged});

  final List<String> items;
  final String? value;
  final ValueChanged<String?>? onChanged;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: value,
      isExpanded: true,
      icon: const Icon(
        Icons.keyboard_arrow_down_rounded,
        size: 20,
        color: Colors.black45,
      ),
      decoration: InputDecoration(
        isDense: true,
        filled: true,
        fillColor: const Color(0xFFF6F8FA),
        hintText: 'Select Area',
        hintStyle: TextStyle(
          fontSize: tertiary(),
          color: Colors.black.withOpacity(0.45),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.greyBorder, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.green, width: 1.4),
        ),
      ),
      items:
          items
              .map(
                (e) => DropdownMenuItem<String>(
                  value: e,
                  child: Text(
                    e,
                    style: TextStyle(
                      fontSize: tertiary(),
                      color: Colors.black87,
                    ),
                  ),
                ),
              )
              .toList(),
      onChanged: onChanged,
      style: TextStyle(fontSize: tertiary(), color: Colors.black87),
      dropdownColor: Colors.white,
    );
  }
}
