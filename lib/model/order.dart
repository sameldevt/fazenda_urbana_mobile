class ViewOrderDto {
  final int id;
  final DateTime orderDate;
  final DateTime deliveryDate;
  final String status;
  final double total;
  final String deliveryAddress;
  final String paymentMethod;
  final String observations;
  final List<ViewOrderItemDto> items;

  const ViewOrderDto({
    required this.id,
    required this.orderDate,
    required this.deliveryDate,
    required this.status,
    required this.total,
    required this.deliveryAddress,
    required this.paymentMethod,
    required this.observations,
    required this.items,
  });

  factory ViewOrderDto.fromJson(Map<String, dynamic> json) {
    return ViewOrderDto(
      id: json['Id'] ?? 0,
      orderDate: DateTime.parse(json['DataPedido']),
      deliveryDate: DateTime.parse(json['DataEntrega']),
      status: json['Status'] ?? '',
      total: (json['Total'] as num).toDouble(),
      deliveryAddress: json['EnderecoEntrega'] ?? '',
      paymentMethod: json['FormaPagamento'] ?? '',
      observations: json['Observacoes'] ?? '',
      items: (json['Itens'] as List<dynamic>)
          .map((item) => ViewOrderItemDto.fromJson(item))
          .toList(),
    );
  }
}

class CreateOrderDto {
  final int clientId;
  final DateTime orderDate;
  final DateTime deliveryDate;
  final String status;
  final double total;
  final String deliveryAddress;
  final String paymentMethod;
  final String observations;
  final List<ViewOrderItemDto> items;

  const CreateOrderDto({
    required this.clientId,
    required this.orderDate,
    required this.deliveryDate,
    required this.status,
    required this.total,
    required this.deliveryAddress,
    required this.paymentMethod,
    required this.observations,
    required this.items,
  });

  factory CreateOrderDto.fromJson(Map<String, dynamic> json) {
    return CreateOrderDto(
      clientId: json['IdCliente'] ?? 0,
      orderDate: DateTime.parse(json['DataPedido']),
      deliveryDate: DateTime.parse(json['DataEntrega']),
      status: json['Status'] ?? '',
      total: (json['Total'] as num).toDouble(),
      deliveryAddress: json['EnderecoEntrega'] ?? '',
      paymentMethod: json['FormaPagamento'] ?? '',
      observations: json['Observacoes'] ?? '',
      items: (json['Itens'] as List<dynamic>)
          .map((item) => ViewOrderItemDto.fromJson(item))
          .toList(),
    );
  }
}

class ViewOrderItemDto {
  final int id;
  final ViewProductDto product;
  final int quantity;
  final double unitPrice;
  final double subTotal;

  const ViewOrderItemDto({
    required this.id,
    required this.product,
    required this.quantity,
    required this.unitPrice,
    required this.subTotal,
  });

  factory ViewOrderItemDto.fromJson(Map<String, dynamic> json) {
    return ViewOrderItemDto(
      id: json['Id'] ?? 0,
      product: ViewProductDto.fromJson(json['Produto']),
      quantity: json['Quantidade'] ?? 0,
      unitPrice: (json['PrecoUnitario'] as num).toDouble(),
      subTotal: (json['SubTotal'] as num).toDouble(),
    );
  }
}

class CreateOrderItemDto {
  final ViewProductDto product;
  final int quantity;
  final double unitPrice;
  final double subTotal;

  const CreateOrderItemDto({
    required this.product,
    required this.quantity,
    required this.unitPrice,
    required this.subTotal,
  });

  factory CreateOrderItemDto.fromJson(Map<String, dynamic> json) {
    return CreateOrderItemDto(
      product: ViewProductDto.fromJson(json['Produto']),
      quantity: json['Quantidade'] ?? 0,
      unitPrice: (json['PrecoUnitario'] as num).toDouble(),
      subTotal: (json['SubTotal'] as num).toDouble(),
    );
  }
}

class UpdateOrderStatusDto {
  final int id;
  final String status;

  const UpdateOrderStatusDto({
    required this.id,
    required this.status,
  });

  factory UpdateOrderStatusDto.fromJson(Map<String, dynamic> json) {
    return UpdateOrderStatusDto(
      id: json['Id'] ?? 0,
      status: json['Status'] ?? '',
    );
  }
}
