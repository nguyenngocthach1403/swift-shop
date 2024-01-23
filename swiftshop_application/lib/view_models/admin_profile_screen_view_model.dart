import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:swiftshop_application/data/models/order.dart';
import 'package:swiftshop_application/data/models/order_item.dart';
import 'package:swiftshop_application/data/models/product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:path_provider/path_provider.dart';
import 'package:swiftshop_application/data/models/product.dart';

class AdminProfileModel {
  final CollectionReference _mainCollection =
      FirebaseFirestore.instance.collection('products');
  //Get data on firebase
  Future<List<Product>> getDataOnFireBase() async {
    QuerySnapshot productsSnapshot = await _mainCollection.get();
    List<Product> products = [];
    for (var i in productsSnapshot.docs) {
      Product pro = Product(
          id: i.id,
          path: i['path'],
          title: i['name'],
          price: i['price'],
          promotionalPrice: i['promotionPrice'], //hau 21/01 3:00pm
          type: i['type'],
          quantity: int.parse(i['quantity'].toString()),
          quantitySold: int.parse(i['quantitySold'].toString()),
          rate: double.parse(i['rate'].toString()),
          description: "");
      products.add(pro);
    }
    return products;
  }

  //Save product local
  Future saveProductLocal(List<Product> products) async {
    File file = await Product.getPathFile('product');
    try {
      //Kiem tra file co ton tai
      if (await file.exists()) {
        List<Map<String, dynamic>> jsonData =
            products.map((e) => e.toJson()).toList();
        file.writeAsString(jsonEncode(jsonData));
        print("Save product to json done!");
      }
      //File khong ton tai
      else {
        List<Map<String, dynamic>> jsonData =
            products.map((e) => e.toJson()).toList();
        file.writeAsString(jsonEncode(jsonData));
        print("Save product to json done!");
      }
    } catch (e) {
      print("Save product to json fail!: $e");
    }
  }

  //Load and save
  Future loadAndSaveProduct() async {
    List<Product> productsOnFirebase = await getDataOnFireBase();
    await saveProductLocal(productsOnFirebase);
  }

  //Get product local
  Future<List<Product>> fetchProductsLocal() async {
    List<Product> products = [];
    File file = await Product.getPathFile('product');
    try {
      //Neu file ton tai
      if (await file.exists()) {
        String data = await file.readAsString();
        List<dynamic> jsonData = jsonDecode(data);
        for (var i in jsonData) {
          products.add(Product.fromJson(i));
        }
        print('File product local done!');
        return products;
      }
      //File khong ton tai
      else {
        print('File product local not exist!');
      }
    } catch (e) {
      print('File product local fail!: $e');
    }
    return products;
  }
}

class AdminScreenViewModel {
  CollectionReference order = FirebaseFirestore.instance.collection('orders');
  //get All order

  Future<List<Orders>> getAllOrder() async {
    QuerySnapshot docOrder =
        await FirebaseFirestore.instance.collection('orders').get();
    List<Orders> lstOrder = [];
    for (var i in docOrder.docs) {
      Orders newOrder = Orders(
          accountId: i['AccountId'],
          address: i['Address'],
          orderDate: i['OrderDate'],
          orderId: i.id,
          status: i['Status'],
          totalPrice: i['TotalPrice']);
      lstOrder.add(newOrder);
    }
    return lstOrder;
  }

  static String readTimestamp(Timestamp timestamp) {
    DateTime dateTime =
        DateTime.fromMicrosecondsSinceEpoch(timestamp.microsecondsSinceEpoch);
    return "${dateTime.hour}:${dateTime.minute} ${dateTime.day}-${dateTime.month}-${dateTime.year}";
  }

  //get all order detail
  Future<List<OrderDetail>> getAllOrderDetailByOrder(String orderId) async {
    List<OrderDetail> orderItem = [];
    CollectionReference orderDetail =
        await FirebaseFirestore.instance.collection('order detail');
    QuerySnapshot orderSnapShot = await orderDetail.get();
    for (var i in orderSnapShot.docs) {
      if (i['OrderId'] == orderId) {
        OrderDetail item = OrderDetail(
            id: i.id,
            orderId: i['OrderId'],
            price: i['Price'],
            productId: i['ProductId'],
            quantity: i['Quantity']);
        orderItem.add(item);
      }
    }
    return orderItem;
  }

  Future<Product> getAllProductById(String id) async {
    Product pro = Product(
        id: '',
        path: '',
        title: '',
        price: 0,
        promotionalPrice: 0,
        type: '',
        quantity: 1,
        quantitySold: 0,
        rate: 0,
        description: '');
    CollectionReference products =
        await FirebaseFirestore.instance.collection('products');
    QuerySnapshot proSnapShot = await products.get();
    for (var i in proSnapShot.docs) {
      if (i.id == id) {
        pro = Product(
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
      }
    }

    return pro;
  }
}
