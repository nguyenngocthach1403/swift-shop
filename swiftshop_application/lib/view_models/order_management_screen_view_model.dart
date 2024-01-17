import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:swiftshop_application/data/models/order.dart';
import 'package:swiftshop_application/data/models/order_item.dart';
import 'package:swiftshop_application/data/models/product.dart';
import 'package:swiftshop_application/data/models/product_of_order.dart';
import 'package:swiftshop_application/data/models/user.dart';

class OrderManagementViewModel {
  CollectionReference order = FirebaseFirestore.instance.collection('orders');
  //Lay du lieu toan bo order cua accountId hien tai
  Future<List<Orders>> getAllOrderOfAccountCurrent(accountIdCurrent) async {
    // String accountIdCurrent = FirebaseAuth.instance.currentUser!.uid;
    // String accountIdCurrent = "VsDw9osi6zNErUVFwRuIvDxmph42";
    QuerySnapshot docOrder = await order.get();
    List<Orders> lstOrder = [];
    for (var i in docOrder.docs) {
      Orders newOrder = Orders(
          accountId: i['AccountId'],
          address: i['Address'],
          orderDate: i['OrderDate'],
          orderId: i.id,
          status: i['Status'],
          totalPrice: i['TotalPrice']);
      if (newOrder.accountId == accountIdCurrent) {
        lstOrder.add(newOrder);
      }
    }
    return lstOrder;
  }

  Future<Orders> getOrderById(String orderId, String accountId) async {
    List<Orders> lst =
        await getAllOrderOfAccountCurrent("VsDw9osi6zNErUVFwRuIvDxmph42");
    Orders? order;
    for (var i in lst) {
      if (i.orderId == orderId) {
        order = i;
      }
    }
    if (order == null) {
      return Orders(
          orderId: '',
          accountId: 'accountId',
          address: 'address',
          orderDate: Timestamp.now(),
          status: 'status',
          totalPrice: 0);
    } else {
      return order;
    }
  }

  Future<Users> getUser(String accountId) async {
    QuerySnapshot user =
        await FirebaseFirestore.instance.collection("accounts").get();
    Users currentUser;
    for (var i in user.docs) {
      if (i.id == accountId) {
        currentUser = Users(
            accountId: i.id,
            address: i['address'],
            email: i['email'],
            fullname: i['fullname'],
            path: i['avatar'],
            phoneNumber: i['phonenumber'],
            position: i['position']);
        return currentUser;
      }
    }
    return Users(
        accountId: '',
        address: '',
        email: '',
        fullname: '',
        path: '',
        phoneNumber: '',
        position: '');
  }

  String returnNameStatus(String status) {
    switch (status) {
      case "Cho duyet":
        return "chờ duyệt";
      case "Da duyet":
        return "đã duyệt";
      case "Dang giao":
        return "đang giao";
      case "Hoan thanh":
        return "hoàn thành";
      case "Da huy":
        return "đã hủy";
    }
    return 'không xác định';
  }

  //GET item of oder
  Future<List<OrderDetail>> getAllItemOfOrder(String orderId) async {
    List<OrderDetail> lst = [];
    QuerySnapshot orderItem =
        await FirebaseFirestore.instance.collection("order detail").get();
    for (var i in orderItem.docs) {
      OrderDetail item = OrderDetail(
          id: i.id,
          orderId: i['OrderId'],
          price: i['Price'],
          productId: i['ProductId'],
          quantity: i['Quantity']);
      if (item.orderId == orderId) {
        lst.add(item);
      }
    }
    return lst;
  }

  //GET Product
  Future<List<Product>> getProduct() async {
    QuerySnapshot productsSnapShot =
        await FirebaseFirestore.instance.collection('products').get();
    List<Product> lstPro = [];
    for (var i in productsSnapShot.docs) {
      Product pro = Product(
          id: i.id,
          path: i['path'],
          title: i['name'],
          price: i['price'],
          promotionalPrice: i['promotionPrice'],
          type: i['type'],
          quantity: i['quantity'],
          quantitySold: i['quantitySold'],
          rate: double.parse(i['rate'].toString()),
          description: i['description']);
      lstPro.add(pro);
    }
    return lstPro;
  }

  Future<List<ProductOfOrder>> getProductOfOrderItem(String orderId) async {
    List<ProductOfOrder> lstProToReturn = [];
    List<Product> lstPro = await getProduct();
    List<OrderDetail> lstOrderDetail = await getAllItemOfOrder(orderId);
    for (var i in lstPro) {
      for (var j in lstOrderDetail) {
        if (j.productId == i.id) {
          ProductOfOrder pro = ProductOfOrder(
              name: i.title,
              path: i.path,
              quantity: j.quantity,
              promotionalPrice: i.promotionalPrice,
              price: j.price);
          lstProToReturn.add(pro);
        }
      }
    }
    return lstProToReturn;
  }

  Color returnColorStatus(String status) {
    switch (status) {
      case "Cho duyet":
        return const Color.fromRGBO(228, 209, 30, 1);
      case "Da duyet":
        return const Color.fromRGBO(220, 34, 34, 1);
      case "Dang giao":
        return const Color.fromRGBO(82, 34, 220, 1);
      case "Hoan thanh":
        return const Color.fromRGBO(65, 235, 184, 1);
      case "Da huy":
        return const Color.fromRGBO(109, 102, 132, 1);
    }
    return Colors.white;
  }

  String readTimestamp(Timestamp timestamp) {
    DateTime dateTime =
        DateTime.fromMicrosecondsSinceEpoch(timestamp.microsecondsSinceEpoch);
    return "${dateTime.hour}:${dateTime.minute} ${dateTime.day}-${dateTime.month}-${dateTime.year}";
  }
}
