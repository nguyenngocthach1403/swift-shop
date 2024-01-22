import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:swiftshop_application/data/models/product.dart';
import 'package:swiftshop_application/view_models/add_product_screen_view_model.dart';
import 'package:swiftshop_application/view_models/admin_profile_screen_view_model.dart';
import 'package:swiftshop_application/view_models/home_screen_view_model.dart';
import 'package:swiftshop_application/views/components/avatar_and_name_profile.dart';
import 'package:swiftshop_application/views/components/bottom_navigation_bar.dart';
import 'package:swiftshop_application/views/components/order_list.dart';
import 'package:swiftshop_application/views/components/product_list.dart';
import 'package:swiftshop_application/views/components/profile_information.dart';
import 'package:swiftshop_application/views/screens/add_product_screen.dart';

class AdminProfileScreen extends StatefulWidget {
  const AdminProfileScreen({super.key});

  @override
  State<AdminProfileScreen> createState() => _AdminProfileScreenState();
}

class _AdminProfileScreenState extends State<AdminProfileScreen> {
  var adminProfileModel = AdminProfileModel();
  List<Product> products = [];

  List<Product> pro = List.filled(
      1,
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

  Future<void> _loadData() async {
    Product.loadLocalProduct().then((value) {
      pro = Product.product;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    adminProfileModel.fetchProductsLocal().then((value) {
      products = value;
    });
    return Scaffold(
      body: SingleChildScrollView(
          child: Column(
        children: [
          const AvatarProfile(),
          const ProfileInformation(),
          const Row(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                child:
                    Text("Danh sách sản phẩm", style: TextStyle(fontSize: 25)),
              ),
            ],
          ),
          ProductList(products: pro),
          const Row(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                child:
                    Text("Danh sách hóa đơn", style: TextStyle(fontSize: 25)),
              ),
            ],
          ),
          OrderList(),
          const Row(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                child: Text("Tiện ích", style: TextStyle(fontSize: 25)),
              ),
            ],
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => AddProductScreen()));
              setState(() {});
            },
            child: Container(
              height: 40,
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Color.fromRGBO(233, 233, 233, 1),
                  borderRadius: BorderRadius.circular(20)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 15, right: 10),
                    child: Text(
                      "Thêm sản phẩm mới",
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10, right: 5),
                    child: Container(
                        alignment: Alignment.centerLeft,
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                            color: Color.fromRGBO(65, 215, 71, 1),
                            borderRadius: BorderRadius.circular(50)),
                        child: Center(child: Icon(Icons.add))),
                  ),
                ],
              ),
            ),
          )
        ],
      )),
      bottomNavigationBar: BottomNavigationBarCustom(idx: 3),
    );
  }

  @override
  void initState() {
    adminProfileModel.loadAndSaveProduct().then((value) {
      setState(() {});
    });
    adminProfileModel.fetchProductsLocal().then((value) {
      setState(() {
        products = value;
      });
    });
    adminProfileModel.getDataOnFireBase().then((value) {
      setState(() {
        products = value;
      });
    });
    _loadData();
    super.initState();
  }
}
