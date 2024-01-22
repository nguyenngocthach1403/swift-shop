import 'package:flutter/material.dart';
import 'package:swiftshop_application/data/models/product.dart';
import 'package:swiftshop_application/view_models/home_screen_view_model.dart';
import 'package:swiftshop_application/views/screens/detail_product_screen.dart'; //? Format tiền kiểu int thành String VND

class Item extends StatefulWidget {
  const Item({super.key, required this.products, required this.addToCart});
  final Product products;
  final VoidCallback addToCart; //Thach add parameter

  @override
  State<Item> createState() => _ItemState();
}

class _ItemState extends State<Item> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => DetailProductSreen(product: widget.products),
          ),
          (route) => false,
        ); //Thach 14/1 Them chuyen huong den trang chi tiet
      },
      child: Container(
        margin: EdgeInsets.fromLTRB(10, 5, 5, 10),
        width: MediaQuery.of(context).size.width / 2 - 20,
        height: MediaQuery.of(context).size.width / 2 + 80,
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                        fit: BoxFit.contain,
                      )
                    : Image.asset(
                        "assets/images/piza.png",
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
                        onPressed:
                            widget.addToCart, //Thach 14/1 Handle adding to cart
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
                        widget.products.promotionalPrice == 0
                            ? ""
                            : HomeScreenViewModel.returnPrice(
                                widget.products.price),
                        style: const TextStyle(
                            decoration: TextDecoration.lineThrough,
                            fontSize: 12),
                        softWrap: true,
                      ),
                      Text(
                        widget.products.promotionalPrice == 0
                            ? HomeScreenViewModel.returnPrice(
                                widget.products.price)
                            : HomeScreenViewModel.returnPrice(
                                widget.products.promotionalPrice),
                        style: const TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
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
