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
      id: json['id'] ?? 0,
      name: json['nome'] ?? '',
      description: json['descricao'] ?? '',
      unitPrice: (json['precoUnitario'] as num).toDouble(),
      pricePerKilo: (json['precoQuilo'] as num).toDouble(),
      stockQuantity: json['quantidadeEstoque'] ?? 0,
      categoryName: json['nomeCategoria'] ?? '',
      categoryDescription: json['descricaoCategoria'] ?? '',
      imageUrl: json['imagemUrl'] ?? '',
      calories: (json['calorias'] as num).toDouble(),
      proteins: (json['proteinas'] as num).toDouble(),
      carbohydrates: (json['carboidratos'] as num).toDouble(),
      fibers: (json['fibras'] as num).toDouble(),
      fats: (json['gorduras'] as num).toDouble(),
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
