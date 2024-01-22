import 'package:flutter/material.dart';
import 'package:swiftshop_application/data/models/product.dart';
import 'package:swiftshop_application/view_models/add_product_screen_view_model.dart';
import 'package:swiftshop_application/views/screens/update_product_screen.dart';

class DetailProductItem extends StatefulWidget {
  const DetailProductItem({super.key, required this.pro});
  final Product pro;
  @override
  State<DetailProductItem> createState() => _DetailProductItemState();
}

class _DetailProductItemState extends State<DetailProductItem> {
  List<Product> products = [];

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 0, 0, 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      height: 150,
      width: 350,
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              padding: const EdgeInsets.only(left: 10),
              width: 130,
              height: 130,
              child: Image.network(
                widget.pro.path.toString(),
                width: 130,
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(0),
                        child: Text(widget.pro.title,
                            style: const TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold)),
                      ),
                      IconButton(
                        icon: Image.asset(
                          "assets/icons/edit.png",
                          width: 1,
                        ),
                        onPressed: () {
                          //lấy dữ liệu sang Update Screen
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => UpdateProductScreen(
                                      product: Product(
                                    id: widget.pro.id,
                                    path: widget.pro.path,
                                    title: widget.pro.title,
                                    price: widget.pro.price,
                                    promotionalPrice:
                                        widget.pro.promotionalPrice,
                                    type: widget.pro.type,
                                    quantity: widget.pro.quantity,
                                    quantitySold: widget.pro.quantitySold,
                                    rate: widget.pro.rate,
                                    description: widget.pro.description,
                                  ))));
                        },
                        iconSize: 10,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text("Giá:    ${widget.pro.price}",
                          style: const TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  Row(
                    children: [
                      Text("Đã bán:   ${widget.pro.quantitySold}",
                          style: const TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 5, 20, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.all(3),
                          width: 70,
                          height: 25,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.black),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                "assets/icons/star1.png",
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                                child: Text(
                                  "${widget.pro.rate}",
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 10),
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.all(0),
                          width: 130,
                          height: 25,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Color(0xFFE1E1E1)),
                          child: Padding(
                            padding: EdgeInsets.all(0),
                            child: Text(
                              "Số lượng tồn: ${widget.pro.quantity}",
                              style: const TextStyle(
                                fontSize: 12,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 5, 20, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          width: 100,
                          height: 25,
                          child: ElevatedButton(
                            onPressed: () async {
                              AddProduct.deleteItem(
                                productid: widget.pro.id,
                                path: widget.pro.path,
                                name: widget.pro.title,
                                price: widget.pro.price,
                                promotionPrice: widget.pro.promotionalPrice,
                                type: widget.pro.type,
                                quantity: widget.pro.quantity,
                                quantitySold: widget.pro.quantitySold,
                                rate: widget.pro.rate as double,
                                description: widget.pro.description,
                              ).then((value) => products);
                              setState(() {
                                products;
                              });
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                        content: Text(
                                            "Xóa thành công sản phẩm"));
                                  });
                            },
                            style: ElevatedButton.styleFrom(
                              primary: Colors.redAccent,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                const Text("Delete"),
                                Image.asset(
                                  "assets/icons/trash.png",
                                  width: 11,
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ))
        ],
      ),
    );
  }
}
