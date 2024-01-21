import 'package:flutter/material.dart';
import 'package:swiftshop_application/data/models/cart_detail.dart';
import 'package:swiftshop_application/data/models/format_currency.dart';
import 'package:swiftshop_application/data/models/product.dart';
import 'package:swiftshop_application/view_models/cart_screen_view_model.dart';

import 'package:swiftshop_application/views/components/cart_items.dart';
import 'package:swiftshop_application/data/models/carts.dart';

class Cart_Screen extends StatefulWidget {
  const Cart_Screen({Key? key}) : super(key: key);

  @override
  State<Cart_Screen> createState() => _Cart_ScreenState();
}

class _Cart_ScreenState extends State<Cart_Screen> {
  CartViewModel cartViewModel = CartViewModel();
  List<CartDetail> carts = [];
  List<Product> products = [];
  double totalPrice = 0.0; // Thêm biến totalPrice
  @override
  void initState() {
    cartViewModel.fetchCartDetailOnLocal().then((value) {
      carts = value;
    });
    cartViewModel.fetchProductFromCartDetail().then((value) {
      setState(() {
        products = value;
      });
    });
    totalPrice = _calculateTotalPrice(carts, products); // Cập nhật totalPrice
    super.initState();
  }

  double _calculateTotalPrice(
      List<CartDetail> cartItems, List<Product> products) {
    double totalPrice = 0.0;
    for (var cartItem in cartItems) {
      Product? product =
          cartViewModel.getProductById(cartItem.productId, products);
      if (product != null) {
        totalPrice += cartItem.quantity * product.price;
      }
    }
    return totalPrice;
  }

  void _updateTotalPrice() {
    setState(() {
      totalPrice = _calculateTotalPrice(carts, products);
    });
  }

  Future<void> _showConfirmationDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Xác nhận'),
          content: const Text('Bạn có muốn tiếp tục thanh toán?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Nút Hủy
              },
              child: const Text('Hủy'),
            ),
            TextButton(
              onPressed: () {
                _handlePaymentSuccess();
                Navigator.of(context).pop(); // Nút OK
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
/// tùng thực hiện thanh toán khi thành công
  void _handlePaymentSuccess() {
    cartViewModel.clearCart(); // Xoá các sản phẩm trong giỏ hàng
    _updateTotalPrice(); // Cập nhật giá trị tổng
    // Hiển thị thông báo thanh toán thành công
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Thanh toán thành công!'),
        duration: const Duration(seconds: 2),
      ),
    );
    // Quay lại trang chủ
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Image.asset(
            "assets/icons/arrow-back-black.png",
            width: 23,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          "Cart",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: carts.length,
              itemBuilder: (context, index) {
                return Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    width: 390,
                    height: 145,
                    margin: EdgeInsets.only(
                      bottom: 10,
                    ),
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3),
                        ),
                      ],
                      border: Border.all(
                        color: Colors.white,
                      ),
                    ),
                    child: Cart_Items(
                      cartItem: carts[index],
                      products: products,
                      onIncreaseQuantity: () {
                        cartViewModel.increaseQuantity(carts[index].cartId);
                        _updateTotalPrice();
                      },
                      onDecreaseQuantity: () {
                        cartViewModel.decreaseQuantity(carts[index].cartId);
                        _updateTotalPrice();
                      },
                      onRemoveProduct: () {
                        cartViewModel.deleteItem(carts[index].cartdetailId);
                        cartViewModel.fetchCartDetailOnLocal().then((value) {
                          carts = value;
                        });
                        cartViewModel
                            .fetchProductFromCartDetail()
                            .then((value) {
                          products = value;
                          _updateTotalPrice();
                          setState(() {});
                        });
                      },
                      onQuantityChanged: () {},
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            width: 500,
            height: 150,
            padding: EdgeInsets.all(16),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20)),
              color: Color.fromRGBO(96, 136, 202, 1),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Total:",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      FormatCurrency.stringToCurrency(
                          _calculateTotalPrice(carts, products)
                              .toStringAsFixed(0)),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    _showConfirmationDialog(); // Hiển thị hộp thoại xác nhận
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(255, 199, 0, 1),
                    minimumSize: Size(double.infinity, 50),
                  ),
                  child: const Text(
                    "Thanh toán",
                    style: TextStyle(fontSize: 20, color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
