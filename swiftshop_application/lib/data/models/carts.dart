// import 'package:cloud_firestore/cloud_firestore.dart';

// class Cart {
//   String cartId;
//   String accountId;
//   int totalQuantity;
//   int totalPrice;
//   Cart(
//       {required this.cartId,
//       required this.accountId,
//       required this.totalPrice,
//       required this.totalQuantity});

//   static final CollectionReference cart =
//       FirebaseFirestore.instance.collection("carts");

//   static Future<Cart> getCartById(String cartId) async {
//     QuerySnapshot cartSnapshot = await cart.get();
//     for (var i in cartSnapshot.docs) {
//       if (i.id == cartId) {
//         return Cart(
//             cartId: i.id,
//             accountId: i['AccountId'],
//             totalPrice: i['TotalPrice'],
//             totalQuantity: i['TotalQuantity']);
//       }
//     }
//     newCart(cartId, cartId);
//     return Cart(
//         cartId: cartId, accountId: cartId, totalPrice: 0, totalQuantity: 0);
//   }

//   //Thach 16.1 tạo mới cart
//   static void newCart(String cartId, String accountId) {
//     Map<String, dynamic> newData = {
//       'CartId': cartId,
//       'AccountId': accountId,
//       'TotalProduct': 0,
//       'TotalPrice': 0
//     };
//     cart.doc(cartId).set(newData);
//   }
//   //tung 17/1 
//   static Future<void> updateProductQuantity(
//       String cartId, int newQuantity) async {
//     await cart.doc(cartId).update({'TotalQuantity': newQuantity});
//   }

//   static Future<void> removeProduct(String cartId) async {
//     await cart.doc(cartId).delete();
//   }
// static Stream<List<Cart>> getAllCarts() {
//   try {
//     return cart.snapshots().map((querySnapshot) {
//       return querySnapshot.docs.map((doc) {
//         return Cart(
//           cartId: doc.id,
//           accountId: doc['AccountId'],
//           totalPrice: doc['TotalPrice'],
//           totalQuantity: doc['TotalQuantity'],
//         );
//       }).toList();
//     });
//   } catch (e) {
//     print('Error fetching data from Firestore: $e');
//     return Stream.value([]); // Return an empty stream in case of an error
//   }
// }
// }


import 'package:cloud_firestore/cloud_firestore.dart';

class Cart {
  String cartId;
  String accountId;
  int totalQuantity;
  int totalPrice;

  Cart({
    required this.cartId,
    required this.accountId,
    required this.totalPrice,
    required this.totalQuantity,
  });

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
          totalQuantity: i['TotalQuantity'],
        );
      }
    }
    newCart(cartId, cartId);
    return Cart(
      cartId: cartId,
      accountId: cartId,
      totalPrice: 0,
      totalQuantity: 0,
    );
  }

  // Thêm sản phẩm vào giỏ hàng
  static void newCart(String cartId, String accountId) {
    Map<String, dynamic> newData = {
      'CartId': cartId,
      'AccountId': accountId,
      'TotalProduct': 0,
      'TotalPrice': 0
    };
    cart.doc(cartId).set(newData);
  }

  // Cập nhật số lượng sản phẩm
  static Future<void> updateProductQuantity(
    String cartId,
    int newQuantity,
  ) async {
    await cart.doc(cartId).update({'TotalQuantity': newQuantity});
  }

  // Xoá sản phẩm khỏi giỏ hàng
  static Future<void> removeProduct(String cartId) async {
    await cart.doc(cartId).delete();
  }

  // Stream danh sách giỏ hàng
  static Stream<List<Cart>> getAllCarts() {
    try {
      return cart.snapshots().map((querySnapshot) {
        return querySnapshot.docs.map((doc) {
          return Cart(
            cartId: doc.id,
            accountId: doc['AccountId'],
            totalPrice: doc['TotalPrice'],
            totalQuantity: doc['TotalQuantity'],
          );
        }).toList();
      });
    } catch (e) {
      print('Error fetching data from Firestore: $e');
      return Stream.value([]); // Return an empty stream in case of an error
    }
  }
}
