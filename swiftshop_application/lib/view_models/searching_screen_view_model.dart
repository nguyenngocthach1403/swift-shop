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

  List lsttype = ["All"];

  void onTapFilter(String type) {
    type == "All"
        ? resultProducts = Product.product
        : resultProducts =
            Product.product.where((item) => item.type == type).toList();
  }
}
