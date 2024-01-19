import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:swiftshop_application/data/models/cart_detail.dart';
import 'package:swiftshop_application/data/models/carts.dart';
import 'package:swiftshop_application/data/models/format_currency.dart';
import 'package:swiftshop_application/data/models/product.dart';
import 'package:swiftshop_application/data/models/reader.dart';
import 'package:swiftshop_application/views/components/outstanding_product_list.dart';

class HomeScreenViewModel {
  final CollectionReference productReffrence =
      FirebaseFirestore.instance.collection("products");

  void navigationCartScreen(BuildContext context) {
    Navigator.pushNamed(context, "/cartscreen");
  }

  // void navigationDetailProduct(BuildContext context) {
  //   Navigator.push(context, MaterialPageRoute(builder: (context) => DetailProductSreen(),));
  // }

  static String returnPrice(int price) {
    if (price < 999999) {
      return FormatCurrency.stringToCurrency(price.toString());
    } else {
      if (price % 1000000 == 0) {
        return "${price ~/ 1000000}Tr ";
      } else {
        return "${price / 1000000}Tr ";
      }
    }
  }

  //Thach 19/1
  //Load product firebase
  Future<List<Product>> fetchProductsFirebase() async {
    QuerySnapshot productsSnapshot = await productReffrence.get();
    List<Product> products = [];
    for (var i in productsSnapshot.docs) {
      Product pro = Product(
          id: i.id,
          path: i['path'],
          title: i['name'],
          price: i['price'], //Thach 16/1 int
          promotionalPrice: i['promotionPrice'], //Thach 16/1 int
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
    List<Product> productsOnFirebase = await fetchProductsFirebase();
    await saveProductLocal(productsOnFirebase);
  }

  //Get product local
  Future<List<Product>> fetchProductsLocal() async {
    await loadAndSaveProduct();
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
  //Find bestSaler product outstanding product

  List<Product> findOustandingProducts(List<Product> products) {
    //? Tại list sản phẩm nổi bật có 6 sp
    List<Product> outstandingProduct = [];

    products.sort((a, b) => b.rate!.compareTo(a.rate!));

    if (products.length <= 6) {
      outstandingProduct.addAll(products);
    } else {
      for (int i = 0; products.length >= 6 ? i < 6 : i < products.length; i++) {
        if (outstandingProduct.length < 6) outstandingProduct.add(products[i]);
      }
    }
    return outstandingProduct;
  }

  List<Product> findBestSalerProducts(List<Product> products) {
    //? Tại list sản phẩm bán chạy có 4 sp
    List<Product> bestSalerProducts = [];

    products.sort((a, b) => (b.quantitySold * 0.6 + b.rate! * 0.8)
        .compareTo(a.quantitySold * 0.6 + a.rate! * 0.8));

    if (Product.product.length <= 4) {
      bestSalerProducts.addAll(products);
    } else {
      for (int i = 0; products.length >= 4 ? i < 4 : i < products.length; i++) {
        if (bestSalerProducts.length <= 4)
          bestSalerProducts.add(products[i]);
        else
          break;
      }
    }
    return bestSalerProducts;
  }

  //Load cart
  // Future<List<CartDetail>> loadCartLocal() async {
  //   List<CartDetail> lstcartitem = [];
  //   InfoReader reader = InfoReader();
  //   File f = await reader.getPathFile("cart_item");
  //   try
  //   {
  //     if(await f.exists())
  //     {
  //       String data = await f.readAsString();
  //       List<dynamic>  =
  //     }
  //     else
  //     {

  //     }
  //   }
  //   catch (e)
  //   {

  //   }
  // }
  //Add product into Cart

  //Save cart
}
