import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:path_provider/path_provider.dart';
import 'package:swiftshop_application/data/models/product.dart';

class AdminProfileModel {
  final CollectionReference _mainCollection =
      FirebaseFirestore.instance.collection('products');
  //Get data on firebase
  Future<List<Product>> getDataOnFireBase() async {
    QuerySnapshot productsSnapshot = await _mainCollection.get();
    List<Product> products = [];
    for (var i in productsSnapshot.docs) {
      Product pro = Product(
          id: i.id,
          path: i['path'],
          title: i['name'],
          price: i['price'],
          promotionalPrice: i['promotionPrice'], //hau 21/01 3:00pm
          type: i['type'],
          quantity: int.parse(i['quantity'].toString()),
          quantitySold: int.parse(i['quantitySold'].toString()),
          rate: double.parse(i['rate'].toString()),
          description: "");
      products.add(pro);
    }
    return products;
  }

  //Save product local
  Future saveProductLocal(List<Product> products) async {
    File file = await Product.getPathFile('product');
    try {
      //Kiem tra file co ton tai
      if (await file.exists()) {
        List<Map<String, dynamic>> jsonData =
            products.map((e) => e.toJson()).toList();
        file.writeAsString(jsonEncode(jsonData));
        print("Save product to json done!");
      }
      //File khong ton tai
      else {
        List<Map<String, dynamic>> jsonData =
            products.map((e) => e.toJson()).toList();
        file.writeAsString(jsonEncode(jsonData));
        print("Save product to json done!");
      }
    } catch (e) {
      print("Save product to json fail!: $e");
    }
  }

  //Load and save
  Future loadAndSaveProduct() async {
    List<Product> productsOnFirebase = await getDataOnFireBase();
    await saveProductLocal(productsOnFirebase);
  }

  //Get product local
  Future<List<Product>> fetchProductsLocal() async {
    List<Product> products = [];
    File file = await Product.getPathFile('product');
    try {
      //Neu file ton tai
      if (await file.exists()) {
        String data = await file.readAsString();
        List<dynamic> jsonData = jsonDecode(data);
        for (var i in jsonData) {
          products.add(Product.fromJson(i));
        }
        print('File product local done!');
        return products;
      }
      //File khong ton tai
      else {
        print('File product local not exist!');
      }
    } catch (e) {
      print('File product local fail!: $e');
    }
    return products;
  }
}
