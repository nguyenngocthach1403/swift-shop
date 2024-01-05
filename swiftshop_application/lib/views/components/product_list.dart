import 'package:flutter/material.dart';

class ProductItem extends StatefulWidget {
  const ProductItem({super.key});

  @override
  State<ProductItem> createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
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
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 3,
              blurRadius: 5,
              offset: Offset(0, 8),
            ),
          ],
        ),
        height: MediaQuery.of(context).size.height / 6.5,
        width: MediaQuery.of(context).size.width - 15,
        child: Row(
          children: [
            Container(
                margin: EdgeInsets.only(left: 15),
                padding: EdgeInsets.all(2),
                width: 90,
                height: 90,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.white),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 3,
                      blurRadius: 5,
                      offset: Offset(0, 8),
                    ),
                  ],
                  borderRadius: BorderRadius.circular(15),
                ),
                child: CircleAvatar(
                  backgroundImage: AssetImage("assets/icons/item.jpg"),
                )),
            SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 25),
                  child: Row(
                    children: [Text("Item 1 pizza xúc xích Đức thơm ngonnn")],
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Text(
                      "nếu có loại",
                      style: TextStyle(color: Colors.grey[400]),
                    ),
                    SizedBox(width: 158),
                    Text("sl: 1")
                  ],
                ),
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 120),
                      child: Text(
                        "120.000đ",
                        style: TextStyle(
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Text(
                      "100.000đ",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.redAccent,
                          fontSize: 15),
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
