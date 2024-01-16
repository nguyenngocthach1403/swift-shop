import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:swiftshop_application/data/models/format_currency.dart';
import 'package:swiftshop_application/data/models/product.dart';
import 'package:swiftshop_application/view_models/detail_product_screen_view_model.dart';

class DetailProductSreen extends StatefulWidget {
  const DetailProductSreen({Key? key, required this.product}) : super(key: key);
  final Product product;
  @override
  State<DetailProductSreen> createState() => _DetailProductSreenState();
}

class _DetailProductSreenState extends State<DetailProductSreen> {
  DetailProductScreenViewModel _viewModel = DetailProductScreenViewModel();
  @override
  Widget build(BuildContext context) {
    //Thach 14/1 truy xuat du lieu trang chi tiet
    @override
    initState() {
      super.initState();
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF6088CA),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(40),
          ),
        ),
        title: Row(
          children: [
            IconButton(
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/homepage',
                  (route) => false,
                );
              },
              icon: Image.asset(
                "assets/icons/arrow-back-white.png", //Thach 14.1 sua nut arrow
                width: 27,
              ),
            ),
            const Text(
              'Back',
              style: TextStyle(
                  fontSize: 18, color: Colors.white), //Thach 14.1 sua nut arrow
            ),
            const Spacer(),
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

      //Thach 14.1 Sua nut add to  cart
      bottomSheet: Container(
        margin: const EdgeInsets.only(bottom: 15),
        child: Row(
          children: [
            Expanded(
              flex: 4,
              child: Container(
                height: 70,
                margin: const EdgeInsets.only(left: 10),
                alignment: Alignment.center,
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
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  IconButton(
                    icon: const Icon(Icons.remove),
                    onPressed: () {
                      setState(() {
                        _viewModel.decrementProduct();
                      });
                    },
                    color: Colors.black,
                  ),
                  Text(
                    "${_viewModel.totalProduct}",
                    style: const TextStyle(
                        fontSize: 18.0,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () {
                      setState(() {
                        _viewModel.incrementProduct();
                      });
                    },
                    color: Colors.black,
                  ),
                ]),
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            Expanded(
                flex: 6,
                child: Padding(
                  padding: EdgeInsets.only(right: 10),
                  child: GestureDetector(
                    onTap: () {
                      _viewModel.addProductToCard(
                          widget.product,
                          _viewModel
                              .totalProduct); //Thach 14/1 Handle adding to cart
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: 70,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Color(0xFF6088CA),
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
                      child: Text(
                        "Add to Cart ${FormatCurrency.stringToCurrency(_viewModel.totalProduct != 0 ? (widget.product.price * _viewModel.totalProduct).toString() : widget.product.price.toString())}", //Thach 16/1
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ))
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
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50),
                  ),
                ),
                child: Column(
                  children: [
                    SizedBox(height: 80),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          widget.product.title,
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
                                "${widget.product.rate}", //Thach 14/1 Sua rate
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 22),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    //Thach 14.1 Sua desciption
                    Container(
                      padding: EdgeInsets.all(10),
                      width: MediaQuery.of(context).size.width,
                      height: 280,
                      child: SingleChildScrollView(
                        child: Text(
                          widget
                              .product.description, //Thach 14/1 Sua description
                          style: TextStyle(fontSize: 20),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    )
                  ],
                )),
          ),
          Positioned(
            width: 270,
            height: 270,
            top: MediaQuery.of(context).size.height / 4 - 190,
            left: MediaQuery.of(context).size.width / 2 - 270 / 2,
            child: Container(
                width: 270,
                height: 270,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.amber,
                    image: DecorationImage(
                        image: NetworkImage(widget.product.path),
                        fit: BoxFit.cover))),
          ),
        ],
      ),
    );
  }
}
