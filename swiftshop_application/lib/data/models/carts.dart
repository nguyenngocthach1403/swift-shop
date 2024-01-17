import 'package:cloud_firestore/cloud_firestore.dart';

class Cart {
  String cartId;
  String accountId;
  int totalQuantity;
  int totalPrice;
  Cart(
      {required this.cartId,
      required this.accountId,
      required this.totalPrice,
      required this.totalQuantity});

  static final CollectionReference cart =
      FirebaseFirestore.instance.collection("carts");

  static Future<Cart> getCartById(String cartId) async {
    QuerySnapshot cartSnapshot = await cart.get();
    for (var i in cartSnapshot.docs) {
      if (i.id == cartId) {
        return Cart(
            cartId: i.id,
            accountId: i['AccountId'],
            totalPrice: i['TotalPrice'],
            totalQuantity: i['TotalQuantity']);
      }
    }
    newCart(cartId, cartId);
    return Cart(
        cartId: cartId, accountId: cartId, totalPrice: 0, totalQuantity: 0);
  }

  //Thach 16.1 tạo mới cart
  static void newCart(String cartId, String accountId) {
    Map<String, dynamic> newData = {
      'CartId': cartId,
      'AccountId': accountId,
      'TotalProduct': 0,
      'TotalPrice': 0
    };
    cart.doc(cartId).set(newData);
  }
}
