import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:swiftshop_application/data/models/product.dart';

class SearchScreenViewModel {
  List<Product> resultProducts = [];
  void runFilter(String enterKeyWord) {
    if (enterKeyWord.isEmpty) {
      resultProducts = Product.product;
    } else {
      resultProducts = Product.product
          .where((item) => item.title
              .toLowerCase()
              .contains(enterKeyWord.trim().toLowerCase()))
          .toList();
    }
  }

  List lsttype = [
    "All",
    "Giá từ thấp đến cao",
    "Giá từ cao đến thấp",
    "Đang khuyến mãi"
  ];
  //Thach Sửa lại filter
  void onTapFilter(String type) {
    // type == "All"
    //     ? resultProducts = Product.product
    //     : resultProducts =
    //         Product.product.where((item) => item.type == type).toList();

    switch (type) {
      case "All":
        resultProducts = Product.product;
        break;
      case "Giá từ thấp đến cao":
        resultProducts = Product.product;
        resultProducts.sort(
          (a, b) => a.price.compareTo(b.price),
        );
        break;
      case "Giá từ cao đến thấp":
        resultProducts = Product.product;
        resultProducts.sort(
          (a, b) => b.price.compareTo(a.price),
        );
        break;
      case "Đang khuyến mãi":
        resultProducts = Product.product
            .where((element) => element.promotionalPrice != 0)
            .toList();
        resultProducts.sort(
          (a, b) => a.promotionalPrice.compareTo(b.promotionalPrice),
        );
        break;
      default:
        resultProducts =
            Product.product.where((item) => item.type == type).toList();
    }
  }
}
