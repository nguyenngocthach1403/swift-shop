import 'package:flutter/material.dart';
import 'package:swiftshop_application/data/models/tab_item.dart';
import 'package:swiftshop_application/views/components/custom_tab_bar.dart';
import 'package:swiftshop_application/views/components/detail_product_item.dart';

class ProductList extends StatefulWidget {
  const ProductList({super.key});

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
  List<DetailItemProduct> items =
      List.filled(5, DetailItemProduct(), growable: true);
  @override
  Widget build(BuildContext context) {
    TabItem.lstTab.clear();
    TabItem.lstTab = lstProTypeTab;
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
