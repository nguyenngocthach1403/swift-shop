import 'dart:convert';

import 'package:swiftshop_application/data/models/reader.dart';

class Product {
  final int id;
  final String path;
  final String title;
  final String price;
  final int quantity;
  final String type;
  final String promotionalPrice;
  final int quantitySold;
  final double? rate;
  final String description;
  Product(
      {required this.id,
      required this.path,
      required this.title,
      required this.price,
      required this.promotionalPrice,
      required this.type,
      required this.quantity,
      required this.quantitySold,
      required this.rate,
      required this.description});
  Product.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        path = "",
        title = json['title'],
        price = json['price'],
        promotionalPrice = json['promotionalPrice'],
        type = json['type'],
        quantitySold = json['quantitySold'],
        quantity = json['quantity'],
        rate = json['rate'],
        description = json['description'];

  static List<Product> product = List.filled(
      0,
      Product(
          id: 1,
          path: "",
          title: "",
          price: "",
          promotionalPrice: "",
          type: "",
          quantity: 1,
          quantitySold: 1,
          description: "",
          rate: 1),
      growable: true);

  static int findBestQuantitySold() {
    int bestquantitySold = 0;
    for (var i in Product.product) {
      if (bestquantitySold < i.quantitySold) {
        bestquantitySold = i.quantitySold;
      }
    }
    return bestquantitySold;
  }

  static Future<void> loadDataProduct() async {
    InfoReader reader = InfoReader();
    String data = await reader.getInfo();
    List<dynamic> list = jsonDecode(data);
    for (var i in list) {
      product.add(Product.fromJson(i));
    }
  }
}
