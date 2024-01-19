import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:swiftshop_application/data/models/reader.dart';
import 'package:path_provider/path_provider.dart';

class Product {
  final String id; //Doi kieu id cua product thanh kieu String
  final String path;
  final String title;
  final int
      price; //Thach 16.1 sửa lại kiểu dữ liệu price , quantity, promotionalPrice, quantitySold
  final int quantity;
  final String type;
  final int promotionalPrice;
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
        path = json['path'],
        title = json['name'],
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
          id: '',
          path: "",
          title: "",
          price: 0,
          promotionalPrice: 0,
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

  static Future<File> getPathFile(String nameFile) async {
    final f = await getApplicationCacheDirectory();
    return File('${f.path}/$nameFile.json');
  }

  //Thach 12/1 lấy dữ liệu từ local file json
  static Future<void> loadLocalProduct() async {
    File fileProduct = await getPathFile('product');
    if (await fileProduct.exists()) {
      String data = await fileProduct.readAsStringSync();
      List<dynamic> list = jsonDecode(data);
      bool isExistsProduct = false;
      for (var i in list) {
        for (var j in product) {
          if (Product.fromJson(i).id == j.id) {
            isExistsProduct = true;
          }
        }
        if (isExistsProduct == false) {
          product.add(Product.fromJson(i));
        }
      }
    }
  }

  //Thach 12/1 lấy dữ liệu từ filebase
  static Future fetchDataFromFirebase() async {
    List<Product> lstFirebaseProducts = [];
    QuerySnapshot snapshotData =
        await FirebaseFirestore.instance.collection("products").get();
    for (var i in snapshotData.docs) {
      Product newPro = Product(
          id: i.id,
          path: i['path'],
          title: i['name'],
          price: i['price'],
          promotionalPrice: i['promotionPrice'],
          type: i['type'],
          quantity: int.parse(i['quantity'].toString()),
          quantitySold: int.parse(i['quantitySold'].toString()),
          rate: double.parse(i['rate'].toString()),
          description: "");
      bool defference = false;
      for (var i in lstFirebaseProducts) {
        if (newPro.id == i.id) {
          defference = true;
        }
      }
      if (defference == false) {
        lstFirebaseProducts.add(newPro);
      }
    }
    Product.product = lstFirebaseProducts;
  }

  static Future<bool> saveDataProduct(
      List<Product> products, String filename) async {
    try {
      File productFile = await getPathFile('product');
      if (await productFile.exists()) {
        List<Map<String, dynamic>> jsonData =
            products.map((e) => e.toJson()).toList();
        await productFile.writeAsString(jsonEncode(jsonData));
        return true;
      }
      return false;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': title,
        'price': price,
        'promotionalPrice': promotionalPrice,
        'path': path,
        'quantity': quantity,
        'quantitySold': quantitySold,
        'description': description,
        'type': type,
        'rate': rate,
      };
}
