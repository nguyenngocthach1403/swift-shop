import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

List<String> list = <String>[' ', 'Momo Wallet', 'Trả sau'];

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
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
  @override
  Widget build(BuildContext context) {
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
            },
          )),
      body: Expanded(
          child: Container(
        width: 600,
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
                      child: _text("Huỳnh Công Hậu | " "+(84)3276637", color,
                          15.0, FontWeight.bold),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15, 8, 0, 0),
                      child: _text("Củ Chi, TP HỒ Chí Minh", color, 15.0,
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
              Container(
                margin: EdgeInsets.only(left: 15),
                width: 360,
                height: 100,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30)),
                child: Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: ListTile(
                    leading: Image.asset(
                      "assets/images/mouse.png",
                    ),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _text("Chuột logitech g102", color, 18.0, weight),
                        _text("400.000đ", color, 18.0, weight)
                      ],
                    ),
                    trailing: Container(
                        child: CircleAvatar(
                      child: Text("x2"),
                      backgroundColor: Colors.grey,
                    )),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, top: 8),
                child: Container(
                  width: 360,
                  height: 100,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30)),
                  child: Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: ListTile(
                      leading: Image.asset(
                        "assets/images/keyboard.png",
                      ),
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _text("Bàn Phím GK301", color, 18.0, weight),
                          _text("500.000đ", color, 18.0, weight)
                        ],
                      ),
                      trailing: Container(
                          child: CircleAvatar(
                        child: Text("x1"),
                        backgroundColor: Colors.grey,
                      )),
                    ),
                  ),
                ),
              ),
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
                          _text("1.300.000", Colors.red, size, FontWeight.bold)
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8, right: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _text("Giá giảm: ", color, size, weight),
                          _text("-300.000", Colors.red, size, FontWeight.bold)
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _text("Thành tiền: ", color, size, weight),
                          _text("1.000.000", Colors.red, size, FontWeight.bold)
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
                  margin: EdgeInsets.only(left: 5),
                  width: 380,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
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
                          text: TextSpan(
                            text: 'Nhấn ',
                            style: TextStyle(
                                fontSize: 13,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                            children: const <TextSpan>[
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
                        child: new Container(
                          padding: new EdgeInsets.only(right: 13.0),
                          child: new Text(
                            'đồng ý tuân theo quy định của shop!',
                            overflow: TextOverflow.ellipsis,
                            style: new TextStyle(
                              fontSize: 13.0,
                              color: new Color(0xFF212121),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ]),
                  )),
              Container(
                margin: EdgeInsets.only(top: 20),
                width: 400,
                height: 100,
                decoration: BoxDecoration(
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
                          _text("1.000.000", Colors.red, 15.0, FontWeight.bold)
                        ],
                      ),
                    ),
                    Container(
                      height: 100,
                      color: Colors.redAccent,
                      child: TextButton(
                        onPressed: () {},
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
