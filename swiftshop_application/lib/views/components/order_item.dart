import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class OrderItem extends StatefulWidget {
  const OrderItem({super.key});

  @override
  State<OrderItem> createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
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

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350,
      height: 145,
      margin: EdgeInsets.fromLTRB(0, 0, 0, 5),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(8)),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child:
                        _text("Hóa đơn", Colors.grey, 13.0, FontWeight.normal),
                  ),
                  _text("#DKAJ12KD", Colors.black, 15.0, FontWeight.bold),
                ],
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: _text(
                    "Chờ xác nhận", Colors.blueAccent, 12.0, FontWeight.normal),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
            child: Row(
              children: [
                _text("Ngày đặt: ", Colors.grey, 12.0, weight),
                _text("5-1-2014", Colors.black, 13.0, weight),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                  child: Image.asset(
                    "assets/images/piza.png",
                  ),
                ),
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _text(
                          "Item 1 pizza xúc xích Đức thơm ngonnnnnnnnn....."
                                      .length >
                                  45
                              ? "Item 1 pizza xúc xích Đức thơm ngonnnnnnnnn....."
                                  .substring(0, 45)
                              : "Item 1 pizza xúc xích Đức thơm ngonnnnnnnnn.....  ",
                          color,
                          13.0,
                          weight),
                      Padding(padding: EdgeInsets.all(5.0)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _text("sl: 1", color, 13.0, weight),
                          _text("120.000đ", color, 13.0, weight)
                        ],
                      )
                    ],
                  ),
                ))
              ],
            ),
          ),
          const Divider(),
          Container(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 0, 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _text("1 sản phẩm", Colors.grey, size, weight),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 8, 0),
                    child: Row(
                      children: [
                        _text("Thành tiền :  ", color, size, weight),
                        _text("120.000", Colors.red, size, FontWeight.bold)
                      ],
                    ),
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
