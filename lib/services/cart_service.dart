import 'package:flutter/foundation.dart';

class CartService extends ChangeNotifier {
  static final CartService _instance = CartService._internal();
  factory CartService() => _instance;
  CartService._internal();

  final List<Map<String, dynamic>> _cartItems = [];

  List<Map<String, dynamic>> get cartItems => List.unmodifiable(_cartItems);

  int get itemCount => _cartItems.fold(0, (sum, item) => sum + (item['quantity'] as int));

  double get totalPrice => _cartItems.fold(0.0, (sum, item) => sum + (item['price'] as double) * (item['quantity'] as int));

  void addToCart({
    required String id,
    required String name,
    required double price,
    required String image,
    required String size,
    required String color,
    int quantity = 1,
  }) {
    final existingItemIndex = _cartItems.indexWhere(
      (item) => item['id'] == id && item['size'] == size && item['color'] == color,
    );

    if (existingItemIndex != -1) {
      _cartItems[existingItemIndex]['quantity'] += quantity;
    } else {
      _cartItems.add({
        'id': id,
        'name': name,
        'price': price,
        'image': image,
        'size': size,
        'color': color,
        'quantity': quantity,
      });
    }
    notifyListeners();
  }

  void removeFromCart(String id, String size, String color) {
    _cartItems.removeWhere(
      (item) => item['id'] == id && item['size'] == size && item['color'] == color,
    );
    notifyListeners();
  }

  void updateQuantity(String id, String size, String color, int newQuantity) {
    final itemIndex = _cartItems.indexWhere(
      (item) => item['id'] == id && item['size'] == size && item['color'] == color,
    );

    if (itemIndex != -1) {
      if (newQuantity <= 0) {
        _cartItems.removeAt(itemIndex);
      } else {
        _cartItems[itemIndex]['quantity'] = newQuantity;
      }
      notifyListeners();
    }
  }

  void clearCart() {
    _cartItems.clear();
    notifyListeners();
  }
}
