import 'dart:convert';

class Product {
  final String id;
  final String name;
  final String desc;
  final String longDesc;
  final double price;
  final String sku;
  final String category;
  final String tag;
  final String image;
  final String collectionId;

  Product({
    required this.id,
    required this.name,
    required this.desc,
    required this.longDesc,
    required this.price,
    required this.sku,
    required this.category,
    required this.tag,
    required this.image,
    required this.collectionId,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['Name'],
      desc: json['Desc'],
      longDesc: json['LongDesc'],
      price: json['Price'].toDouble(),
      sku: json['SKU'],
      category: json['Category'],
      tag: json['tag'],
      image: json['image'],
      collectionId: json['collectionId'],
    );
  }
}