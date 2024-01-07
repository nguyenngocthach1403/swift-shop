// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:swiftshop_application/data/models/tab_item.dart';
import 'package:swiftshop_application/views/components/custom_tab_bar.dart';
import 'package:swiftshop_application/views/components/order_item.dart';

class OrderList extends StatefulWidget {
  const OrderList({super.key});
  // required this.items
  // final items;
  @override
  State<OrderList> createState() => _OrderListState();
}

class _OrderListState extends State<OrderList> {
  List<TabItem> lstOrderTab = [
    TabItem(title: "Chờ xác nhận"),
    TabItem(title: "Đã xác nhận"),
    TabItem(title: "Đang giao"),
    TabItem(title: "Thành công"),
    TabItem(title: "Đã hủy")
  ];

  List<OrderItem> orderItem = [
    OrderItem(),
    OrderItem(),
    OrderItem(),
    OrderItem(),
    OrderItem(),
  ];

  @override
  Widget build(BuildContext context) {
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
          Expanded(
              flex: 2,
              child: TabCustom(
                width: width,
                lstTab: lstOrderTab,
              )),
          Expanded(
              flex: 12,
              child: Container(
                width: width - 20 - 20,
                height: 310,
                margin: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                child: ListView.builder(
                  itemCount: orderItem.length,
                  itemBuilder: (context, index) {
                    return orderItem[index];
                  },
                ),
              ))
        ],
      ),
    );
  }
}
