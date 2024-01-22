import 'package:flutter/material.dart';
import 'package:swiftshop_application/view_models/admin_profile_screen_view_model.dart';
import 'package:swiftshop_application/views/components/custom_tab_bar.dart';
import 'package:swiftshop_application/views/components/detail_product_item.dart';

class ProductList extends StatefulWidget {
  const ProductList({Key? key, required this.viewModel}) : super(key: key);
  final AdminProfileViewModel viewModel;

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Container(
      margin: const EdgeInsets.all(10),
      height: 360,
      width: width - 20,
      decoration: BoxDecoration(
        color: const Color.fromRGBO(233, 233, 233, 1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          TabCustom(
            width: width,
            lstTab: widget.viewModel.lsttype,
            onTabSelected: (selectedTab) {
              widget.viewModel.onTapFilter(selectedTab.title);
              setState(() {});
            },
          ),
          Container(
            width: width - 20 - 20,
            height: 310,
            margin: const EdgeInsets.fromLTRB(0, 0, 0, 5),
            child: ListView.builder(
              itemCount: widget.viewModel.resultProducts.length,
              itemBuilder: (context, index) {
                return DetailProductItem(
                  pro: widget.viewModel.resultProducts[index],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
