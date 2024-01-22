import 'package:cloud_firestore/cloud_firestore.dart';

class OrderModel {
  final String orderId;
  final String accountId;
  final String status;
  final String dateComplete;
  final Timestamp orderDate;
  final int quantity;
  final int totalPrice; // Chuyển kiểu dữ liệu thành int
  final String address;

  OrderModel({
    required this.orderId,
    required this.accountId,
    required this.status,
    required this.dateComplete,
    required this.orderDate,
    required this.quantity,
    required this.totalPrice,
    required this.address,
  });

  factory OrderModel.fromFirestoreDocument(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    return OrderModel(
      orderId: snapshot.get('orderId') ?? '',
      accountId: snapshot.get('AccountId') ?? '',
      status: snapshot.get('Status') ?? '',
      dateComplete: snapshot.get('DateComplete') ?? '',
      orderDate: snapshot.get('OrderDate') ?? Timestamp.now(),
      quantity: snapshot.get('Quantity') ?? 0,
      totalPrice: snapshot.get('TotalPrice') ?? 0, // Thay đổi ở đây
      address: snapshot.get('Address') ?? '',
    );
  }
}
