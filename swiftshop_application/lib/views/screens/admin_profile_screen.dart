import 'package:flutter/material.dart';
import 'package:swiftshop_application/data/models/product.dart';
import 'package:swiftshop_application/views/components/avatar_and_name_profile.dart';
import 'package:swiftshop_application/views/components/order_list.dart';
import 'package:swiftshop_application/views/components/product_list.dart';
import 'package:swiftshop_application/views/components/profile_information.dart';

class AdminProfileScreen extends StatefulWidget {
  const AdminProfileScreen({super.key});

  @override
  State<AdminProfileScreen> createState() => _AdminProfileScreenState();
}

class _AdminProfileScreenState extends State<AdminProfileScreen> {
  List<Product> pro = List.filled(
      1,
      Product(
          id: 1,
          path: "",
          title: "",
          price: "",
          promotionalPrice: "",
          type: "",
          quantity: 1,
          quantitySold: 1,
          description: "",
          rate: 1),
      growable: true);

  Future<void> _loadData() async {
    Product.loadDataProduct().then((value) {
      pro = Product.product;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
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
          OrderList()
        ],
      )),
    );
  }

  @override
  void initState() {
    _loadData();
    super.initState();
  }
}
