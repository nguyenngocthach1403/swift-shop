import 'package:flutter/material.dart';

class Cart_Items extends StatefulWidget {
  final String productName;
  final double price;
  final int quantity;

  const Cart_Items({
    required this.productName,
    required this.price,
    required this.quantity,
    Key? key,
  }) : super(key: key);

  @override
  State<Cart_Items> createState() => _Cart_ItemsState();
}

String _formatPrice(double price) {
  String priceString = price.toString();
  if (!priceString.contains('.')) {
    return "$priceString.00đ";
  }
  return "$priceStringđ";
}

class _Cart_ItemsState extends State<Cart_Items> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 4,
      height: MediaQuery.of(context).size.height / 6,
      child: Row(
        children: [
          Image.asset(
            "assets/icons/mouse.jpg",
            height: 80,
            width: 80,
          ),
          SizedBox(
            width: 20,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 10, left: 50),
              ),
              Row(
                children: [
                  Text(widget.productName),
                ],
              ),
              Row(
                children: [
                  Text(_formatPrice(widget.price)),
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
                    child: Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.remove),
                          onPressed: () {
                            // TODO: Xử lý giảm số lượng
                          },
                          color: Colors.black,
                        ),
                        Text(
                          "${widget.quantity}",
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.add),
                          onPressed: () {
                            // TODO: Xử lý tăng số lượng
                          },
                          color: Colors.black,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        // TODO: Xử lý xóa sản phẩm khỏi giỏ hàng
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
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
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}