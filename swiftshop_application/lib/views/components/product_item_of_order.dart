import 'package:flutter/material.dart';
import 'package:swiftshop_application/view_models/home_screen_view_model.dart';

class ProductItemOfOrder extends StatelessWidget {
  const ProductItemOfOrder(
      {super.key,
      required this.title,
      required this.quantity,
      required this.promotionalPrice,
      required this.price,
      required this.promotionPrice,
      required this.path});
  final String title;
  final String path;
  final int quantity;
  final int promotionalPrice;
  final int price;
  final int promotionPrice;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(10, 5, 10, 0),
      width: MediaQuery.of(context).size.width - 20,
      decoration: const BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
            blurRadius: 3,
            color: Color.fromARGB(255, 133, 125, 125),
            offset: Offset(2, 2),
            blurStyle: BlurStyle.normal)
      ]),
      height: 90,
      child: Row(
        children: [
          Container(
            margin: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              image: DecorationImage(image: NetworkImage(path)),
              color: Colors.white,
            ),
            height: 80,
            width: 80,
          ),
          Expanded(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                child: Text(
                  title,
                  style: const TextStyle(fontSize: 14),
                ),
              ),
              //! Số lượng của sản phẩm
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [Text("Số lượng : ${quantity}")],
                ),
              ),
              //! Giá tiền của sản phẩm
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Text(
                        promotionalPrice == 0
                            ? ""
                            : HomeScreenViewModel.returnPrice(price),
                        style: const TextStyle(
                            decoration: TextDecoration.lineThrough),
                      ),
                    ),
                    Text(
                      (promotionalPrice == 0)
                          ? HomeScreenViewModel.returnPrice(price)
                          : HomeScreenViewModel.returnPrice(promotionPrice),
                      style: const TextStyle(color: Colors.red),
                    )
                  ],
                ),
              ),
            ],
          ))
        ],
      ),
    );
  }
}
