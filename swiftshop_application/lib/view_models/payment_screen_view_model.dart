import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:swiftshop_application/data/models/cart_detail.dart';
import 'package:swiftshop_application/data/models/product.dart';
import 'package:swiftshop_application/data/models/user_model.dart';

class PaymentScreenViewModel {
  String idAccountCurrent = FirebaseAuth.instance.currentUser!.uid;
  CollectionReference carts =
      FirebaseFirestore.instance.collection("cart detail");
  CollectionReference cartCollection =
      FirebaseFirestore.instance.collection("carts");
  CollectionReference users = FirebaseFirestore.instance.collection("accounts");
  CollectionReference proCollection =
      FirebaseFirestore.instance.collection("products");
  CollectionReference orderCollection =
      FirebaseFirestore.instance.collection("orders");
  CollectionReference orderDetailCollection =
      FirebaseFirestore.instance.collection("order detail");

  //Get infomation receiver
  Future<UserModel> userInfomation() async {
    QuerySnapshot user = await users.get();
    UserModel userInfo = UserModel(
        accountId: '', fullname: '', email: '', phonenumber: '', address: '');
    for (var i in user.docs) {
      if (i.id == idAccountCurrent) {
        userInfo = UserModel(
          accountId: i.id,
          address: i['address'],
          email: i['email'],
          fullname: i['fullname'],
          phonenumber: i['phonenumber'],
        );
      }
    }
    return userInfo;
  }

  //Load cart
  Future<List<CartDetail>> loadCartOnFirebase() async {
    QuerySnapshot cartSnapshot = await carts.get();
    List<CartDetail> lstCartItem = [];
    for (var i in cartSnapshot.docs) {
      CartDetail cartItem = CartDetail(i.id,
          cartId: i['CartId'],
          price: i['Price'],
          productId: i['ProductId'],
          quantity: i['Quantity']);

      if (idAccountCurrent == cartItem.cartId) {
        lstCartItem.add(cartItem);
      }
    }
    return lstCartItem;
  }

  Future<List<Product>> fetchProductFromCartDetail() async {
    List<CartDetail> carts = await loadCartOnFirebase();

    List<Product> products = [];
    QuerySnapshot proSnapshot = await proCollection.get();
    for (var i in proSnapshot.docs) {
      for (var j in carts) {
        if (j.productId == i.id) {
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
      }
    }
    return products;
  }

  String returnTotalPrice(List<CartDetail> lst) {
    int totalPrice = 0;
    for (var i in lst) {
      totalPrice += i.price * i.quantity;
    }
    return totalPrice.toString();
  }

  //Create new order
  bool createNewOrder(UserModel userinfo, List<CartDetail> cartItems) {
    DocumentReference newOrder = orderCollection.doc();
    int quantity = 0;
    int totalPrice = 0;
    for (var i in cartItems) {
      quantity += i.quantity;
      totalPrice = totalPrice + (i.price * i.quantity);
    }
    String newOrderId = newOrder.id;
    try {
      Map<String, dynamic> data = {
        'AccountId': userinfo.accountId,
        'Address': userinfo.address,
        'OrderDate': Timestamp.now(),
        'Quantity': quantity,
        'Status': 'Chờ xác nhận',
        'TotalPrice': totalPrice,
        'orderId': newOrderId,
        'DateComplete': ""
      };
      orderCollection.doc(newOrderId).set(data);

      for (var i in cartItems) {
        DocumentReference newOrderDetail = orderDetailCollection.doc();
        Map<String, dynamic> data = {
          'OrderId': newOrderId,
          'ProductId': i.productId,
          'Price': i.price,
          'Quantity': i.quantity,
          'promotionPrice': 0
        };
        orderDetailCollection.doc(newOrderDetail.id).set(data);
      }
      deleteCartDetailAndUpdateCart(cartItems);
      print("New order done");
      return true;
    } catch (e) {
      return false;
    }
  }

  //delete CartDetail
  deleteCartDetailAndUpdateCart(List<CartDetail> cartItems) {
    for (var i in cartItems) {
      carts.doc(i.cartdetailId).delete();
    }
    cartCollection
        .doc(idAccountCurrent)
        .update({'TotalQuantity': 0, 'TotalPrice': 0});
  }
}
