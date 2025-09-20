import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:khetihar/Components/CustomAppBar.dart';

import 'package:flutter/material.dart';
import 'package:khetihar/Components/CustomButton.dart';
import 'package:khetihar/MarketUpdates/market_price_tile.dart';
import '../../Theme/AppColors.dart';
import '../../Theme/FontSize.dart';

class ViewMarket extends StatelessWidget {
  const ViewMarket({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: KCenteredActionsAppBar(title: 'Market Analysis'),
      backgroundColor: Colors.white,
      body: Container(
        //padding: EdgeInsetsGeometry.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          children: [
            SizedBox(height: 20),
            MarketFiltersExact(
              onSearch: (state, district, product) {
                // do your search here
              },
            ),
          ],
        ),
      ),
    );
  }
}

/// ------------------ Small atoms ------------------

class _FieldLabel extends StatelessWidget {
  const _FieldLabel(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: secondary(), // 14
        fontWeight: FontWeight.w600,
        color: Colors.black.withOpacity(0.90),
        height: 1.2,
      ),
    );
  }
}

/// Rounded, grey, dropdown-looking field (matches the mock)
class KDropdownFieldExact extends StatelessWidget {
  const KDropdownFieldExact({
    super.key,
    required this.hint,
    required this.items,
    this.value,
    this.onChanged,
  });

  final String hint;
  final List<String> items;
  final String? value;
  final ValueChanged<String?>? onChanged;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      //padding: EdgeInsetsGeometry.symmetric(horizontal: 12),
      value: value,
      onChanged: onChanged,
      icon: const Icon(
        Icons.keyboard_arrow_down_rounded,
        size: 22,
        color: Colors.black54,
      ),
      style: TextStyle(
        fontSize: secondary(),
        color: Colors.black87,
        height: 1.25,
      ),
      decoration: InputDecoration(
        isDense: true,
        filled: true,
        fillColor: AppColors.grey,
        // #F7F8F9
        hintText: hint,
        hintStyle: TextStyle(
          fontSize: secondary(),
          color: Colors.black.withOpacity(0.55),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.greyBorder, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.greyBorder, width: 1.2),
        ),
      ),
      items:
          items
              .map((e) => DropdownMenuItem<String>(value: e, child: Text(e)))
              .toList(),
    );
  }
}

/// Green full-width pill button
class KPillButton extends StatelessWidget {
  const KPillButton({super.key, required this.label, required this.onPressed});

  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 46,
      width: double.infinity,
      child: CustomButton(
        text: "Search Result",
        onPressed: onPressed,
        foregroundColor: Colors.white,
      ),
    );
  }
}

/// ------------------ Composed widget (ready to use) ------------------

class MarketFiltersExact extends StatefulWidget {
  const MarketFiltersExact({
    super.key,
    this.onSearch,
    this.states = const ['Bihar', 'Delhi', 'Karnataka'],
    this.districts = const ['Patna', 'Nalanda', 'Gaya'],
    this.products = const ['Wheat', 'Turmeric', 'Tomato'],
  });

  final void Function(String? state, String? district, String? product)?
  onSearch;
  final List<String> states;
  final List<String> districts;
  final List<String> products;

  @override
  State<MarketFiltersExact> createState() => _MarketFiltersExactState();
}

class _MarketFiltersExactState extends State<MarketFiltersExact> {
  String? _state, _district, _product;

  @override
  Widget build(BuildContext context) {
    // fixed text scale for pixel match
    final mq = MediaQuery.of(context).copyWith(textScaleFactor: 1.0);

    return MediaQuery(
      data: mq,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Select State
          const _FieldLabel('Select State'),
          const SizedBox(height: 8),
          KDropdownFieldExact(
            hint: 'Select State',
            items: widget.states,
            value: _state,
            onChanged: (v) => setState(() => _state = v),
          ),

          const SizedBox(height: 16),

          // Select District
          const _FieldLabel('Select District'),
          const SizedBox(height: 8),
          KDropdownFieldExact(
            hint: 'Select District',
            items: widget.districts,
            value: _district,
            onChanged: (v) => setState(() => _district = v),
          ),

          const SizedBox(height: 16),

          // Select Product
          const _FieldLabel('Select Product'),
          const SizedBox(height: 8),
          KDropdownFieldExact(
            hint: 'Select Product',
            items: widget.products,
            value: _product,
            onChanged: (v) => setState(() => _product = v),
          ),

          const SizedBox(height: 18),

          KPillButton(
            label: 'Search Result',
            onPressed: () {
              Get.to(() => MarketPriceTile());
            },
          ),
        ],
      ),
    );
  }
}
