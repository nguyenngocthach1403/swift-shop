import 'package:flutter/material.dart';
import 'package:swiftshop_application/data/models/order.dart';
import 'package:swiftshop_application/data/models/tab_item.dart';
import 'package:swiftshop_application/view_models/user_profile_screen_view_model.dart';
import 'package:swiftshop_application/views/components/custom_tab_bar.dart';
import 'package:swiftshop_application/views/components/order_item.dart';

class OrderList extends StatefulWidget {
  const OrderList({Key? key, required this.orders, required this.position})
      : super(key: key);

  final List<Orders> orders;
  final String position;

  @override
  State<OrderList> createState() => _OrderListState();
}

class _OrderListState extends State<OrderList> {
  late OrderViewModel orderViewModel;
  int _selectedTab = 0;
  List<OrderItem> orderItems = [];

  List<TabItem> lstOrderTab = [
    TabItem(title: "Chờ xác nhận"),
    TabItem(title: "Đã xác nhận"),
    TabItem(title: "Đang giao"),
    TabItem(title: "Thành công"),
    TabItem(title: "Đã hủy"),
  ];

  List<String> lsttype = [
    "Chờ xác nhận",
    "Đã xác nhận",
    "Đang giao",
    "Thành công",
    "Đã hủy"
  ];

  @override
  void initState() {
    super.initState();
    orderViewModel = OrderViewModel(lstOrderTab[_selectedTab].title);
    _updateOrderList();
  }

  void onTapPress(int index) {
    setState(() {
      _selectedTab = index;
      orderViewModel = OrderViewModel(lstOrderTab[_selectedTab].title);
      _updateOrderList();
    });
  }

  void _updateOrderList() {
    orderItems.clear();

    if (widget.position == 'User') {
      orderItems.addAll(
        widget.orders
            .where((element) =>
                element.status == lsttype[_selectedTab] &&
                element.accountId == 'accountIdCuaNguoiDung')
            .map((order) => OrderItem(order: order))
            .toList(),
      );
    } else if (widget.position == 'Admin') {
      orderItems.addAll(
        widget.orders
            .where((element) => element.status == lsttype[_selectedTab])
            .map((order) => OrderItem(order: order))
            .toList(),
      );
    }
  }

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
            lstTab: lstOrderTab,
            selectedTab: _selectedTab,
            onTabSelected: onTapPress,
          ),
          Container(
            width: width - 20 - 20,
            height: 310,
            margin: const EdgeInsets.fromLTRB(0, 0, 0, 5),
            child: ListView.builder(
              itemCount: orderItems.length,
              itemBuilder: (context, index) {
                return orderItems[index];
              },
            ),
          ),
        ],
      ),
    );
  }
}
