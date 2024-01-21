

import 'package:flutter/material.dart';
import 'package:swiftshop_application/data/models/cart_detail.dart';
import 'package:swiftshop_application/data/models/format_currency.dart';
import 'package:swiftshop_application/data/models/product.dart';
import 'package:swiftshop_application/view_models/cart_screen_view_model.dart';

class Cart_Items extends StatefulWidget {
  const Cart_Items({
    Key? key,
    required this.cartItem,
    required this.onIncreaseQuantity,
    required this.onDecreaseQuantity,
    required this.onRemoveProduct,
    required this.products, 
    required this.onQuantityChanged,
  }) : super(key: key);

  final CartDetail cartItem;
  final List<Product> products;
  final VoidCallback onIncreaseQuantity;
  final VoidCallback onDecreaseQuantity;
  final VoidCallback onRemoveProduct;
 final VoidCallback onQuantityChanged;
  @override
  State<Cart_Items> createState() => _Cart_ItemsState();
}

class _Cart_ItemsState extends State<Cart_Items> {
  CartViewModel _viewModel = CartViewModel();

  int quantity = 0;
  String _formatPrice(double price) {
    String priceString = price.toString();
    if (!priceString.contains('.')) {
      return "$priceString.00đ";
    }
    return "$priceStringđ";
  }
  

  @override
  void initState() {
    quantity = widget.cartItem.quantity;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 4,
      height: MediaQuery.of(context).size.height / 6,
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                        _viewModel
                                .getProductById(
                                    widget.cartItem.productId, widget.products)!
                                .path
                                .isEmpty
                            ? "https://www.bing.com/images/search?view=detailV2&ccid=vDf037OK&id=A25E3880FAE210BAC3BACCA924BC5A8BBFE46C1C&thid=OIP.vDf037OKUo0H03weRxdWuAHaHa&mediaurl=https%3a%2f%2fwww.allianceplast.com%2fwp-content%2fuploads%2fno-image-1024x1024.png&cdnurl=https%3a%2f%2fth.bing.com%2fth%2fid%2fR.bc37f4dfb38a528d07d37c1e471756b8%3frik%3dHGzkv4tavCSpzA%26pid%3dImgRaw%26r%3d0&exph=1024&expw=1024&q=not+imgae&simid=608054974756435317&FORM=IRPRST&ck=7AEC77AAD9B33819FDDAB8267C285AC4&selectedIndex=11&itb=1&ajaxhist=0&ajaxserp=0"
                            : _viewModel
                                .getProductById(
                                    widget.cartItem.productId, widget.products)!
                                .path,
                      ))),
            ),
          ),
          SizedBox(width: 20),
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(padding: EdgeInsets.only(top: 10, left: 50)),
                //tùng cập nhật giá của sản phẩm hiện thị tổng
                Row(
                  children: [
                    Text(_viewModel
                        .getProductById(
                            widget.cartItem.productId, widget.products)!
                        .title),
                  ],
                ),
                Row(
                  children: [
                    Text(FormatCurrency.stringToCurrency(
                        widget.cartItem.price.toString())),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFF6088CA),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.remove),
                            onPressed: () {
                              setState(() {
                                if (quantity > 1) {
                                  quantity--;
                                  _viewModel.updateQuantity(
                                      widget.cartItem.cartdetailId, quantity);
                                      widget.onQuantityChanged();
                                }
                              });
                            },
                            color: Colors.black,
                          ),
                          Text(
                            quantity.toString(),
                            style: const TextStyle(
                              fontSize: 15.0,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.add),
                            onPressed: () {
                              //Tăng số lượng
                              setState(() {
                                quantity++;
                                _viewModel.updateQuantity(
                                    widget.cartItem.cartdetailId, quantity);
                                    widget.onQuantityChanged();
                              });
                            },
                            color: Colors.black,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: ElevatedButton(
                        onPressed: widget.onRemoveProduct,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                        ),
                        child: Row(
                          children: [
                            Text(
                              "Delete",
                              style: TextStyle(color: Colors.white),
                            ),
                            SizedBox(width: 5),
                            Image.asset(
                              "assets/icons/trash.png",
                              height: 20,
                              width: 20,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}