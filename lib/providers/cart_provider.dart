import 'package:flutter/cupertino.dart';
import 'package:verdeviva/model/product.dart';
import 'package:verdeviva/service/cart_service.dart';
class CartProvider with ChangeNotifier {
  final _cartService = CartService();
  Set<ProductToCart> products = {};

  Future<void> loadCart() async {
    products = await _cartService.getProducts();
    products.forEach((item) {
      print('Product ID: ${item.id}');
    });
    notifyListeners();
  }

  Future<void> updateProduct(ProductToCart product) async {
    await _cartService.updateProduct(product);

    products.firstWhere((item) => item.id == product.id).quantity = product.quantity;

    notifyListeners();
  }


  Future<void> addProduct(ProductToCart product) async {
    await _cartService.addProduct(product);
    await loadCart();
    //notifyListeners();
  }

  Future<void> removeProduct(ProductToCart product) async {
    await _cartService.removeProduct(product);
    products.remove(product);
    //await loadCart();
    notifyListeners();
  }

  Future<void> clearCart() async {
    await _cartService.clearCart();
    products.clear(); // Limpa a lista localmente
    notifyListeners();
  }
}
