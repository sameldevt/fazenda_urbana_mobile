import 'package:flutter/cupertino.dart';
import 'package:verdeviva/model/product.dart';
import 'package:verdeviva/service/product_service.dart';

class ProductProvider with ChangeNotifier{
  final _productService = ProductService();
  List<Product> products = [];

  Future<void> loadAll() async {
    products = await _productService.getAll();
  }
}
