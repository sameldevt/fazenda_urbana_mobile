import 'dart:convert';

import 'package:verdeviva/common/constants.dart';
import 'package:verdeviva/model/order.dart';
import 'package:verdeviva/service/access_service.dart';
import 'package:http/http.dart' as http;

class OrderService {
  final String contextUrl = "pedidos";

  Future<void> createOrder(Order order) async {
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
        "itens": order.items,
      }),
    );

    if (response.statusCode == 500) {
      throw ServerErrorException();
    }

    if (response.statusCode == 404) {
      throw UserNotFoundException();
    }

    if (response.statusCode == 400) {
      throw InvalidCredentialsException();
    }
  }
}