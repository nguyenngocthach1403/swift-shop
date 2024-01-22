import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:swiftshop_application/data/models/product.dart';
import 'package:swiftshop_application/view_models/add_product_screen_view_model.dart';
import 'package:swiftshop_application/views/components/avatar_and_name_profile.dart';
import 'package:swiftshop_application/views/components/bottom_navigation_bar.dart';
import 'package:swiftshop_application/views/components/order_list.dart';
import 'package:swiftshop_application/views/components/product_list.dart';
import 'package:swiftshop_application/views/components/profile_information.dart';
import 'package:swiftshop_application/views/screens/add_product_screen.dart';

class AdminProfileScreen extends StatefulWidget {
  const AdminProfileScreen({Key? key}) : super(key: key);

  @override
  State<AdminProfileScreen> createState() => _AdminProfileScreenState();
}

class _AdminProfileScreenState extends State<AdminProfileScreen> {
  final AdminProfileViewModel _viewModel = AdminProfileViewModel();

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    await _viewModel.fetchDataFromFirestore();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const AvatarProfile(),
            const ProfileInformation(),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.fromLTRB(25, 0, 0, 0),
              child: Row(
                children: const [
                  Text("Danh sách sản phẩm", style: TextStyle(fontSize: 25)),
                ],
              ),
            ),

            // Sử dụng FutureBuilder để chờ khi dữ liệu từ Firestore được load
            FutureBuilder(
              future: _viewModel.fetchDataFromFirestore(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else {
                  return ProductList(viewModel: _viewModel);
                }
              },
            ),

            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.fromLTRB(25, 0, 0, 0),
              child: Row(
                children: const [
                  Text("Danh sách hóa đơn", style: TextStyle(fontSize: 25)),
                ],
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
              //Chuyển trang tạo sản phẩm
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
                      child: IconButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => AddProductScreen(
                                        product: Product(
                                      id: "",
                                      path: "",
                                      title: "",
                                      price: 0,
                                      promotionalPrice: 0,
                                      type: "",
                                      quantity: 0,
                                      quantitySold: 0,
                                      rate: 0,
                                      description: "",
                                    ))));
                          },
                          icon: Icon(Icons.add)),
                    ),
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
}
