import 'package:flutter/material.dart';
import 'package:swiftshop_application/data/models/product.dart';
import 'package:swiftshop_application/views/components/banner_slider.dart';
import 'package:swiftshop_application/views/components/bottom_navigation_bar.dart';
import 'package:swiftshop_application/views/components/outstanding_product_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    // final w = MediaQuery.of(context).size.width;
    List<Product> lstProduct = List.filled(
        4,
        Product("", "San pham aaaaaaaaaaaa", "100000d", "Food", "Food",
            quantitySold: "", rate: 2.3),
        growable: true);
    return Scaffold(
      appBar: AppBar(
        title: const CircleAvatar(
          backgroundColor: Colors.amber,
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Image.asset(
                "assets/icons/shopping-cart.png",
                width: 35,
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
            OutstandingProductList(cols: 2, products: lstProduct),
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
            OutstandingProductList(cols: 2, products: lstProduct),
            // Row(
            //   children: [Item(), Item()],
            // ),
            // Row(
            //   children: [Item(), Item()],
            // )
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBarCustom(
        idx: 2,
      ),
    );
  }
}
