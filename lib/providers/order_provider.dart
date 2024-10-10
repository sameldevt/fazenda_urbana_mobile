import 'package:flutter/material.dart';
import 'package:verdeviva/model/product.dart';
import 'package:verdeviva/model/user.dart';
import 'package:verdeviva/service/order_service.dart';

import '../model/order.dart';

class OrderProvider with ChangeNotifier {
  Order? order = Order();

  Future<void> createOrder() async {
    order ??= Order();
    notifyListeners();
  }

  Future<void> addItems(Set<ProductToCart> products) async {
    final orderItems = products
        .map((p) => OrderItem(
            productImage: p.imageUrl, productId: p.id, quantity: p.quantity, subTotal: p.totalPrice))
        .toList();

    order!.items.addAll(orderItems);

    final totalPrice = products
        .map((product) => product.totalPrice)
        .reduce((a, b) => a + b);

    order!.finalPrice = totalPrice;
    notifyListeners();
  }

  Future<void> addAddress(Address address) async{
    order!.deliveryAddress = address.street;
    notifyListeners();
  }

  Future<void> addPaymentMethod(String paymentMethod) async {
    order!.paymentMethod = paymentMethod;
    notifyListeners();
  }

  Future<void> addShippingCost(double shippingCost) async {
    order!.shippingCost = shippingCost;
    notifyListeners();
  }

  Future<void> clearOrder() async {
    if(order != null){
      order = null;
      notifyListeners();
    }
  }
}
