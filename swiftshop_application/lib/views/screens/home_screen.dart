import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:swiftshop_application/data/models/product.dart';
import 'package:swiftshop_application/view_models/home_screen_view_model.dart';
import 'package:swiftshop_application/views/components/banner_slider.dart';
import 'package:swiftshop_application/views/components/bottom_navigation_bar.dart';
import 'package:swiftshop_application/views/components/outstanding_product_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Product> products = [];
  var homeViewModel = HomeScreenViewModel();
  @override
  void initState() {
    homeViewModel.loadAndSaveProduct().then((value) {
      setState(() {});
    });
    homeViewModel.fetchProductsLocal().then((value) {
      setState(() {
        products = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    homeViewModel.fetchProductsLocal().then((value) {
      products = value;
    });
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        title: Container(
          height: 40,
          width: 150,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage('assets/icons/SwiftShop_logo.png'))),
        ),
        actions: [
          IconButton(
              onPressed: () {
                homeViewModel.navigationCartScreen(
                    context); //Thach 10:00 AM Thêm điều hướng tới CartScreen
              },
              icon: Image.asset(
                "assets/icons/shopping-cart.png",
                width: 30,
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            BannerSlider(),
            const Row(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                  child: Text(
                    "Nổi bật",
                    textAlign: TextAlign.start,
                    style: TextStyle(fontSize: 25),
                  ),
                ),
              ],
            ),
            //Thach 19/1  Sua
            products.isEmpty
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : OutstandingProductList(
                    cols: 2,
                    products: homeViewModel.findOustandingProducts(products)),
            const Row(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                  child: Text(
                    "Bán chạy nhất",
                    textAlign: TextAlign.start,
                    style: TextStyle(fontSize: 25),
                  ),
                ),
              ],
            ),
            //Thach 19/1  Sua
            products.isEmpty
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : OutstandingProductList(
                    cols: 2,
                    products: homeViewModel.findBestSalerProducts(products)),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBarCustom(
        idx: 0, //Thach 14/1 Thuc hien bottomnavigator
      ),
    );
  }
}
