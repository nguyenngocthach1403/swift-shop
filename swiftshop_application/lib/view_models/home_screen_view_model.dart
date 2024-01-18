import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:swiftshop_application/data/models/product.dart';
import 'package:swiftshop_application/views/components/outstanding_product_list.dart';
import 'package:swiftshop_application/views/screens/cart_screen.dart';
import 'package:swiftshop_application/views/screens/detail_product_screen.dart';

class HomeScreenViewModel {
  final CollectionReference products =
      FirebaseFirestore.instance.collection("products");
  //Thach 15/1
  Stream<QuerySnapshot> getProductForHomeScreen() {
    final productStream = products.snapshots();
    return productStream;
  }

  //? Thach 1/10 5:46 PM Tải sản phẩm bán chạy
  Widget loadOutStandingProducts() {
    return StreamBuilder<QuerySnapshot>(
      stream: getProductForHomeScreen(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        }
        if (snapshot.connectionState == ConnectionState.active) {
          QuerySnapshot querySnapshot = snapshot.data!;

          List<QueryDocumentSnapshot> listQueryDocumentSnapshot =
              querySnapshot.docs;

          for (var i in listQueryDocumentSnapshot) {
            Product newPro = Product(
                id: i.id, //Thach 15/1
                path: i['path'],
                title: i['name'],
                price: i['price'], //Thach 16/1 int
                promotionalPrice: i['promotionPrice'], //Thach 16/1 int
                type: i['type'],
                quantity: int.parse(i['quantity'].toString()),
                quantitySold: int.parse(i['quantitySold'].toString()),
                rate: double.parse(i['rate'].toString()),
                description: "");
            bool defference = false;
            for (var i in Product.product) {
              if (newPro.id == i.id) {
                defference = true;
              }
            }
            if (defference == false) {
              Product.product.add(newPro);
            }
          }

          return OutstandingProductList(
              cols: 2, products: findOustandingProducts());
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  Widget loadBestSalerProducts() {
    final Stream<QuerySnapshot> _streamShoppingItem =
        FirebaseFirestore.instance.collection("products").snapshots();
    return StreamBuilder<QuerySnapshot>(
      stream: _streamShoppingItem,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        }
        if (snapshot.connectionState == ConnectionState.active) {
          QuerySnapshot querySnapshot = snapshot.data!;

          List<QueryDocumentSnapshot> listQueryDocumentSnapshot =
              querySnapshot.docs;

          for (var i in listQueryDocumentSnapshot) {
            Product newPro = Product(
                id: i.id,
                path: i['path'],
                title: i['name'],
                price: i['price'], //Thach 16/1 int
                promotionalPrice: i['promotionPrice'], //Thach 16/1 int
                type: i['type'],
                quantity: int.parse(i['quantity'].toString()),
                quantitySold: int.parse(i['quantitySold'].toString()),
                rate: double.parse(i['rate'].toString()),
                description: "");
            bool defference = false;
            for (var i in Product.product) {
              if (newPro.id == i.id) {
                defference = true;
              }
            }
            if (defference == false) {
              Product.product.add(newPro);
            }
          }
          // Thach 1:28 PM Lưu dữ liệu product firebase vào local
          if (Product.product.length != 0) {
            if (Product.saveDataProduct(Product.product) == true) {
              print("Save product done");
            } else {
              print("Save product fail");
            }
          }
          return OutstandingProductList(
              cols: 2, products: findBestSalerProducts());
        } else {
          if (Product.product == null) {
            Product.loadLocalProduct();
            return OutstandingProductList(cols: 2, products: Product.product);
          }
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  void navigationCartScreen(BuildContext context) {
    Navigator.pushNamed(context, "/cartscreen");
  }

  // void navigationDetailProduct(BuildContext context) {
  //   Navigator.push(context, MaterialPageRoute(builder: (context) => DetailProductSreen(),));
  // }

  List<Product> findBestSalerProducts() {
    //? Tại list sản phẩm bán chạy có 4 sp
    List<Product> bestSalerProducts = [];

    Product.product.sort((a, b) => (b.quantitySold * 0.6 + b.rate! * 0.8)
        .compareTo(a.quantitySold * 0.6 + a.rate! * 0.8));

    if (Product.product.length <= 4) {
      bestSalerProducts.addAll(Product.product);
    } else {
      for (int i = 0;
          Product.product.length >= 4 ? i < 4 : i < Product.product.length;
          i++) {
        if (bestSalerProducts.length <= 4)
          bestSalerProducts.add(Product.product[i]);
        else
          break;
      }
    }
    return bestSalerProducts;
  }

  List<Product> findOustandingProducts() {
    //? Tại list sản phẩm nổi bật có 6 sp
    List<Product> outstandingProduct = [];

    Product.product.sort((a, b) => b.rate!.compareTo(a.rate!));

    if (Product.product.length <= 6) {
      outstandingProduct.addAll(Product.product);
    } else {
      for (int i = 0;
          Product.product.length >= 6 ? i < 6 : i < Product.product.length;
          i++) {
        if (outstandingProduct.length < 6)
          outstandingProduct.add(Product.product[i]);
      }
    }
    return outstandingProduct;
  }
}
