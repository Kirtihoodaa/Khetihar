import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khetihar/Components/CustomButton.dart';
import 'package:khetihar/Components/InputFields.dart';
import 'package:khetihar/HomePages/BuySeeds/Controller/CartController.dart';
import 'package:khetihar/Theme/AppColors.dart';
import 'package:khetihar/Theme/FontSize.dart';

class MyCartPage extends GetView<CartController> {
  MyCartPage({super.key});

  final TextEditingController _promo = TextEditingController();

  String _inr(num n) => "INR ${n.toStringAsFixed(0)}";

  @override
  Widget build(BuildContext context) {
    // ensure the controller exists
    Get.put(CartController(), permanent: true);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
          onPressed: () => Get.back(),
        ),
        centerTitle: true,
        title: Text(
          "My Cart",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: primary(),
            color: Colors.black,
          ),
        ),
      ),
      body: Obx(() {
        if (controller.items.isEmpty) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Text(
                "Your cart is empty",
                style: TextStyle(fontSize: secondary(), color: Colors.black54),
              ),
            ),
          );
        }

        return CustomScrollView(
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
              sliver: SliverList.builder(
                itemCount: controller.items.length,
                itemBuilder: (context, i) {
                  final item = controller.items[i];
                  final p = item.product;

                  return Card(
                    margin: const EdgeInsets.only(bottom: 16),
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Image
                        Container(
                          width: 108,
                          height: 108,
                          margin: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: AppColors.secondarygrey,
                            borderRadius: BorderRadius.circular(12),
                            image: DecorationImage(
                              image: AssetImage(p['image']),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),

                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 16, right: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        p['title'],
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: secondary(),
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () => controller.removeAt(i),
                                      icon: const Icon(Icons.delete),
                                      color: Colors.red,
                                    ),
                                  ],
                                ),
                                // Desc
                                Text(
                                  p['desc'],
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: Colors.black87,
                                    fontSize: tertiary(),
                                    height: 1.2,
                                  ),
                                ),
                                const SizedBox(height: 12),
                                // Price + Qty
                                Row(
                                  children: [
                                    Text(
                                      _inr(p['price']),
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: secondary(),
                                        color: AppColors.green,
                                      ),
                                    ),
                                    const Spacer(),
                                    _QtyControl(
                                      qty: item.qty,
                                      onMinus: () => controller.dec(i),
                                      onPlus: () => controller.inc(i),
                                    ),
                                    const SizedBox(width: 12),
                                  ],
                                ),
                                const SizedBox(height: 12),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            SliverPadding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              sliver: SliverToBoxAdapter(
                child: Row(
                  children: [
                    Expanded(
                      child: CustomInputField(
                        labelText: 'Enter promo code',
                        allowedType: AllowedType.text,
                        controller: _promo,
                      ),
                    ),
                    SizedBox(width: 12),
                    SizedBox(
                      height: 50,
                      width: 90,
                      child: CustomButton(
                        text: 'Apply',
                        foregroundColor: Colors.white,
                        onPressed: () {
                          // TODO: apply promo
                        },
                        variant: ButtonVariant.filled,
                        radius: 10,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SliverToBoxAdapter(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(color: AppColors.grey),
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    _SummaryRow(
                      label: "Subtotal",
                      value: _inr(controller.subtotal),
                    ),
                    SizedBox(height: 12),
                    _SummaryRow(label: "Shipping", value: "Free"),
                    Divider(height: 28),
                    _SummaryRow(
                      label: "Total",
                      value: _inr(controller.total),
                      isEmphasis: true,
                    ),
                  ],
                ),
              ),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: 18)),

            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              sliver: SliverToBoxAdapter(
                child: SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: CustomButton(
                    text: "Proceed to Checkout",
                    onPressed: () {},
                    variant: ButtonVariant.filled,
                    radius: 25,
                    fontSize: secondary(),
                    fontWeight: FontWeight.w600,
                    foregroundColor: Colors.white,
                    backgroundColor: AppColors.green,
                  ),
                ),
              ),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: 40)),
          ],
        );
      }),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  final String label;
  final String value;
  final bool isEmphasis;
  const _SummaryRow({
    required this.label,
    required this.value,
    this.isEmphasis = false,
  });

  @override
  Widget build(BuildContext context) {
    final style = TextStyle(
      fontSize: isEmphasis ? secondary() : tertiary(),
      fontWeight: isEmphasis ? FontWeight.w700 : FontWeight.w500,
      color: Colors.black,
    );
    return Row(
      children: [
        Text(label, style: style),
        const Spacer(),
        Text(value, style: style),
      ],
    );
  }
}

class _QtyControl extends StatelessWidget {
  final int qty;
  final VoidCallback onMinus;
  final VoidCallback onPlus;

  const _QtyControl({
    required this.qty,
    required this.onMinus,
    required this.onPlus,
  });

  @override
  Widget build(BuildContext context) {
    Widget circle(IconData icon, VoidCallback onTap) => InkWell(
      onTap: onTap,
      child: Container(
        width: 25,
        height: 25,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: AppColors.green, width: 2),
        ),
        child: Icon(icon, size: 15, color: AppColors.green),
      ),
    );

    return Row(
      children: [
        circle(Icons.remove, onMinus),
        const SizedBox(width: 12),
        Text('$qty', style: const TextStyle(fontWeight: FontWeight.w600)),
        const SizedBox(width: 12),
        circle(Icons.add, onPlus),
      ],
    );
  }
}
