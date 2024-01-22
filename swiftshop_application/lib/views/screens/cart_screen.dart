// import 'package:flutter/material.dart';
// import 'package:swiftshop_application/view_models/cart_screen_view_model.dart';
// import 'package:swiftshop_application/views/components/cart_items.dart';
// import 'package:swiftshop_application/data/models/carts.dart';

// class Cart_Screen extends StatefulWidget {
//   const Cart_Screen({Key? key}) : super(key: key);

//   @override
//   State<Cart_Screen> createState() => _Cart_ScreenState();
// }

// class _Cart_ScreenState extends State<Cart_Screen> {
//   CartViewModel cartViewModel = CartViewModel();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           icon: Image.asset(
//             "assets/icons/arrow-back-black.png",
//             width: 23,
//           ),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//         title: const Text(
//           "Cart",
//           style: TextStyle(fontWeight: FontWeight.bold),
//         ),
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: StreamBuilder<List<Cart>>(
//               stream: cartViewModel.cartItemsStream,
//               builder: (context, snapshot) {
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return CircularProgressIndicator();
//                 } else if (snapshot.hasError) {
//                   return Text('Error: ${snapshot.error}');
//                 } else {
//                   List<Cart> cartItems = snapshot.data ?? [];
//                   return ListView.builder(
//                     itemCount: cartItems.length,
//                     itemBuilder: (context, index) {
//                       return Align(
//                         alignment: Alignment.topCenter,
//                         child: Container(
//                           width: 390,
//                           height: 145,
//                           margin: EdgeInsets.only(
//                             bottom: 10,
//                           ),
//                           padding: EdgeInsets.all(16),
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(20),
//                             color: Colors.white,
//                             boxShadow: [
//                               BoxShadow(
//                                 color: Colors.grey.withOpacity(0.5),
//                                 spreadRadius: 5,
//                                 blurRadius: 7,
//                                 offset: Offset(0, 3),
//                               ),
//                             ],
//                             border: Border.all(
//                               color: Colors.white,
//                             ),
//                           ),
//                           child: Cart_Items(
//                             cartItem: cartItems[index],
//                           ),
//                         ),
//                       );
//                     },
//                   );
//                 }
//               },
//             ),
//           ),
//           Container(
//             width: 500,
//             height: 150,
//             padding: EdgeInsets.all(16),
//             decoration: const BoxDecoration(
//               borderRadius: BorderRadius.only(
//                   topLeft: Radius.circular(20), topRight: Radius.circular(20)),
//               color: Color.fromRGBO(96, 136, 202, 1),
//             ),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     const Text(
//                       "Total:",
//                       style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         color: Colors.white,
//                         fontSize: 18,
//                       ),
//                     ),
//                     StreamBuilder<List<Cart>>(
//                       stream: cartViewModel.cartItemsStream,
//                       builder: (context, snapshot) {
//                         if (snapshot.connectionState ==
//                             ConnectionState.waiting) {
//                           return CircularProgressIndicator();
//                         } else if (snapshot.hasError) {
//                           return Text('Error: ${snapshot.error}');
//                         } else {
//                           double totalPrice = 0.0;
//                           List<Cart> cartItems = snapshot.data ?? [];
//                           for (var item in cartItems) {
//                             totalPrice += item.totalPrice;
//                           }
//                           return Text(
//                             "${totalPrice.toStringAsFixed(0)}",
//                             style: const TextStyle(
//                               fontWeight: FontWeight.bold,
//                               color: Colors.white,
//                               fontSize: 18,
//                             ),
//                           );
//                         }
//                       },
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: 10),
//                 ElevatedButton(
//                   onPressed: () {
//                     // TODO: Xử lý thanh toán
//                   },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: const Color.fromRGBO(255, 199, 0, 1),
//                     minimumSize: Size(double.infinity, 50),
//                   ),
//                   child: const Text(
//                     "Thanh toán",
//                     style: TextStyle(fontSize: 20, color: Colors.black),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

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
            child: StreamBuilder<List<Cart>>(
              stream: cartViewModel.cartItemsStream,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  List<Cart> cartItems = snapshot.data ?? [];
                  return ListView.builder(
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
                            cartItem: carts[index],
                            products: products,
                            onIncreaseQuantity: () {
                              cartViewModel
                                  .increaseQuantity(cartItems[index].cartId);
                            },
                            onDecreaseQuantity: () {
                              cartViewModel
                                  .decreaseQuantity(cartItems[index].cartId);
                            },
                            onRemoveProduct: () {
                              cartViewModel
                                  .removeProduct(cartItems[index].cartId);
                            },
                            onQuantityChanged: () {},
                            productName: 's',
                          ),
                        ),
                      );
                    },
                  );
                }
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
                  onPressed: () {},
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
