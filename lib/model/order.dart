class Order {
  int? clientId;
  double? productsPrice;
  double shippingCost = 0;
  double? finalPrice;
  String? deliveryAddress;
  String? paymentMethod;
  List<OrderItem> items = [];
}

class OrderItem {
  final int productId;
  final int quantity;
  final double subTotal;

  OrderItem(
      {required this.productId,
      required this.quantity,
      required this.subTotal});
}
