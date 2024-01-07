import 'package:flutter/material.dart';

class DetailProductInfo extends StatefulWidget {
  const DetailProductInfo({Key? key}) : super(key: key);

  @override
  State<DetailProductInfo> createState() => _DetailProductInfoState();
}

class _DetailProductInfoState extends State<DetailProductInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF6088CA),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(40),
          ),
        ),
        title: Row(
          children: [
            IconButton(
              onPressed: () {},
              icon: Image.asset(
                "assets/icons/arrow-back-black.png",
                width: 27,
              ),
            ),
            Text(
              'Back',
              style: TextStyle(fontSize: 18),
            ),
            Spacer(),
            IconButton(
              onPressed: () {},
              icon: Image.asset(
                "assets/icons/shopping-cart-white.png",
                width: 27,
              ),
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Color(0xFF6088CA),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height / 4,
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50),
                ),
              ),
              child: Column(
                children: [
                  SizedBox(height: 130),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Pizza",
                        style: TextStyle(
                            fontSize: 35, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: Image.asset(
                          "assets/icons/clock.jpg",
                          width: 50,
                        ),
                      ),
                      Text(
                        "30min",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 22),
                      ),
                      Spacer(),
                      Padding(
                        padding: EdgeInsets.only(right: 10),
                        child: Row(
                          children: [
                            Image.asset(
                              "assets/icons/star1.png",
                              width: 50,
                            ),
                            SizedBox(width: 5),
                            Text(
                              "4.9",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 22),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Pizza là một loại bánh dẹt, tròn\n"
                        "  được chế biến từ bột mì, nấm\n"
                        "men,... sau khi đã được ủ bột để\n"
                        " nghỉ ít nhất 24 tiếng đồng hồ và\n"
                        "nhào nặn thành loại bánh có hình\n"
                        "dạng tròn và dẹt, và được cho vào\n"
                        "   lò nướng chín trước khi ăn.",
                        style: TextStyle(fontSize: 20),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(25),
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFFEDEDED),
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 3,
                                blurRadius: 10,
                                offset: Offset(0, 5),
                              ),
                            ],
                          ),
                          child: Row(children: [
                            IconButton(
                              icon: Icon(Icons.remove),
                              onPressed: () {},
                              color: Colors.black,
                            ),
                            Text(
                              "2",
                              style: TextStyle(
                                  fontSize: 18.0,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            IconButton(
                              icon: Icon(Icons.add),
                              onPressed: () {},
                              color: Colors.black,
                            ),
                          ]),
                        ),
                      ),
                      Spacer(),
                      Padding(
                        padding: EdgeInsets.only(right: 20),
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF6088CA),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            elevation: 8,
                            minimumSize: Size(200, 50),
                          ),
                          child: Text(
                            "Add to Cart 120.000đ",
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height / 4 - 125,
            left: MediaQuery.of(context).size.width / 2 - 125,
            child: Image.asset(
              "assets/icons/item.jpg",
              width: 250,
            ),
          ),
        ],
      ),
    );
  }
}
