
import 'package:flutter/material.dart';
import 'package:swiftshop_application/data/models/order_model.dart';
import 'package:swiftshop_application/data/models/tab_item.dart';
import 'package:swiftshop_application/view_models/user_profile_screen_view_model.dart';
import 'package:swiftshop_application/views/components/custom_tab_bar.dart';
import 'package:swiftshop_application/views/components/order_item.dart';

class OrderList extends StatefulWidget {
  const OrderList({super.key});

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

  @override
  void initState() {
    super.initState();
    orderViewModel = OrderViewModel(lstOrderTab[selectedTabIndex].title);
  }

  void onTabSelected(int index) {
    setState(() {
      selectedTabIndex = index;
      orderViewModel = OrderViewModel(lstOrderTab[selectedTabIndex].title);
    });
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
          Expanded(
            flex: 2,
            child: TabCustom(
              width: width,
              lstTab: lstOrderTab,
              onTabSelected: onTabSelected,
            ),
          ),
          Expanded(
            flex: 12,
            child: Container(
              width: width - 20 - 20,
              height: 310,
              margin: const EdgeInsets.fromLTRB(0, 0, 0, 5),
              child: FutureBuilder<List<OrderModel>>(
                future: orderViewModel.fetchOrderItems(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    List<OrderModel> orderItems = snapshot.data!;
                    return ListView.builder(
                      itemCount: orderItems.length,
                      itemBuilder: (context, index) {
                        return OrderItem(order: orderItems[index]);
                      },
                    );
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
