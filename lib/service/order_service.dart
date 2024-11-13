import 'dart:convert';

import 'package:verdeviva/common/constants.dart';
import 'package:verdeviva/model/order.dart';
import 'package:verdeviva/service/access_service.dart';
import 'package:http/http.dart' as http;

class OrderService {
  final String contextUrl = "pedido";

  Future<void> createOrder(Order order) async {
    print(order.finalPrice);
    http.Response response = await http.post(
      Uri.parse("$baseApiUrl/$contextUrl/cadastrar"),
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode({
        "clienteId": order.clientId,
        "total": order.finalPrice,
        "enderecoEntrega": order.deliveryAddress,
        "formaPagamento": order.paymentMethod,
        "itens": order.items.map((i) => i.toJson()).toList(),
      }),
    );

    if (response.statusCode == 500) {
      print(response.body);
      throw ServerErrorException();
    }

    if (response.statusCode == 404) {
      print(response.body);
      throw UserNotFoundException();
    }

    if (response.statusCode == 400) {
      print(response.body);
      throw InvalidCredentialsException();
    }
  }
}