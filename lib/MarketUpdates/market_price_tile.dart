import 'package:flutter/material.dart';
import 'package:khetihar/Components/CustomAppBar.dart';
import '../../Theme/AppColors.dart';
import '../../Theme/FontSize.dart';

class MarketPriceTile extends StatelessWidget {
  const MarketPriceTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: KCenteredActionsAppBar(title: ""),
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 12),
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 8),
          children: const [
            MarketPriceTileExact(
              commodity: 'Apple',
              importDateText: 'June 31, 2025',
              locationText: 'Damnagar, Amreli (Gujarat)',
              minPriceText: 'INR 3,250',
              maxPriceText: 'INR 4,250',
              avgPriceText: 'INR 3,750',
            ),
            MarketPriceTileExact(
              commodity: 'Apple',
              importDateText: 'June 31, 2025',
              locationText: 'Damnagar, Amreli (Gujarat)',
              minPriceText: 'INR 3,250',
              maxPriceText: 'INR 4,250',
              avgPriceText: 'INR 3,750',
            ),
          ],
        ),
      ),
    );
  }
}

/// One price card (exact look from your screenshot)
class MarketPriceTileExact extends StatelessWidget {
  const MarketPriceTileExact({
    super.key,
    required this.commodity,
    required this.importDateText, // e.g. 'June 31, 2025'
    required this.locationText, // e.g. 'Damnagar, Amreli (Gujarat)'
    required this.minPriceText, // e.g. 'INR 3,250'
    required this.maxPriceText, // e.g. 'INR 4,250'
    required this.avgPriceText, // e.g. 'INR 3,750'
    this.pillLabel = 'Price per Quintal',
  });

  final String commodity;
  final String importDateText;
  final String locationText;
  final String minPriceText;
  final String maxPriceText;
  final String avgPriceText;
  final String pillLabel;

  @override
  Widget build(BuildContext context) {
    // lock scale for crisp match
    final mq = MediaQuery.of(context).copyWith(textScaleFactor: 1.1);

    return MediaQuery(
      data: mq,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
        padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.greyBorder, width: 1),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 6,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top: name + pill
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    commodity,
                    style: TextStyle(
                      fontSize: secondary(), // 16
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                      height: 1.2,
                    ),
                  ),
                ),
                _GreenPill(label: pillLabel),
              ],
            ),
            const SizedBox(height: 6),
            // Import date
            Text(
              'Import Date: $importDateText',
              style: TextStyle(
                fontSize: tertiary(), // 14
                color: Colors.black,
                height: 1.3,
              ),
            ),
            const SizedBox(height: 2),
            // Location
            Text(
              locationText,
              style: TextStyle(
                fontSize: tertiary(),
                color: Colors.black,
                height: 1.3,
              ),
            ),
            const SizedBox(height: 12),

            // Three columns: Minimum / Maximum / Average
            Row(
              children: const [
                Expanded(child: _PriceStat(label: 'Minimum Price')),
                Expanded(child: _PriceStat(label: 'Maximum Price')),
                Expanded(child: _PriceStat(label: 'Average Price')),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Expanded(child: _PriceValue(text: minPriceText)),
                Expanded(child: _PriceValue(text: maxPriceText)),
                Expanded(child: _PriceValue(text: avgPriceText)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// Small green right-top pill
class _GreenPill extends StatelessWidget {
  const _GreenPill({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: const ShapeDecoration(
        color: AppColors.green,
        shape: StadiumBorder(),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12.5,
          fontWeight: FontWeight.w600,
          height: 1.0,
        ),
      ),
    );
  }
}

/// Header above each price
class _PriceStat extends StatelessWidget {
  const _PriceStat({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      textAlign: TextAlign.start,
      style: TextStyle(
        fontSize: small() + 2, // ~12
        color: Colors.black.withOpacity(0.55),
        height: 1.2,
      ),
    );
  }
}

/// Bold value text below each header
class _PriceValue extends StatelessWidget {
  const _PriceValue({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 2),
      child: Text(
        text,
        textAlign: TextAlign.start,
        style: TextStyle(
          fontSize: tertiary(), // 14
          fontWeight: FontWeight.w700,
          color: Colors.black.withOpacity(0.95),
          height: 1.25,
        ),
      ),
    );
  }
}
