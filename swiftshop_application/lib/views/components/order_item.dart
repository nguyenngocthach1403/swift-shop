import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:swiftshop_application/data/models/format_currency.dart';
import 'package:swiftshop_application/data/models/order.dart';
import 'package:swiftshop_application/data/models/order_item.dart';
import 'package:swiftshop_application/data/models/order_model.dart';
import 'package:swiftshop_application/data/models/product.dart';
import 'package:swiftshop_application/view_models/admin_profile_screen_view_model.dart';
import 'package:swiftshop_application/views/screens/detail_order_screen.dart';
import 'package:swiftshop_application/views/screens/order_manager_screen.dart';

class OrderItem extends StatefulWidget {
  final Orders order;

  const OrderItem({Key? key, required this.order}) : super(key: key);

  @override
  State<OrderItem> createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  AdminScreenViewModel _viewModel = AdminScreenViewModel();

  Future<String> getPositionOfAccount() async {
    String position = "";
    String id = FirebaseAuth.instance.currentUser!.uid;
    CollectionReference accountCol =
        FirebaseFirestore.instance.collection('accounts');
    QuerySnapshot accountSnap = await accountCol.get();
    for (var i in accountSnap.docs) {
      if (i.id == id) {
        position = i['position'];
      }
    }
    return position;
  }

  List<OrderDetail> orderItemList = [];
  Product pro = Product(
      id: '',
      path: '',
      title: '',
      price: 0,
      promotionalPrice: 0,
      type: '',
      quantity: 1,
      quantitySold: 0,
      rate: 0,
      description: '');
  @override
  String posision = "";
  void initState() {
    getPositionOfAccount().then((value) {
      setState(() {
        posision = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (posision.isNotEmpty && posision == "Admin") {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => OrderManagementScreen(
                  orderID: widget.order.orderId,
                  accountId: widget.order.accountId),
            ),
            (route) => false,
          );
        } else {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => Detail_Order_Screen(),
            ),
            (route) => false,
          );
        }
      },
      child: Container(
        width: 145,
        height: MediaQuery.of(context).size.height / 5.5,
        margin: EdgeInsets.fromLTRB(0, 0, 0, 5),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: _text(
                        'Hóa đơn',
                        Colors.grey,
                        13.0,
                        FontWeight.normal,
                      ),
                    ),
                    _text(
                      widget.order.orderId,
                      Colors.black,
                      15.0,
                      FontWeight.bold,
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: _text(
                    widget.order.status,
                    Colors.blueAccent,
                    12.0,
                    FontWeight.normal,
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
              child: Row(
                children: [
                  _text('Ngày đặt: ', Colors.grey, 12.0, FontWeight.normal),
                  _text(
                    AdminScreenViewModel.readTimestamp(widget.order.orderDate),
                    Colors.black,
                    13.0,
                    FontWeight.normal,
                  ),
                ],
              ),
            ),
            // Padding(
            //   padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
            //   child: Row(
            //     children: [
            //       Padding(
            //         padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
            //         child: Image.network(
            //           pro.path,
            //           height: 50,
            //           width: 50,
            //         ),
            //       ),
            //       Expanded(
            //         child: Padding(
            //           padding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
            //           child: Column(
            //             crossAxisAlignment: CrossAxisAlignment.start,
            //             children: [
            //               _text(
            //                 pro.title,
            //                 Colors.black,
            //                 13.0,
            //                 FontWeight.normal,
            //               ),
            //               Padding(padding: EdgeInsets.all(5.0)),
            //               Row(
            //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //                 children: [
            //                   _text(
            //                     'sl: ${pro.quantity}',
            //                     Colors.black,
            //                     13.0,
            //                     FontWeight.normal,
            //                   ),
            //                   _text(
            //                     '${pro.price}đ',
            //                     Colors.black,
            //                     13.0,
            //                     FontWeight.normal,
            //                   ),
            //                 ],
            //               )
            //             ],
            //           ),
            //         ),
            //       )
            //     ],
            //   ),
            // ),
            const Divider(),
            Container(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 0, 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _text(
                      '1 sản phẩm',
                      Colors.grey,
                      15.0,
                      FontWeight.normal,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 8, 0),
                      child: Row(
                        children: [
                          _text(
                            'Thành tiền : ',
                            Colors.black,
                            15.0,
                            FontWeight.normal,
                          ),
                          _text(
                            '${FormatCurrency.stringToCurrency(widget.order.totalPrice.toString())}',
                            Colors.red,
                            15.0,
                            FontWeight.bold,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Text _text(text, color, size, weight) {
    return Text(
      text,
      style: TextStyle(color: color, fontSize: size, fontWeight: weight),
    );
  }
}
