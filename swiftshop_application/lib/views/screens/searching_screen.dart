import 'package:flutter/material.dart';
import 'package:swiftshop_application/data/models/product.dart';
import 'package:swiftshop_application/view_models/searching_screen_view_model.dart';
import 'package:swiftshop_application/views/components/bottom_navigation_bar.dart';
import 'package:swiftshop_application/views/components/outstanding_product_list.dart';
import 'package:swiftshop_application/views/screens/home_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  SearchScreenViewModel _viewModel = SearchScreenViewModel();
  bool showFilter = false;
  @override
  void initState() {
    Product.fetchDataFromFirebase().then((value) => {
          setState(() {
            _viewModel.resultProducts = Product.product;
            Product.product.forEach((item) {
              if (!_viewModel.lsttype.contains(item.type)) {
                _viewModel.lsttype.add(item.type);
              }
            });
          })
        });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            IconButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (e) => const HomeScreen(),
                  ),
                  (route) => false,
                ); //  Thach 14/1 sua
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
            margin:
                EdgeInsets.only(left: 10, right: 10), //Thach 14/1 Them  margin
            width: 400,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 208, 203, 203),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: TextField(
                      onChanged: (value) => setState(() {
                        _viewModel.runFilter(value);
                      }),
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Nhập tên sản phẩm ...',
                          prefixIcon: Icon(Icons.search)),
                    ),
                  ),
                ),
                const SizedBox(
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
                      onPressed: () {
                        if (showFilter)
                          showFilter = !showFilter;
                        else
                          showFilter = !showFilter;

                        setState(() {});
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (showFilter)
            Container(
              width: MediaQuery.of(context).size.width,
              height: 30,
              margin: const EdgeInsets.only(left: 10, right: 10, top: 10),
              child: ListView.builder(
                itemCount: _viewModel.lsttype.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _viewModel.onTapFilter(_viewModel.lsttype[index]);
                      });
                    },
                    child: Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      height: 25,
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(96, 136, 202, 1),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      margin: EdgeInsets.all(2.5),
                      child: Text(
                        "${_viewModel.lsttype[index]}",
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  );
                },
              ),
            ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
              child: _viewModel.resultProducts.isNotEmpty
                  ? SingleChildScrollView(
                      child: OutstandingProductList(
                          cols: 2, products: _viewModel.resultProducts),
                    )
                  : const Text("Not found product"))
        ],
      ),
      bottomNavigationBar: BottomNavigationBarCustom(idx: 2),
    );
  }
}
