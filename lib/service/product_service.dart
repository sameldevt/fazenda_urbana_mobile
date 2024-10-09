import 'dart:convert';

import 'package:verdeviva/common/constants.dart';
import 'package:verdeviva/model/product.dart';
import 'package:http/http.dart' as http;

class ProductService{
  final String contextUrl = "produtos";

  Future<List<Product>> getAll() async {
    final response = await http.get(Uri.parse('$baseApiUrl/$contextUrl/buscar-todos'));
    List<dynamic> responseBody = jsonDecode(response.body);

    return responseBody.map((product) => Product.fromJson(product)).toList();
  }
}