import 'package:cloud_firestore/cloud_firestore.dart';

class OrderModel {
  final String documentId;
  final String date;
  final String name;
  final String orderId;
  final String path;
  final String price;
  final int productId;
  final int quantity;
  final String state;

  OrderModel({
    required this.documentId,
    required this.date,
    required this.name,
    required this.orderId,
    required this.path,
    required this.price,
    required this.productId,
    required this.quantity,
    required this.state,
  });

  factory OrderModel.fromFirestoreDocument(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    return OrderModel(
      documentId: snapshot.id,
      date: snapshot.data()?['Date'] ?? '',
      name: snapshot.data()?['Name'] ?? '',
      orderId: snapshot.data()?['OrderId'] ?? '',
      path: snapshot.data()?['Path'] ?? '',
      price: snapshot.data()?['Price'] ?? '',
      productId: snapshot.data()?['ProductId'] ?? 0,
      quantity: snapshot.data()?['Quantity'] ?? 0,
      state: snapshot.data()?['State'] ?? '',
    );
  }
}
