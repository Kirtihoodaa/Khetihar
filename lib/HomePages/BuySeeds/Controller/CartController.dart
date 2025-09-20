import 'package:get/get.dart';

class CartItem {
  final Map<String, dynamic> product; // expects: { id, price (num), ... }
  int qty;

  CartItem({required this.product, this.qty = 1});

  double get lineTotal => (product['price'] as num).toDouble() * qty;
}

class CartController extends GetxController {
  final items = <CartItem>[].obs;

  /// Configure a hard cap if you want (or keep null = unlimited)
  final int? maxQtyPerItem;

  CartController({this.maxQtyPerItem});

  // ---------- CRUD ----------
  void addToCart(Map<String, dynamic> product, {int qty = 1}) {
    final id = product['id'];
    if (id == null) return;

    final idx = indexById(id);
    if (idx != -1) {
      final next = items[idx].qty + qty;
      items[idx].qty = _clamped(next);
      items.refresh();
    } else {
      items.add(CartItem(product: product, qty: _clamped(qty)));
    }
  }

  void removeAt(int index) {
    if (index >= 0 && index < items.length) items.removeAt(index);
  }

  void removeByProductId(dynamic id) {
    final idx = indexById(id);
    if (idx != -1) items.removeAt(idx);
  }

  void inc(int index) {
    if (index < 0 || index >= items.length) return;
    items[index].qty = _clamped(items[index].qty + 1);
    items.refresh();
  }

  void dec(int index) {
    if (index < 0 || index >= items.length) return;
    if (items[index].qty > 1) {
      items[index].qty -= 1;
      items.refresh();
    } else {
      items.removeAt(index);
    }
  }

  void setQty(int index, int qty) {
    if (index < 0 || index >= items.length) return;
    if (qty <= 0) {
      items.removeAt(index);
    } else {
      items[index].qty = _clamped(qty);
      items.refresh();
    }
  }

  int indexById(dynamic id) =>
      items.indexWhere((e) => e.product['id'] == id);

  int _clamped(int q) =>
      maxQtyPerItem == null ? q : q.clamp(1, maxQtyPerItem!);

  // ---------- Totals ----------
  double get subtotal =>
      items.fold(0.0, (sum, e) => sum + e.lineTotal);

  double get shipping => 0.0; // adjust if needed
  double get total => subtotal + shipping;

  /// Sum of quantities — use this for the app bar badge
  int get totalQty => items.fold<int>(0, (s, e) => s + e.qty);

  /// Number of distinct products
  int get distinctCount => items.length;

  void clear() => items.clear();
}
