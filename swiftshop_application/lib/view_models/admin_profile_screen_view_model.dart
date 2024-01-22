import 'package:swiftshop_application/data/models/product.dart';
import 'package:swiftshop_application/data/models/tab_item.dart';

class AdminProfileViewModel {
  List<Product> resultProducts = [];
  List<Product> allProducts = [];

  Future<void> fetchDataFromFirestore() async {
    await Product.fetchDataFromFirebase();
    allProducts = Product.product;
    resultProducts = allProducts;
  }

  void runFilter(String enterKeyWord) {
    if (enterKeyWord.isEmpty) {
      resultProducts = allProducts;
    } else {
      resultProducts = allProducts
          .where((item) => item.title
              .toLowerCase()
              .contains(enterKeyWord.trim().toLowerCase()))
          .toList();
    }
  }

  List<TabItem> lsttype = [
    TabItem(title: "All"),
    TabItem(title: "Food"),
    TabItem(title: "Drink"),
    TabItem(title: "Phone"),
  ];

  void onTapFilter(String type) {
    switch (type) {
      case "All":
        resultProducts = allProducts;
        break;
      case "Food":
        resultProducts =
            allProducts.where((item) => item.type == "food").toList();
        break;
      case "Drink":
        resultProducts =
            allProducts.where((item) => item.type == "drink").toList();
        break;
      case "Phone":
        resultProducts =
            allProducts.where((item) => item.type == "phone").toList();
        break;
      default:
        resultProducts = [];
    }
  }
}
