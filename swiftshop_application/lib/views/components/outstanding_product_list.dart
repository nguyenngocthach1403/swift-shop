import 'package:flutter/material.dart';
import 'package:swiftshop_application/data/models/product.dart';
import 'package:swiftshop_application/view_models/detail_product_screen_view_model.dart';
import 'package:swiftshop_application/views/components/sale_product_item.dart';

class OutstandingProductRow extends StatefulWidget {
  const OutstandingProductRow(
      {super.key,
      required this.cols,
      required this.products,
      required this.indexRow});
  final int cols;
  final List products;
  final int indexRow;

  @override
  State<OutstandingProductRow> createState() => _OutstandingProductRowState();
}

class _OutstandingProductRowState extends State<OutstandingProductRow> {
  DetailProductScreenViewModel _viewModel = DetailProductScreenViewModel();
  @override
  Widget build(BuildContext context) {
    return Row(children: [
      for (var i = widget.indexRow * widget.cols;
          i <
              (widget.indexRow * widget.cols + widget.cols <
                      widget.products.length
                  ? widget.indexRow * widget.cols + widget.cols
                  : widget.products.length);
          i++)
        Item(
          products: widget.products[i],
          addToCart: () {
            _viewModel.addProductToCard(widget.products[i], 1);
          },
        )
    ]);
  }
}

// ignore: must_be_immutable
class OutstandingProductList extends StatelessWidget {
  OutstandingProductList(
      {super.key, required this.cols, required this.products});
  final int cols;
  List<Product> products;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
          products.length,
          (index) => OutstandingProductRow(
                cols: cols,
                indexRow: index,
                products: products,
              )),
    );
  }
}
