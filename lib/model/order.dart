class Order {
  int id = 0;
  int? clientId;
  String? orderDate;
  String? deliveryDate;
  String? status;
  double? productsPrice;
  double? finalPrice;
  String? deliveryAddress;
  String? paymentMethod;
  String? notes;
  List<OrderItem> items = [];

  double shippingCost = 0;

  Order();

  factory Order.fromJson(Map<String, dynamic> json) {
    final order = Order();

    order.id = json['id'] ?? '';
    order.orderDate = json['dataPedido']?? '';
    order.deliveryDate = json['dataEntrega'] ?? '';
    order.status = json['status'] ?? '';
    order.finalPrice = json['total'];
    order.deliveryAddress = json['enderecoEntrega'] ?? '';
    order.paymentMethod = json['formaPagamento'] ?? '';
    order.notes = json['observacoes'] ?? '';
    order.items = (json['itens'] as List)
        .map((itemJson) => OrderItem.fromJson(itemJson))
        .toList();

    print(order.finalPrice);
    return order;
  }
}

class OrderItem {
  final String productImage;
  final int productId;
  final double quantity;
  final double subTotal;

  OrderItem(
      {required this.productImage,
      required this.productId,
      required this.quantity,
      required this.subTotal});

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
        //productImage: json['imagemUrl'],
        productImage: 'https://rb.gy/2xfabn',
        productId: json['produtoId'],
        quantity: json['quantidade'],
        subTotal: json['subTotal']);
  }

  Map<String, dynamic> toJson(){
    return {
      'produtoId': productId,
      'quantidade': quantity,
      'subTotal': subTotal
    };
  }
}
