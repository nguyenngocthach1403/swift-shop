import 'package:cloud_firestore/cloud_firestore.dart';

class Orders {
  String orderId;
  String accountId;
  String address;
  Timestamp orderDate;
  int totalPrice;
  String status;
  Orders(
      {required this.orderId,
      required this.accountId,
      required this.address,
      required this.orderDate,
      required this.status,
      required this.totalPrice});
}
