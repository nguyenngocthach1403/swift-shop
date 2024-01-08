import 'package:flutter/material.dart';
import 'package:swiftshop_application/views/components/product_item_of_order.dart';

class OrderManagementScreen extends StatefulWidget {
  const OrderManagementScreen({super.key});

  @override
  State<OrderManagementScreen> createState() => _OrderManagementScreenState();
}

class _OrderManagementScreenState extends State<OrderManagementScreen> {
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
                ? Color.fromRGBO(141, 141, 141, 1)
                : Color.fromRGBO(96, 136, 202, 1),
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
            color: const Color.fromRGBO(65, 235, 184, 1),
            alignment: Alignment.centerLeft,
            child: const Padding(
              padding: EdgeInsets.fromLTRB(30, 0, 0, 0),
              child: Text(
                "Đơn hàng đã hoàn thành",
                style: TextStyle(
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
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
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
                              Expanded(
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
                                        "#ADAGKDU32",
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        "1/1/2024",
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        "2",
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        "Thành công",
                                        style: TextStyle(
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
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
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
                              Expanded(
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
                                        "Đỗ Thanh Tùng",
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        "01231231231",
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        "65 Huỳnh Thúc Kháng, Quận 1",
                                        style: TextStyle(
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
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Total Price :",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                //! Tổng tiền
                                Text(
                                  "20.000.000đ",
                                  style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red),
                                )
                              ],
                            ),
                          ),
                          //! Phương thức thanh toán
                          Padding(
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
                              onChanged: (String? newValue) => setState(() {
                                dropDownValue = newValue!;
                              }),
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

var dropDownValue = "Xác nhận";
var _items = ['Xác nhận', 'Giao hàng', ' '];
List<ProductItemOfOrder> lstProduct = [
  const ProductItemOfOrder(
      title: "Sản phẩm 1", quantity: 1, promotionalPrice: 0, price: 15000),
  const ProductItemOfOrder(
      title: "Sản phẩm 2", quantity: 2, promotionalPrice: 12000, price: 15000),
  const ProductItemOfOrder(
      title: "Sản phẩm 2", quantity: 2, promotionalPrice: 12000, price: 15000),
  const ProductItemOfOrder(
      title: "Sản phẩm 2", quantity: 2, promotionalPrice: 12000, price: 15000)
];
