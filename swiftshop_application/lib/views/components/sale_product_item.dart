import 'package:flutter/material.dart';
import 'package:swiftshop_application/data/models/product.dart';
import 'package:swiftshop_application/data/models/format_currency.dart'; //? Format tiền kiểu int thành String VND

class Item extends StatefulWidget {
  const Item({super.key, required this.products});
  final Product products;

  @override
  State<Item> createState() => _ItemState();
}

class _ItemState extends State<Item> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        margin: EdgeInsets.fromLTRB(10, 5, 5, 10),
        width: MediaQuery.of(context).size.width / 2 - 20,
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
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                //Thach 1/10 6:00 PM Thêm chiều rộng, chiều cao của hình
                width: 230,
                height: 160,
                child: widget.products.path.isNotEmpty
                    ? Image(
                        image: NetworkImage(widget.products.path),
                        width: 230,
                        fit: BoxFit.cover,
                      )
                    : Image.asset(
                        "assets/images/piza.png",
                        width: 230,
                      ),
                // child: NetworkImage.asset(
                //   "assets/images/piza.png",
                //   width: 230,
                // ),
              ),
              SizedBox(height: 10.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    widget.products.title.length > 13
                        ? widget.products.title.substring(0, 14)
                        : widget.products.title,
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
                widget.products.type.length > 20
                    ? widget.products.type.substring(0, 20)
                    : widget.products.type,
                style: const TextStyle(fontSize: 13, color: Colors.grey),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 50,
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        color: const Color.fromRGBO(96, 136, 202, 1),
                        borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          "${widget.products.rate}",
                          style: const TextStyle(
                              fontSize: 10, color: Colors.white),
                        ),
                        const Icon(
                          Icons.star,
                          color: Colors.yellow,
                          size: 13,
                        )
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        //Thạch 10/1 5:21PM sửa format tiền thành kiểu VND
                        widget.products.promotionalPrice.isEmpty ||
                                widget.products.promotionalPrice == '0'
                            ? ""
                            : widget.products.price,
                        style: const TextStyle(
                            decoration: TextDecoration.lineThrough,
                            fontSize: 12),
                        softWrap: true,
                      ),
                      Text(
                        widget.products.promotionalPrice.isEmpty ||
                                widget.products.promotionalPrice == '0'
                            ? FormatCurrency.stringToCurrency(
                                widget.products.price)
                            : FormatCurrency.stringToCurrency(
                                widget.products.promotionalPrice),
                        style: const TextStyle(fontSize: 12),
                        softWrap: true,
                      ),
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
