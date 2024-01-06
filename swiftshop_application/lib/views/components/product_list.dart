import 'package:flutter/material.dart';

class Item extends StatelessWidget {
  const Item({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 5),
          child: Row(children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 7),
              child: Container(
                width: 250,
                height: 350,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 3,
                          blurRadius: 10,
                          offset: Offset(0, 3))
                    ]),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset("assets/images/piza.png"),
                      SizedBox(height: 10.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "San pham 1",
                            style: TextStyle(fontSize: 17),
                          ),
                          Material(
                            child: Ink(
                              width: 25,
                              height: 25,
                              decoration: const ShapeDecoration(
                                color: Color.fromRGBO(96, 136, 202, 1),
                                shape: CircleBorder(),
                              ),
                              child: IconButton(
                                padding: EdgeInsets.all(4),
                                iconSize: 15,
                                icon: const Icon(Icons.shopping_cart_rounded),
                                color: Colors.white,
                                onPressed: () {},
                              ),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "San pham 1",
                        style: TextStyle(fontSize: 13, color: Colors.grey),
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 50,
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                color: Color.fromRGBO(96, 136, 202, 1),
                                borderRadius: BorderRadius.circular(10)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  "4.5",
                                  style: TextStyle(fontSize: 10),
                                ),
                                Icon(
                                  Icons.star,
                                  size: 13,
                                )
                              ],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "100.000d ",
                                style: TextStyle(
                                    decoration: TextDecoration.lineThrough),
                              ),
                              Text("100.000d"),
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
