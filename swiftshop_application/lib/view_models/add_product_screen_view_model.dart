import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:swiftshop_application/data/models/product.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _mainCollection = _firestore.collection('products');

class Response {
  int? code;
  String? message;
  Response({this.code, this.message});
}

class AddProduct {
  static Future<void> addItem({
    required String id,
    required String path,
    required String name,
    required String description,
    required int price,
    required int promotionPrice,
    required int quantity,
    required int quantitySold,
    required int rate,
    required String type,
  }) async {
    DocumentReference documentReference = _mainCollection.doc();

    String id = documentReference.id;
    FirebaseFirestore.instance.collection('products').doc(id).set({'a': 1});
    Map<String, dynamic> data = <String, dynamic>{
      "id": id,
      "path": path,
      "name": name,
      "description": description,
      "price": price,
      "promotionPrice": promotionPrice,
      "quantity": quantity,
      "quantitySold": quantitySold,
      "rate": rate,
      "type": type,
    };
    await documentReference
        .set(data)
        .whenComplete(
          () => const SnackBar(content: Text("Thêm thành công")),
        )
        .catchError((e) => print(e));
  }

  static Stream<QuerySnapshot> readItems() {
    CollectionReference productsItemCollection =
        _mainCollection.doc().collection('products');
    return productsItemCollection.snapshots();
  }

  static Future<void> updateItem({
    required String productid,
    required String name,
    required String description,
    required int price,
    required int promotionPrice,
    required int quantity,
    required int quantitySold,
    required int rate,
    required String type,
  }) async {
    DocumentReference documentReference = _mainCollection.doc(productid);
    Map<String, dynamic> data = <String, dynamic>{
      "id": productid,
      "name": name,
      "description": description,
      "price": price,
      "promotionPrice": promotionPrice,
      "quantity": quantity,
      "quantitySold": quantitySold,
      "rate": rate,
      "type": type,
    };
    await documentReference
        .update(data)
        .whenComplete(() => print("Products item updated to the datatbase"))
        .catchError((e) => print(e));
  }
}
