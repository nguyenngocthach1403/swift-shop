// import 'package:swiftshop_application/data/models/carts.dart';

// class CartViewModel {
//   Stream<List<Cart>> cartItemsStream = Cart.getAllCarts();

//   Future<void> updateQuantity(String cartId, int newQuantity) async {
//     await Cart.updateProductQuantity(cartId, newQuantity);
//   }

//   Future<void> removeProduct(String cartId) async {
//     await Cart.removeProduct(cartId);
//   }
// }

import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:swiftshop_application/data/models/cart_detail.dart';
import 'package:swiftshop_application/data/models/carts.dart';
import 'package:swiftshop_application/data/models/product.dart';
import 'package:swiftshop_application/data/models/reader.dart';

class CartViewModel {
  // Stream<List<Cart>> cartItemsStream = Cart.getAllCarts();
  CollectionReference carts =
      FirebaseFirestore.instance.collection('cart detail');
  String idAcountCurrent = FirebaseAuth.instance.currentUser!.uid;

  List<CartDetail> lstCart = [];

  Future<void> increaseQuantity(String cartId) async {
    int currentQuantity = (await Cart.getCartById(cartId)).totalQuantity;
    currentQuantity++;
    await Cart.updateProductQuantity(cartId, currentQuantity);
  }

  Future<void> decreaseQuantity(String cartId) async {
    int currentQuantity = (await Cart.getCartById(cartId)).totalQuantity;
    if (currentQuantity > 1) {
      currentQuantity--;
      await Cart.updateProductQuantity(cartId, currentQuantity);
    }
  }

  Future<void> removeProduct(String cartId) async {
    await Cart.removeProduct(cartId);
  }

  //load cart on  firebase
  Future<List<CartDetail>> loadCartOnFirebase() async {
    QuerySnapshot cartSnapshot = await carts.get();
    List<CartDetail> lstCartItem = [];
    for (var i in cartSnapshot.docs) {
      CartDetail cartItem = CartDetail(i.id,
          cartId: i['CartId'],
          price: i['Price'],
          productId: i['ProductId'],
          quantity: i['Quantity']);

      if (idAcountCurrent == cartItem.cartId) {
        lstCartItem.add(cartItem);
      }
    }
    lstCart = lstCartItem;
    return lstCartItem;
  }

  //Save cart into local
  saveCartDetailOnLocal() async {
    //List cartdetail
    List<CartDetail> carts = await loadCartOnFirebase();
    //get file
    InfoReader reader = InfoReader();
    File f = await reader.getPathFile('cart detail');
    //If file is exist
    try {
      if (await f.exists()) {
        List<Map<String, dynamic>> lstData =
            carts.map((e) => e.toJson()).toList();
        await f.writeAsString(jsonEncode(lstData));
      }
      //If it not exist -> create new
      else {
        List<Map<String, dynamic>> lstData =
            carts.map((e) => e.toJson()).toList();
        await f.writeAsString(jsonEncode(lstData));
      }
      print('Save cart detail done!');
    } catch (e) {
      print('Save cart detail fail: $e');
    }
  }

  //Load cart on local
  Future<List<CartDetail>> fetchCartDetailOnLocal() async {
    await saveCartDetailOnLocal();
    List<CartDetail> carts = [];
    //get file
    InfoReader reader = InfoReader();
    File f = await reader.getPathFile('cart detail');

    try {
      //if file is exist
      if (await f.exists()) {
        String data = await f.readAsString();
        List<dynamic> lstData = jsonDecode(data);
        for (var i in lstData) {
          carts.add(CartDetail.fromJson(i));
        }
        print('Load cartdetail file done!');
      }
      //if file not exist
      else {
        print('File cartdetail not exist!');
      }
    } catch (e) {
      print('Load cartdetail fail!: $e');
    }
    return carts;
  }

  //Load product from cart detail
  Future<List<Product>> fetchProductFromCartDetail() async {
    List<CartDetail> carts = await fetchCartDetailOnLocal();

    List<Product> products = [];
    File file = await Product.getPathFile('product');
    try {
      //Neu file ton tai
      if (await file.exists()) {
        String data = await file.readAsString();
        List<dynamic> jsonData = jsonDecode(data);
        for (var i in jsonData) {
          for (var j in carts) {
            if (j.productId == Product.fromJson(i).id) {
              products.add(Product.fromJson(i));
            }
          }
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

  //Get product by Id
  Product? getProductById(String id, List<Product> products) {
    for (var i in products) {
      if (id == i.id) {
        return i;
      }
    }
    return null;
  }

  // tung 19/1 Remove cart
  deleteItem(String cartDetailId) {
    carts.doc(cartDetailId).delete();
    fetchProductFromCartDetail();
  }

  // tung 19/1 Update cart
  updateQuantity(String cartDetailId, int quantity) {
    carts.doc(cartDetailId).update({'Quantity': quantity});
  }
}
