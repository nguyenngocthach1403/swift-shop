import 'package:flutter/material.dart';
import 'package:swiftshop_application/data/models/product.dart';
import 'package:swiftshop_application/data/models/tab_item.dart';
import 'package:swiftshop_application/views/components/custom_tab_bar.dart';
import 'package:swiftshop_application/views/components/detail_product_item.dart';

class ProductList extends StatefulWidget {
  const ProductList({super.key, required this.products});
  final List<Product> products;
  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  List<TabItem> lstProTypeTab = [
    TabItem(title: "All"),
    TabItem(title: "1"),
    TabItem(title: "2"),
    TabItem(title: "3"),
    TabItem(title: "4")
  ];

  @override
  Widget build(BuildContext context) {
    List<DetailItemProduct> items = List.filled(
        0,
        DetailItemProduct(
          pro: Product(
              id: 0,
              path: "",
              title: '',
              price: '',
              promotionalPrice: '',
              type: '',
              quantity: 1,
              quantitySold: 1,
              rate: 1),
        ),
        growable: true);
    for (int i = 0; i < widget.products.length; i++) {
      items.add(DetailItemProduct(
        pro: widget.products[i],
      ));
    }
    final width = MediaQuery.of(context).size.width;
    return Container(
      margin: const EdgeInsets.all(10),
      height: 360,
      width: width - 20,
      decoration: BoxDecoration(
          color: const Color.fromRGBO(233, 233, 233, 1),
          borderRadius: BorderRadius.circular(20)),
      child: Column(
        children: [
          TabCustom(
            width: width,
            lstTab: lstProTypeTab,
          ),
          Container(
            width: width - 20 - 20,
            height: 310,
            margin: const EdgeInsets.fromLTRB(0, 0, 0, 5),
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                return items[index];
              },
            ),
          )
        ],
      ),
    );
  }
}
