import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:swiftshop_application/data/models/product.dart';
import 'package:swiftshop_application/views/components/outstanding_product_list.dart';
import 'package:swiftshop_application/views/screens/cart_screen.dart';
import 'package:swiftshop_application/views/screens/detail_product_screen.dart';

class HomeScreenViewModel {
  //? Thach 1/10 5:46 PM Tải sản phẩm bán chạy
  Widget loadOutStandingProducts() {
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
                id: i['id'],
                path: i['path'],
                title: i['name'],
                price: i['price'].toString(),
                promotionalPrice: i['promotionalPrice'].toString(),
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
          //? Tại list sản phẩm bán chạy có 6 sp
          List<Product> outstandingProduct = [];
          Product.product.sort((a, b) => b.rate!.compareTo(a.rate!));
          if (Product.product.length <= 6) {
            outstandingProduct.addAll(Product.product);
          } else {
            for (int i = 0;
                Product.product.length >= 6
                    ? i < 6
                    : i < Product.product.length;
                i++) {
              if (outstandingProduct.length < 6)
                outstandingProduct.add(Product.product[i]);
            }
          }

          return OutstandingProductList(cols: 2, products: outstandingProduct);
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
                id: i['id'],
                path: i['path'],
                title: i['name'],
                price: i['price'].toString(),
                promotionalPrice: i['promotionalPrice'].toString(),
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
          //? Tại list sản phẩm bán chạy có 6 sp
          List<Product> outstandingProduct = [];
          Product.product.sort((a, b) => (b.quantitySold * 0.6 + b.rate! * 0.8)
              .compareTo(a.quantitySold * 0.6 + a.rate! * 0.8));
          if (Product.product.length <= 6) {
            outstandingProduct.addAll(Product.product);
          } else {
            for (int i = 0;
                Product.product.length >= 6
                    ? i < 6
                    : i < Product.product.length;
                i++) {
              if (outstandingProduct.length < 6)
                outstandingProduct.add(Product.product[i]);
            }
          }

          return OutstandingProductList(cols: 2, products: outstandingProduct);
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
}
