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

import 'package:swiftshop_application/data/models/carts.dart';

class CartViewModel {
  Stream<List<Cart>> cartItemsStream = Cart.getAllCarts();

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
}
