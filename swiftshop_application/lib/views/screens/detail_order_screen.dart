import 'package:flutter/material.dart';
import 'package:swiftshop_application/views/components/product_item_of_order.dart';
import 'package:swiftshop_application/views/screens/order_manager_screen.dart';

class Detail_Order_Screen extends StatelessWidget {
  const Detail_Order_Screen({super.key});

  @override
  Widget build(BuildContext context) {
    int totalAmount = 0;
    for (var product in lstProduct) {
      totalAmount += product.quantity * product.price;
    }
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              //  Navigator.of(context).pop();
            },
            icon: Icon(Icons.arrow_back)),
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
                        border: Border(
                          top: BorderSide(
                              color: Colors.grey[300] ?? Colors.grey,
                              width: 1.0), // Đường viền trên
                          bottom: BorderSide(
                              color: Colors.grey[300] ?? Colors.grey,
                              width: 1.0), // Đường viền dưới
                        ),
                      ),
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.fromLTRB(10, 10, 0, 0),
                            child: Text(
                              "Thông tin đơn hàng",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
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
                                        "Hoá đơn :",
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: Color.fromRGBO(
                                                174, 174, 174, 1)),
                                      ),
                                      Text(
                                        "Ngày đặt :",
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: Color.fromRGBO(
                                                174, 174, 174, 1)),
                                      ),
                                      Text(
                                        "Ngày hoàn thành :",
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
                                        "2/1/2024",
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
                        border: Border(
                          top: BorderSide(
                              color: Colors.grey[300] ?? Colors.grey,
                              width: 1.0), // Đường viền trên
                          bottom: BorderSide(
                              color: Colors.grey[300] ?? Colors.grey,
                              width: 1.0), // Đường viền dưới
                        ),
                      ),
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.fromLTRB(10, 10, 0, 0),
                            child: Text(
                              "Địa chỉ nhận hàng",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Row(
                            children: [
                              Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 16)),
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
                                        ),
                                      ),
                                      Text(
                                        "01231231231",
                                        style: TextStyle(
                                          fontSize: 15,
                                        ),
                                      ),
                                      Text(
                                        "65 Huỳnh Thúc Kháng, Quận 1",
                                        style: TextStyle(
                                          fontSize: 15,
                                        ),
                                      ),
                                    ],
                                  ))
                            ],
                          )
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
                    height: 50,
                    decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(
                            color: Colors.grey[300] ?? Colors.grey,
                            width: 1.0), // Đường viền trên
                        bottom: BorderSide(
                            color: Colors.grey[300] ?? Colors.grey,
                            width: 1.0), // Đường viền dưới
                      ),
                    ),
                    margin: const EdgeInsets.all(10),
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        //! Phương thức thanh toán
                        Padding(
                          padding: EdgeInsets.fromLTRB(10, 1, 10, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Phương thức thanh toán :",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
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
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Phần 1 bên trái
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(
                              right:
                                  8.0), // Điều chỉnh khoảng cách qua bên trái
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text.rich(TextSpan(
                                  children: [TextSpan(text: "Tổng tiền:")])),
                              Text.rich(TextSpan(
                                  children: [TextSpan(text: "Giảm giá:")])),
                              Text.rich(TextSpan(
                                  children: [TextSpan(text: "Thành tiền:")])),
                            ],
                          ),
                        ),
                      ),
                      // Phần 2 bên phải
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(left: 100),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text.rich(TextSpan(
                                  children: [TextSpan(text: "$totalAmount")])),
                              Text.rich(
                                  TextSpan(children: [TextSpan(text: "0")])),
                              Text.rich(TextSpan(
                                  children: [TextSpan(text: "$totalAmount")])),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

List<ProductItemOfOrder> lstProduct = [
  const ProductItemOfOrder(
    title: "Sản phẩm 1",
    quantity: 1,
    promotionalPrice: 0,
    price: 15000,
    path: "",
    promotionPrice: 0,
  ),
  const ProductItemOfOrder(
    title: "Sản phẩm 2",
    quantity: 2,
    promotionalPrice: 12000,
    price: 15000,
    path: "",
    promotionPrice: 0,
  ),
  const ProductItemOfOrder(
    title: "Sản phẩm 2",
    quantity: 2,
    promotionalPrice: 12000,
    price: 15000,
    path: "",
    promotionPrice: 0,
  ),
  const ProductItemOfOrder(
    title: "Sản phẩm 2",
    quantity: 2,
    promotionalPrice: 12000,
    price: 15000,
    path: "",
    promotionPrice: 0,
  )
];
