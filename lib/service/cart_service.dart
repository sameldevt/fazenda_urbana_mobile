import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:verdeviva/model/product.dart';

class CartService {
  final String _cartKey = 'cart_items';

  Future<void> addProduct(ProductToCart product) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> cart = prefs.getStringList(_cartKey) ?? [];

    cart.add(jsonEncode(product.toJson()));

    await prefs.setStringList(_cartKey, cart);
  }

  Future<void> updateProduct(ProductToCart productToCart) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> cart = prefs.getStringList(_cartKey) ?? [];

    cart.removeWhere((item) {
      final product = ProductToCart.fromJson(jsonDecode(item));
      return product.id == productToCart.id;
    });

    cart.add(jsonEncode(productToCart.toJson()));

    await prefs.setStringList(_cartKey, cart);
  }

  Future<Set<ProductToCart>> getProducts() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> cart = prefs.getStringList(_cartKey) ?? [];

    return cart.map((item) => ProductToCart.fromJson(jsonDecode(item))).toSet();
  }

  Future<void> removeProduct(ProductToCart productToRemove) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> cart = prefs.getStringList(_cartKey) ?? [];

    cart.removeWhere((item) {
      final product = ProductToCart.fromJson(jsonDecode(item));
      return product.id == productToRemove.id;
    });

    await prefs.setStringList(_cartKey, cart);
  }

  Future<void> clearCart() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_cartKey);
  }
}
