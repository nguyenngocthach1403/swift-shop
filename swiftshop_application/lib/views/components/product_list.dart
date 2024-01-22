import 'package:flutter/material.dart';
import 'package:swiftshop_application/data/models/product.dart';
import 'package:swiftshop_application/data/models/tab_item.dart';
import 'package:swiftshop_application/view_models/admin_profile_screen_view_model.dart';
import 'package:swiftshop_application/views/components/custom_tab_bar.dart';
import 'package:swiftshop_application/views/components/detail_product_item.dart';

class ProductList extends StatefulWidget {
  const ProductList({
    Key? key,
    required this.products,
  }) : super(key: key);
  final List<Product> products;

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  List<TabItem> lstProTypeTab = [
    TabItem(title: "All"),
  ];
  List<String> lsttype = ['All'];
  int _selectedTab = 0;
  void onTapPress(int index) {
    if (_selectedTab != index) {
      setState(() {
        _selectedTab = index;
      });
      for (int i = 0; i < lstProTypeTab.length; i++) {
        if (lstProTypeTab[i].active) lstProTypeTab[i].active = false;
      }
      lstProTypeTab[index].active = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    for (var i in widget.products) {
      bool isExist = false;
      for (var j in lsttype) {
        if (i.type == j) {
          isExist = true;
        }
      }
      if (!isExist) {
        lstProTypeTab.add(TabItem(title: i.type));
        lsttype.add(i.type);
      }
    }
    List<DetailProductItem> items = [];
    List<Product> lstPro = [];
    if (lsttype[_selectedTab] == "All") {
      lstPro = widget.products;
    } else {
      lstPro = widget.products
          .where((element) => element.type == lsttype[_selectedTab])
          .toList();
    }
    for (int i = 0; i < lstPro.length; i++) {
      items.add(DetailProductItem(
        pro: lstPro[i],
      ));
    }
    final width = MediaQuery.of(context).size.width;
    return Container(
      margin: const EdgeInsets.all(10),
      width: width - 20,
      decoration: BoxDecoration(
        color: const Color.fromRGBO(233, 233, 233, 1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          TabCustom(
            width: width,
            lstTab: lstProTypeTab,
            selectedTab: _selectedTab,
            onTabSelected: onTapPress,
          ),
          Container(
            width: width - 20 - 20,
            height: 320,
            margin: const EdgeInsets.fromLTRB(0, 0, 0, 5),
            child: ListView.builder(
              itemCount: lstPro.length,
              itemBuilder: (context, index) {
                return DetailProductItem(
                  pro: lstPro[index],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
