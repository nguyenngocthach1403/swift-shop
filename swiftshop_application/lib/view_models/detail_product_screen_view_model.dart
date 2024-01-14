import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:swiftshop_application/data/models/product.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DetailProductScreenViewModel {
  late Product pro;
  int totalProduct = 1;

  void getProductId(int id) {
    Product.product.forEach((element) {
      if (element.id == id) {
        pro = element;
      }
    });
  }

  void incrementProduct() {
    totalProduct += 1;
  }

  void decrementProduct() {
    if (totalProduct > 0) {
      totalProduct--;
    }
  }

  Future<void> addProductToCard(Product pro, int totalProduct) async {
    String cartId = await findCartOfAccount();
    CollectionReference cart_detail =
        FirebaseFirestore.instance.collection("cart detail");

    Map<String, dynamic> dataToSave = {
      'CartId': cartId,
      'Price': pro.price,
      'Quantity': totalProduct,
      'ProductId': pro.id,
    };
    cart_detail.add(dataToSave);
    print("Save done");
  }

  Future<String> findCartOfAccount() async {
    late String accountIdCurrent;
    late String cartId;
    QuerySnapshot<Map<String, dynamic>> users =
        await FirebaseFirestore.instance.collection("accounts").get();
    QuerySnapshot<Map<String, dynamic>> carts =
        await FirebaseFirestore.instance.collection("carts").get();
    // Lay email current
    // String email = FirebaseAuth.instance.currentUser!.email!;
    String email = "thinh@gmail.com";
    // Lay accountID cua account hien tai
    for (var i in users.docs) {
      if (email == i['email']) {
        accountIdCurrent = i['accountId'];
      }
    }
    //Lay CartId  cua Account hien tai
    for (var i in carts.docs) {
      if (accountIdCurrent == i['AccountId']) {
        cartId = i['CartId'];
      }
    }
    return cartId;
  }
}
