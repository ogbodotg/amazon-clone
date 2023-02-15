import 'dart:convert';

import 'package:amazon_clone/models/ratings.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Product {
  final String productName;
  final String productDescription;
  final int quantity;
  final int price;
  final List<String> productImages;
  final String category;
  final String? id;
  final String? userId;
  final List<Rating>? rating;

  Product({
    required this.productName,
    required this.productDescription,
    required this.quantity,
    required this.price,
    required this.productImages,
    required this.category,
    this.id,
    this.userId,
    this.rating,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'productName': productName,
      'productDescription': productDescription,
      'quantity': quantity,
      'price': price,
      'productImages': productImages,
      'category': category,
      'id': id,
      'userId': userId,
      'rating': rating,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      productName: map['productName'] as String,
      productDescription: map['productDescription'] as String,
      quantity: map['quantity'] as int,
      price: map['price'] as int,
      productImages: List<String>.from(map['productImages']),
      category: map['category'] as String,
      id: map['_id'] != null ? map['_id'] as String : null,
      userId: map['userId'] != null ? map['userId'] as String : null,
      rating: map['ratings'] != null
          ? List<Rating>.from(map['ratings']?.map((x) => Rating.fromMap(x)))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source) as Map<String, dynamic>);
}
