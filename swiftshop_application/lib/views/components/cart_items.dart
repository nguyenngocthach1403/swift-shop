import 'package:flutter/material.dart';

class Cart_Items extends StatefulWidget {
  const Cart_Items({super.key});

  @override
  State<Cart_Items> createState() => _Cart_ItemsState();
}

class _Cart_ItemsState extends State<Cart_Items> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("abc"),
          backgroundColor: Colors.blue,
        ),
        body: Container(
          width: MediaQuery.of(context).size.width - 4,
          height: MediaQuery.of(context).size.height / 6,
          // color: Colors.amber,
          child: Row(children: [
            Image.asset(
              "assets/icons/mouse.jpg",
              height: 500,
              width: 80,
            ),
            SizedBox(
              width: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                    padding: EdgeInsets.only(
                  top: 10,
                  left: 50,
                )),
                Row(
                  children: [
                    Text("Chuột logitech G102"),
                  ],
                ),
                Row(
                  children: [
                    Text("400.000đ"),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFF6088CA),
                        borderRadius: BorderRadius.circular(20),
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
                    SizedBox(
                      width: 30,
                    ),
                    Container(
                        decoration: BoxDecoration(
                          //color: const Color(0xFF6088CA),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red, // Màu nền của nút
                          ),
                          child: Row(
                            children: [
                              Text(
                                "Delete",
                                style: TextStyle(color: Colors.white),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Image.asset(
                                "assets/icons/trash.png",
                                height: 20,
                                width: 20,
                              ),
                            ],
                          ),
                        ))
                  ],
                ),
              ],
            ),
          ]),
        ));
  }
}
