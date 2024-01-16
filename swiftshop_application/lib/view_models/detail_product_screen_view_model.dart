import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:swiftshop_application/data/models/cart_detail.dart';
import 'package:swiftshop_application/data/models/carts.dart';
import 'package:swiftshop_application/data/models/product.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DetailProductScreenViewModel {
  late Product pro;
  int totalProduct = 1;
  final cart_detail = FirebaseFirestore.instance.collection("cart detail");

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

  //lấy tất cả các item của trong cart của Id hiện tại
  Future<List<CartDetail>> getAllCartDetail(String cartId) async {
    QuerySnapshot snap = await cart_detail.get();
    List<CartDetail> lst = [];
    snap.docs.forEach((element) {
      CartDetail newItem = CartDetail(element.id.toString(),
          cartId: element["CartId"].toString(),
          price: element['Price'],
          productId: element['ProductId'].toString(),
          quantity: element['Quantity']);

      if (newItem.cartId == cartId) {
        lst.add(newItem);
      }
    });
    return lst;
  }

  //Kiểm tra item trong cart đã tồn tại hay chưa trả về item đó
  CartDetail checkIsExistProductInCart(
      String productId, List<CartDetail> lstItemOfCart) {
    CartDetail cartDetailIdIsExitsProduct =
        CartDetail('', cartId: '', price: 0, productId: '', quantity: 0);
    for (var i in lstItemOfCart) {
      if (i.productId == productId) {
        cartDetailIdIsExitsProduct = i;
        break;
      }
    }
    return cartDetailIdIsExitsProduct;
  }

  //Thêm  sản phẩm vào của account hiện  tại
  Future<void> addProductToCard(Product pro, int totalProduct) async {
    String cartId =
        await findCartOfAccount(); //Tìm Id cart của tài khoản hiện tại
    List<CartDetail> lstItemCart =
        await getAllCartDetail(cartId); //Lấy tất cả item của cart

    //Lấy docId của item
    CartDetail itemExist = checkIsExistProductInCart(pro.id, lstItemCart);
    //Kiểm tra tồn tại
    //Nếu tồn tại product trong cart rồi thì update
    if (itemExist.cartdetailId != '') {
      //Update số lượng mới
      //Số lượng
      int newQuantity = itemExist.quantity + totalProduct;
      updateItemCart(itemExist.cartdetailId, newQuantity);
    }
    //Tạo mới item cho cart
    else {
      //Cartid của tài khoản hiện tại
      Map<String, dynamic> dataToSave = {
        'CartId': cartId,
        'Price': pro.price,
        'Quantity': totalProduct,
        'ProductId': pro.id,
      };
      cart_detail.doc().set(dataToSave);
      print("Save done");
    }

    //Cập nhật só lượng tổng và tổng giá của toàn bộ cart
    int newPrice = totalProduct *
        (pro.promotionalPrice == 0 ? pro.price : pro.promotionalPrice);
    updateCarts(cartId, totalProduct, newPrice);
  }

  //Lấy CartId của tài khoản hiện tại
  Future<String> findCartOfAccount() async {
    late String accountIdCurrent;
    late String cartId;
    //User ID hiện tại
    accountIdCurrent = FirebaseAuth.instance.currentUser!.uid;
    //Lấy CartId của User hiện tại
    cartId = await FirebaseFirestore.instance
        .collection("carts")
        .doc(accountIdCurrent)
        .id;
    return cartId;
  }

  //Update product exist. Thach 15.1
  Future<void> updateItemCart(String docID, int newQuantity) {
    return cart_detail.doc(docID).update({'Quantity': newQuantity});
  }

  Future<void> updateCarts(
      String cartId, int quantity, int newTotalPrice) async {
    Cart currentCartOfAccount = await Cart.getCartById(cartId);
    int quantityToUp = currentCartOfAccount.totalQuantity + quantity;
    int currentTotalPriceOfCart = currentCartOfAccount.totalPrice;
    int totalPriceToUp = newTotalPrice + currentTotalPriceOfCart;
    Cart.cart
        .doc(currentCartOfAccount.cartId)
        .update({'TotalQuantity': quantityToUp, 'TotalPrice': totalPriceToUp});
  }
}
