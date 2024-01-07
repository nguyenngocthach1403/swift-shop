import 'package:flutter/material.dart';
import 'package:swiftshop_application/views/components/cart_items.dart';

class Cart_Screen extends StatefulWidget {
  const Cart_Screen({super.key});

  @override
  State<Cart_Screen> createState() => _Cart_ScreenState();
}

class _Cart_ScreenState extends State<Cart_Screen> {
  List<Cart_Items> cartItems = [
    Cart_Items(productName: "chuột không dây", price: 800000, quantity: 2),
    Cart_Items(productName: "Bàn phím", price: 400000, quantity: 2),
  ];

  double calculateTotalPrice() {
    double totalPrice = 0.0;
    for (var item in cartItems) {
      totalPrice += item.price;
    }
    return totalPrice;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Cart",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cartItems.length,
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
                      productName: cartItems[index].productName,
                      price: cartItems[index].price.toDouble(),
                      quantity: cartItems[index].quantity,
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
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.blue,
            ),
            child: Column(
              mainAxisAlignment:
                  MainAxisAlignment.spaceBetween, // Đặt nút ở cuối Container
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
                      "${calculateTotalPrice().toStringAsFixed(0)}",
                      style: TextStyle(
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
                    // TODO: Xử lý thanh toán
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xFFFFC700), // Đặt màu vàng cho nút
                    minimumSize: Size(double.infinity, 50),
                  ),
                  child: Text("Thanh toán"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
