import 'package:flutter/material.dart';
import 'package:swiftshop_application/data/models/order_model.dart';
import 'package:swiftshop_application/view_models/order_list_viewmodel.dart';

class OrderItem extends StatefulWidget {
  final OrderModel order;
  final OrderViewModel viewModel;

  const OrderItem({Key? key, required this.order, required this.viewModel})
      : super(key: key);

  @override
  State<OrderItem> createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  late OrderModel _order;

  @override
  void initState() {
    super.initState();
    _order = widget.order;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 145,
      height: MediaQuery.of(context).size.height / 5.5,
      margin: EdgeInsets.fromLTRB(0, 0, 0, 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: _text(
                      'Hóa đơn',
                      Colors.grey,
                      13.0,
                      FontWeight.normal,
                    ),
                  ),
                  _text(
                    _order.orderId,
                    Colors.black,
                    15.0,
                    FontWeight.bold,
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: _text(
                  widget.order.status,
                  Colors.blueAccent,
                  12.0,
                  FontWeight.normal,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
            child: Row(
              children: [
                _text('Ngày đặt: ', Colors.grey, 12.0, FontWeight.normal),
                _text(
                  _order.orderDate
                      .toDate()
                      .toString(), // Adjust the format as needed
                  Colors.black,
                  13.0,
                  FontWeight.normal,
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
            child: Row(
              children: [
                // Padding(
                //   padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                //   child: Image.network(
                //     widget.order.productPath, // Assuming you have a productPath in OrderModel
                //     height: 50,
                //     width: 50,
                //   ),
                // ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // _text(
                        //   widget.order.productName.length > 45
                        //       ? widget.order.productName.substring(0, 45)
                        //       : widget.order.productName,
                        //   Colors.black,
                        //   13.0,
                        //   FontWeight.normal,
                        // ),
                        Padding(padding: EdgeInsets.all(5.0)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _text(
                              'sl: ${_order.quantity.toString()}',
                              Colors.black,
                              13.0,
                              FontWeight.normal,
                            ),
                            _text(
                              '${_order.totalPrice}đ',
                              Colors.black,
                              13.0,
                              FontWeight.normal,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          const Divider(),
          Container(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 0, 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _text(
                    '1 sản phẩm',
                    Colors.grey,
                    15.0,
                    FontWeight.normal,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 8, 0),
                    child: Row(
                      children: [
                        _text(
                          'Thành tiền :  ',
                          Colors.black,
                          15.0,
                          FontWeight.normal,
                        ),
                        _text(
                          '${_order.totalPrice}',
                          Colors.red,
                          15.0,
                          FontWeight.bold,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Text _text(text, color, size, weight) {
    return Text(
      text,
      style: TextStyle(color: color, fontSize: size, fontWeight: weight),
    );
  }
}
