import 'package:flutter/material.dart';
import 'package:swiftshop_application/data/models/order.dart';
import 'package:swiftshop_application/data/models/product.dart';
import 'package:swiftshop_application/view_models/admin_profile_screen_view_model.dart';
import 'package:swiftshop_application/views/components/avatar_and_name_profile.dart';
import 'package:swiftshop_application/views/components/bottom_navigation_bar.dart';
import 'package:swiftshop_application/views/components/order_list.dart';
import 'package:swiftshop_application/views/components/profile_imformation.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({Key? key}) : super(key: key);

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  Widget returnProfileScreen() {
    return AvatarProfile();
  }

  Widget returnProfileInfomation() {
    return ProfileInformation();
  }

  AdminScreenViewModel _viewModel = AdminScreenViewModel();
  List<Product> pro = List.filled(
      0,
      Product(
          id: '', //Thach 15/1
          path: "",
          title: "",
          price: 0, //Thach 16/1 int
          promotionalPrice: 0, //Thach 16/1 int
          type: "",
          quantity: 1,
          quantitySold: 1,
          description: "",
          rate: 1),
      growable: true);
  List<Orders> orders = [];
  Future<void> _loadData() async {
    Product.loadLocalProduct().then((value) {
      pro = Product.product;
      setState(() {});
    });
  }

  Future<void> _loadDataOrder() async {
    _viewModel.getAllOrder().then((value) {
      orders = value;
      setState(() {});
    });
  }

  @override
  void initState() {
    _loadData();
    _loadDataOrder();
    Product.loadLocalProduct();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(5),
              child: Container(
                padding: EdgeInsets.all(0),
                margin: EdgeInsets.all(0),
                width: MediaQuery.of(context).size.width - 10,
                height: MediaQuery.of(context).size.height + 10,
                child: Column(
                  children: [
                    SizedBox(
                      height: 275,
                      child: Expanded(
                        child: returnProfileScreen(),
                      ),
                    ),
                    Expanded(
                      child: returnProfileInfomation(),
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 25),
                          child: Text(
                            "Lịch sử đơn hàng",
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                          child: OrderList(
                        orders: orders,
                        position: '',
                      )),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBarCustom(idx: 3),
    );
  }
}
