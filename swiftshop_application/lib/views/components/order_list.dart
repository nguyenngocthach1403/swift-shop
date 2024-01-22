import 'package:flutter/material.dart';
import 'package:swiftshop_application/data/models/order.dart';
import 'package:swiftshop_application/data/models/order_model.dart';
import 'package:swiftshop_application/data/models/tab_item.dart';
import 'package:swiftshop_application/view_models/admin_profile_screen_view_model.dart';
import 'package:swiftshop_application/view_models/order_list_viewmodel.dart';
import 'package:swiftshop_application/view_models/user_profile_screen_view_model.dart';
import 'package:swiftshop_application/views/components/custom_tab_bar.dart';
import 'package:swiftshop_application/views/components/order_item.dart';

class OrderList extends StatefulWidget {
  const OrderList({super.key, required this.orders});
  final List<Orders> orders;

  @override
  State<OrderList> createState() => _OrderListState();
}

class _OrderListState extends State<OrderList> {
  late OrderViewModel orderViewModel;
  int selectedTabIndex = 0;

  List<TabItem> lstOrderTab = [
    TabItem(title: "Chờ xác nhận"),
    TabItem(title: "Đã xác nhận"),
    TabItem(title: "Đang giao"),
    TabItem(title: "Thành công"),
    TabItem(title: "Đã hủy"),
  ];

  List<OrderItem> orderItem = [];
  List<Orders> order = [];
  //Thach
  List<String> lsttype = [
    "Chờ xác nhận",
    "Đã xác nhận",
    "Đang giao",
    "Thành công",
    "Đã hủy"
  ];
  //Thach
  int _selectedTab = 0;
  void onTapPress(int index) {
    if (_selectedTab != index) {
      setState(() {
        _selectedTab = index;
      });
      for (int i = 0; i < lstOrderTab.length; i++) {
        if (lstOrderTab[i].active) lstOrderTab[i].active = false;
      }
      lstOrderTab[index].active = true;
    }
  }

  @override
  void initState() {
    super.initState();
    orderViewModel = OrderViewModel(lstOrderTab[selectedTabIndex].title);
    order = widget.orders;
  }

  void onTabSelected(int index) {
    setState(() {
      selectedTabIndex = index;
      orderViewModel = OrderViewModel(lstOrderTab[selectedTabIndex].title);
    });
  }

  @override
  Widget build(BuildContext context) {
    order.clear();
    orderItem.clear();
    order = widget.orders
        .where((element) => element.status == lsttype[_selectedTab])
        .toList();
    for (int i = 0; i < order.length; i++) {
      orderItem.add(OrderItem(order: order[i]));
    }
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
              itemCount: orderItem.length,
              itemBuilder: (context, index) {
                return orderItem[index];
              },
            ),
          ),
        ],
      ),
    );
  }
}
