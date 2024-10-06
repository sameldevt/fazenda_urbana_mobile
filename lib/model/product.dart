import 'package:flutter/material.dart';

class Product {
  final int id;
  final String name;
  final String description;
  final double pricePerKilo;
  final int stockQuantity;
  final String imageUrl;
  final Category category;
  final Nutrients nutrients;

  const Product({
    required this.id,
    required this.name,
    required this.description,
    required this.pricePerKilo,
    required this.stockQuantity,
    required this.imageUrl,
    required this.category,
    required this.nutrients
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['nome'],
      description: json['descricao'],
      pricePerKilo: (json['precoQuilo'] as num).toDouble(),
      stockQuantity: json['quantidadeEstoque'],
      imageUrl: json['imagemUrl'],
      category: Category.fromJson(json['categoria']),
      nutrients: Nutrients.fromJson(json['nutrientes'])
    );
  }
}

class Category {
  final int id;
  final String name;
  final String description;
  final DateTime creationDate;

  const Category({
    required this.id,
    required this.name,
    required this.description,
    required this.creationDate,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'] ?? 0,
      name: json['nome'] ?? '',
      description: json['descricao'] ?? '',
      creationDate: DateTime.parse(json['dataCriacao']),
    );
  }
}

class Nutrients {
  final double calories;
  final double proteins;
  final double carbohydrates;
  final double fibers;
  final double fats;

  const Nutrients({
    required this.calories,
    required this.proteins,
    required this.carbohydrates,
    required this.fibers,
    required this.fats,
  });

  factory Nutrients.fromJson(Map<String, dynamic> json) {
    return Nutrients(
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
