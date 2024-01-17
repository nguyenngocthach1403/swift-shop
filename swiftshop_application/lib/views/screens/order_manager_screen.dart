import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:swiftshop_application/data/models/format_currency.dart';
import 'package:swiftshop_application/data/models/order.dart';
import 'package:swiftshop_application/data/models/product_of_order.dart';
import 'package:swiftshop_application/data/models/user.dart';
import 'package:swiftshop_application/view_models/order_management_screen_view_model.dart';
import 'package:swiftshop_application/views/components/product_item_of_order.dart';

class OrderManagementScreen extends StatefulWidget {
  OrderManagementScreen(
      {super.key, required this.orderID, required this.accountId});
  String orderID;
  String accountId;

  @override
  State<OrderManagementScreen> createState() => _OrderManagementScreenState();
}

class _OrderManagementScreenState extends State<OrderManagementScreen> {
  OrderManagementViewModel _viewModel = OrderManagementViewModel();
  Orders order = Orders(
      orderId: '',
      accountId: '',
      address: '',
      orderDate: Timestamp.now(),
      status: '',
      totalPrice: 0);
  Users user = Users(
      accountId: '',
      address: '',
      email: '',
      fullname: '',
      path: '',
      phoneNumber: '',
      position: '');
  List<ProductOfOrder> productOfOrder = [];
  List<ProductItemOfOrder> lstProduct = [];

  var dropDownValue = " ";
  bool isDropdownButtonEnable = true;
  var _items = ['Xác nhận', 'Giao hàng', ' '];
  @override
  void initState() {
    _viewModel.getOrderById(widget.orderID, widget.accountId).then((value) {
      setState(() {
        order = value;
        order.status == "Cho duyet" || order.status == 'Da duyet'
            ? isDropdownButtonEnable = true
            : isDropdownButtonEnable = false;
      });
    });
    _viewModel.getUser(widget.accountId).then((value) {
      setState(() {
        user = value;
      });
    });
    _viewModel.getProductOfOrderItem(widget.orderID).then((value) {
      setState(() {
        productOfOrder = value;
        for (var i in productOfOrder) {
          lstProduct.add(ProductItemOfOrder(
              title: i.name,
              promotionPrice: i.promotionalPrice,
              path: i.path,
              quantity: i.quantity,
              promotionalPrice: i.promotionalPrice,
              price: i.price));
        }
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.arrow_back))
          ],
        ),
      ),
      bottomSheet: Container(
        height: 60,
        width: MediaQuery.of(context).size.width,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: dropDownValue == " "
                ? const Color.fromRGBO(141, 141, 141, 1)
                : const Color.fromRGBO(96, 136, 202, 1),
            borderRadius: BorderRadius.circular(50)),
        child: const Text(
          "Xác nhận",
          style: TextStyle(
              fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(30, 0, 0, 5),
            child: Text(
              "Chi tiết đơn hàng",
              style: TextStyle(fontSize: 25),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 40,
            color: _viewModel.returnColorStatus(order.status),
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
              child: Text(
                "Đơn hàng ${_viewModel.returnNameStatus(order.status)}",
                style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height - 250,
            child: SingleChildScrollView(
              child: Column(
                children: [
//? Order Summary
                  Container(
                      width: MediaQuery.of(context).size.width,
                      height: 180,
                      margin: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: const Color.fromRGBO(242, 242, 242, 1),
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.fromLTRB(10, 10, 0, 0),
                            child: Text(
                              "Order Summary",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Expanded(
                              child: Row(
                            children: [
                              const Expanded(
                                flex: 2,
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(0, 0, 5, 0),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        "Order number :",
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: Color.fromRGBO(
                                                174, 174, 174, 1)),
                                      ),
                                      Text(
                                        "Order date :",
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: Color.fromRGBO(
                                                174, 174, 174, 1)),
                                      ),
                                      Text(
                                        "Total Item :",
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: Color.fromRGBO(
                                                174, 174, 174, 1)),
                                      ),
                                      Text(
                                        "Status :",
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: Color.fromRGBO(
                                                174, 174, 174, 1)),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                  flex: 5,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        order.orderId,
                                        style: const TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        "${_viewModel.readTimestamp(order.orderDate)}",
                                        style: const TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        "${productOfOrder.length}",
                                        style: const TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        _viewModel
                                            .returnNameStatus(order.status),
                                        style: const TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ))
                            ],
                          ))
                        ],
                      )),
//? Imformation Receiver
                  Container(
                      width: MediaQuery.of(context).size.width,
                      height: 150,
                      margin: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: const Color.fromRGBO(242, 242, 242, 1),
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.fromLTRB(10, 10, 0, 0),
                            child: Text(
                              "Informantion Receiver",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Expanded(
                              child: Row(
                            children: [
                              const Expanded(
                                  flex: 2,
                                  child: Padding(
                                    padding: EdgeInsets.fromLTRB(0, 0, 5, 0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          "Tên người nhận :",
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Color.fromRGBO(
                                                  174, 174, 174, 1)),
                                        ),
                                        Text(
                                          "Số điện thoại :",
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Color.fromRGBO(
                                                  174, 174, 174, 1)),
                                        ),
                                        Text(
                                          "Địa chỉ :",
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Color.fromRGBO(
                                                  174, 174, 174, 1)),
                                        ),
                                      ],
                                    ),
                                  )),
                              Expanded(
                                  flex: 5,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        user.fullname,
                                        style: const TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        user.phoneNumber,
                                        style: const TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        user.address,
                                        style: const TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ))
                            ],
                          ))
                        ],
                      )),
//? Product item list of order
                  Column(
                    children: List.generate(
                        lstProduct.length, (index) => lstProduct[index]),
                  ),
//! Tổng kết đơn
                  Container(
                      width: MediaQuery.of(context).size.width,
                      height: 100,
                      margin: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: const Color.fromRGBO(242, 242, 242, 1),
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Total Price :",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                //! Tổng tiền
                                Text(
                                  FormatCurrency.stringToCurrency(
                                      order.totalPrice.toString()),
                                  style: const TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red),
                                )
                              ],
                            ),
                          ),
                          //! Phương thức thanh toán
                          const Padding(
                            padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Phương thức thanh toán :",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "Momo",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      )),
//!Duyệt đơn
                  Container(
                      width: MediaQuery.of(context).size.width,
                      height: 40,
                      margin: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: const Color.fromRGBO(242, 242, 242, 1),
                          borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: Text(
                                "Cập nhận trạng thái đơn hàng:",
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              )),
                          Padding(
                            padding: const EdgeInsets.only(right: 20),
                            child: DropdownButton(
                              items: _items.map((String e) {
                                return DropdownMenuItem(
                                  child: Text(e),
                                  value: e,
                                );
                              }).toList(),
                              onChanged: isDropdownButtonEnable
                                  ? (String? newValue) => setState(() {
                                        dropDownValue = newValue!;
                                      })
                                  : null,
                              value: dropDownValue,
                              underline: Container(
                                color: const Color.fromRGBO(242, 242, 242, 1),
                              ),
                            ),
                          )
                        ],
                      ))
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
