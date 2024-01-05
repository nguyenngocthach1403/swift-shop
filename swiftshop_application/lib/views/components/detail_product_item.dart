import 'package:flutter/material.dart';

class DetailItemProduct extends StatefulWidget {
  const DetailItemProduct({super.key});

  @override
  State<DetailItemProduct> createState() => _DetailItemProductState();
}

class _DetailItemProductState extends State<DetailItemProduct> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(""),
        backgroundColor: Colors.blue,
      ),
      body: Container(
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          color: Colors.white,
          borderRadius: BorderRadius.circular(13.0),
        ),
        height: MediaQuery.of(context).size.height / 4.8,
        width: MediaQuery.of(context).size.width - 15,
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.only(left: 5),
              width: 142,
              height: 142,
              child: const CircleAvatar(
                backgroundImage: AssetImage("assets/icons/item.jpg"),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 12),
                      child: Text("Item 001",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                    ),
                    SizedBox(width: 107),
                    IconButton(
                      icon: Image.asset(
                        "assets/icons/edit.png",
                        width: 25,
                      ),
                      onPressed: () {
                        // Add your onPressed logic here
                      },
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text("Giá:    120.000đ",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold)),
                  ],
                ),
                Row(
                  children: [
                    Text("Đã bán:   200",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold)),
                  ],
                ),
                SizedBox(height: 5),
                Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 5),
                      padding: const EdgeInsets.all(6),
                      width: 75,
                      height: 32,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.black),
                      child: Row(
                        children: [
                          Image.asset(
                            "assets/icons/star1.png",
                            width: 20,
                          ),
                          SizedBox(width: 15),
                          Text(
                            "4.5",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 15),
                          )
                        ],
                      ),
                    ),
                    SizedBox(width: 10),
                    Container(
                      margin: EdgeInsets.only(top: 5),
                      padding: const EdgeInsets.all(6),
                      width: 145,
                      height: 32,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Color(0xFFE1E1E1)),
                      child: Row(
                        children: [Text("Số lượng tồn:     100")],
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 115),
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          // ignore: deprecated_member_use
                          backgroundColor: Color(0xFFE55B5B),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Delete",
                              style: TextStyle(color: Colors.black),
                            ),
                            SizedBox(width: 7),
                            Image.asset(
                              "assets/icons/trash.png",
                              width: 20,
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
