import 'dart:math';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:swiftshop_application/data/models/cart_detail.dart';
import 'package:swiftshop_application/data/models/format_currency.dart';
import 'package:swiftshop_application/data/models/product.dart';
import 'package:swiftshop_application/data/models/user_model.dart';
import 'package:swiftshop_application/view_models/payment_screen_view_model.dart';
import 'package:swiftshop_application/views/components/product_item_of_order.dart';

List<String> list = <String>[' ', 'Momo Wallet', 'Trả sau'];

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key, this.cartId});
  final cartId;
  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  PaymentScreenViewModel _viewModel = PaymentScreenViewModel();
  Color color = Colors.black;
  late String text;
  double size = 13.0;
  FontWeight weight = FontWeight.normal;
  Text _text(text, color, size, weight) {
    return Text(
      text,
      style: TextStyle(color: color, fontSize: size, fontWeight: weight),
    );
  }

  String dropdownValue = list.first;

  //Info receiver
  UserModel receiverIf = UserModel(
      accountId: '', fullname: '', email: '', phonenumber: '', address: '');
  //List product
  List<ProductItemOfOrder> product = [];
  List<Product> productInfo = [];
  List<CartDetail> cartdetails = [];
  @override
  void initState() {
    _viewModel.userInfomation().then((value) {
      setState(() {
        receiverIf = value;
      });
    });
    _viewModel.loadCartOnFirebase().then((value) {
      setState(() {
        cartdetails = value;
      });
    });
    _viewModel.fetchProductFromCartDetail().then((value) {
      setState(() {
        productInfo = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    for (var i in productInfo) {
      for (var j in cartdetails) {
        if (i.id == j.productId) {
          ProductItemOfOrder proItem = ProductItemOfOrder(
              title: i.title,
              quantity: j.quantity,
              promotionalPrice: i.promotionalPrice,
              price: j.price * j.quantity,
              promotionPrice: i.promotionalPrice,
              path: i.path);
          if (product.isEmpty) {
            product.add(proItem);
          } else {
            bool isExist = false;
            product.forEach((element) {
              if (element.title == proItem.title) {
                isExist = true;
              }
            });
            if (isExist == false) {
              product.add(proItem);
            }
          }
        }
      }
    }
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Color.fromRGBO(96, 136, 202, 1),
          leading: IconButton(
            icon: FaIcon(
              FontAwesomeIcons.arrowLeft,
              color: Colors.black,
            ),
            onPressed: () {
              // do something
              Navigator.pop(context);
            },
          )),
      body: Expanded(
          child: Container(
        width: 600,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          color: Color.fromRGBO(96, 136, 202, 1),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: _text("Thanh Toán", Colors.white, 21.0, FontWeight.bold),
              ),
              Container(
                width: 400,
                height: 150,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: FaIcon(FontAwesomeIcons.locationDot),
                          ),
                          _text("Địa chỉ", color, size, FontWeight.bold)
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: _text(
                          "${receiverIf.fullname} | "
                          "+(84) ${receiverIf.phonenumber}",
                          color,
                          15.0,
                          FontWeight.bold),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15, 8, 0, 0),
                      child: _text("${receiverIf.address}", color, 15.0,
                          FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 8, 0, 0),
                child: _text(
                    "Danh sách sản phẩm", Colors.white, 15.0, FontWeight.bold),
              ),
              Column(
                children:
                    List.generate(product.length, (index) => product[index]),
              ),

              // Container(
              //   margin: EdgeInsets.only(left: 15),
              //   width: 360,
              //   height: 100,
              //   decoration: BoxDecoration(
              //       color: Colors.white,
              //       borderRadius: BorderRadius.circular(30)),
              //   child: Padding(
              //     padding: const EdgeInsets.only(right: 10),
              //     child: ListTile(
              //       leading: Image.asset(
              //         "assets/images/mouse.png",
              //       ),
              //       title: Column(
              //         crossAxisAlignment: CrossAxisAlignment.start,
              //         children: [
              //           _text("Chuột logitech g102", color, 18.0, weight),
              //           _text("400.000đ", color, 18.0, weight)
              //         ],
              //       ),
              //       trailing: Container(
              //           child: CircleAvatar(
              //         child: Text("x2"),
              //         backgroundColor: Colors.grey,
              //       )),
              //     ),
              //   ),
              // ),
              // Padding(
              //   padding: const EdgeInsets.only(left: 15, top: 8),
              //   child: Container(
              //     width: 360,
              //     height: 100,
              //     decoration: BoxDecoration(
              //         color: Colors.white,
              //         borderRadius: BorderRadius.circular(30)),
              //     child: Padding(
              //       padding: const EdgeInsets.only(right: 10),
              //       child: ListTile(
              //         leading: Image.asset(
              //           "assets/images/keyboard.png",
              //         ),
              //         title: Column(
              //           crossAxisAlignment: CrossAxisAlignment.start,
              //           children: [
              //             _text("Bàn Phím GK301", color, 18.0, weight),
              //             _text("500.000đ", color, 18.0, weight)
              //           ],
              //         ),
              //         trailing: Container(
              //             child: CircleAvatar(
              //           child: Text("x1"),
              //           backgroundColor: Colors.grey,
              //         )),
              //       ),
              //     ),
              //   ),
              // ),
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 8, 0, 8),
                child: _text(
                    "Chi tiết hóa đơn", Colors.white, 15.0, FontWeight.bold),
              ),
              Container(
                margin: EdgeInsets.only(left: 5),
                width: 380,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _text("Tổng tiền: ", color, size, weight),
                          _text(
                              FormatCurrency.stringToCurrency(
                                  _viewModel.returnTotalPrice(cartdetails)),
                              Colors.red,
                              size,
                              FontWeight.bold)
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8, right: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _text("Giá giảm: ", color, size, weight),
                          _text("0", Colors.red, size, FontWeight.bold)
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _text("Thành tiền: ", color, size, weight),
                          _text(
                              FormatCurrency.stringToCurrency(
                                  _viewModel.returnTotalPrice(cartdetails)),
                              Colors.red,
                              size,
                              FontWeight.bold)
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: _text("Phương thức thanh toán", Colors.white, 15.0,
                    FontWeight.bold),
              ),
              Container(
                  margin: const EdgeInsets.only(left: 5),
                  width: 380,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(Icons.wallet),
                      ),
                      _text("Phương thức thanh toán", color, size,
                          FontWeight.bold),
                      DropdownButton<String>(
                        value: dropdownValue,
                        icon: const Icon(Icons.arrow_downward),
                        onChanged: (String? value) {
                          setState(() {
                            dropdownValue = value!;
                          });
                        },
                        items:
                            list.map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      )
                    ],
                  )),
              Container(
                  margin: EdgeInsets.only(left: 5, top: 8),
                  width: 380,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 20,
                    ),
                    child: Row(children: [
                      Icon(Icons.description),
                      Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: RichText(
                          text: const TextSpan(
                            text: 'Nhấn ',
                            style: TextStyle(
                                fontSize: 13,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                            children: <TextSpan>[
                              TextSpan(
                                  text: '"Đặt Hàng" ',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red)),
                            ],
                          ),
                        ),
                      ),
                      Flexible(
                        child: Container(
                          padding: const EdgeInsets.only(right: 13.0),
                          child: const Text(
                            'đồng ý tuân theo quy định của shop!',
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 13.0,
                              color: Color(0xFF212121),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ]),
                  )),
              Container(
                margin: const EdgeInsets.only(top: 20),
                width: 400,
                height: 100,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _text(
                              "Tổng thanh toán", color, 15.0, FontWeight.bold),
                          _text(
                              FormatCurrency.stringToCurrency(
                                  _viewModel.returnTotalPrice(cartdetails)),
                              Colors.red,
                              15.0,
                              FontWeight.bold)
                        ],
                      ),
                    ),
                    Container(
                      height: 100,
                      color: Colors.redAccent,
                      child: TextButton(
                        onPressed: () {
                          if (dropdownValue == ' ') {
                            const AlertDialog(
                              content:
                                  Text('Vui long chon hinh thuc thanh toan'),
                            );
                          } else {
                            _viewModel.createNewOrder(receiverIf, cartdetails)
                                ? Navigator.pushNamedAndRemoveUntil(
                                    context, '/homepage', (route) => false)
                                : const AlertDialog(
                                    content: Text(
                                        'Thanh toán không thành công vui lòng thử lại!'),
                                  );
                          }
                        },
                        child: _text(
                            "Đặt Hàng", Colors.white, 20.0, FontWeight.bold),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      )),
    );
  }
}
