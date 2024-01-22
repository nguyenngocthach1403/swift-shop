import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:swiftshop_application/data/models/order.dart';
import 'package:swiftshop_application/data/models/order_model.dart';

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
}
