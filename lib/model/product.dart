import 'package:flutter/material.dart';

class Product {
  final int id;
  final String name;
  final String description;
  final double unitPrice;
  final double pricePerKilo;
  final int stockQuantity;
  final String categoryName;
  final String categoryDescription;
  final String imageUrl;
  final double calories;
  final double proteins;
  final double carbohydrates;
  final double fibers;
  final double fats;

  const Product({
    required this.id,
    required this.name,
    required this.description,
    required this.unitPrice,
    required this.pricePerKilo,
    required this.stockQuantity,
    required this.categoryName,
    required this.categoryDescription,
    required this.imageUrl,
    required this.calories,
    required this.proteins,
    required this.carbohydrates,
    required this.fibers,
    required this.fats,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['Id'] ?? 0,
      name: json['Nome'] ?? '',
      description: json['Descricao'] ?? '',
      unitPrice: (json['PrecoUnitario'] as num).toDouble(),
      pricePerKilo: (json['PrecoQuilo'] as num).toDouble(),
      stockQuantity: json['QuantidadeEstoque'] ?? 0,
      categoryName: json['NomeCategoria'] ?? '',
      categoryDescription: json['DescricaoCategoria'] ?? '',
      imageUrl: json['ImagemUrl'] ?? '',
      calories: (json['Calorias'] as num).toDouble(),
      proteins: (json['Proteinas'] as num).toDouble(),
      carbohydrates: (json['Carboidratos'] as num).toDouble(),
      fibers: (json['Fibras'] as num).toDouble(),
      fats: (json['Gorduras'] as num).toDouble(),
    );
  }
}

class ProductToCart {
  late int id;
  late String name;
  late String description;
  late double basePrice;
  late double totalPrice;
  late int quantity;
  late String imageUrl;

  ProductToCart();

  ProductToCart.withValues({
    required this.id,
    required this.name,
    required this.description,
    required this.basePrice,
    required this.totalPrice,
    required this.quantity,
    required this.imageUrl,
  });

  factory ProductToCart.fromJson(Map<String, dynamic> json) {
    return ProductToCart.withValues(
      id: json["id"] ?? 0,
      name: json["name"],
      description: json["description"],
      basePrice: json["basePrice"],
      totalPrice: json["totalPrice"].toDouble(),
      quantity: json["quantity"],
      imageUrl: json["imageUrl"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "description": description,
      "basePrice": basePrice,
      "totalPrice": totalPrice,
      "quantity": quantity,
      "imageUrl": imageUrl,
    };
  }
}
