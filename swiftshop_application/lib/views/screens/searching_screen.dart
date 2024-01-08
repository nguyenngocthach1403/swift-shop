import 'package:flutter/material.dart';
import 'package:swiftshop_application/data/models/product.dart';
import 'package:swiftshop_application/views/components/outstanding_product_list.dart';
import 'package:swiftshop_application/views/screens/home_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<Product> lstProduct = List.filled(
      4,
      Product(
          id: 1,
          path: "path",
          title: "Sản phẩm 1",
          price: "100000đ",
          promotionalPrice: "2000000đ",
          type: '',
          quantity: 1,
          quantitySold: 1,
          rate: 1),
      growable: true);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (e) => const HomeScreen(),
                  ),
                );
              },
              icon: Image.asset(
                "assets/icons/arrow-back-black.png",
                width: 20,
              ),
            ),
            const Text(
              'Back',
              style: TextStyle(fontSize: 18),
            ),
            Spacer(),
            IconButton(
              onPressed: () {},
              icon: Image.asset(
                "assets/icons/shopping-cart.png",
                width: 27,
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Container(
            width: 400,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 208, 203, 203),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: TextFormField(
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Nhập tên sản phẩm ...',
                          prefixIcon: Icon(Icons.search)),
                    ),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Material(
                  child: Ink(
                    width: 70,
                    height: 45,
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(96, 136, 202, 1),
                        borderRadius: BorderRadius.circular(15)),
                    child: IconButton(
                      // padding: EdgeInsets.all(4),
                      icon: Image.asset(
                        "assets/icons/settings-sliders-white.png",
                        height: 20,
                        width: 20,
                      ),
                      onPressed: () {},
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 25,
          ),
          OutstandingProductList(cols: 2, products: lstProduct),
        ],
      ),
    );
  }
}
