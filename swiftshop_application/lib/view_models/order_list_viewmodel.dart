import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:swiftshop_application/data/models/order_model.dart';

class OrderViewModel {
  final String status;

  OrderViewModel(this.status);

  Future<List<OrderModel>> fetchOrderItems() async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await FirebaseFirestore.instance
              .collection('orders')
              .where('Status', isEqualTo: status)
              .get();

      print('Query Snapshot: $querySnapshot');

      List<OrderModel> orderModels = [];

      for (QueryDocumentSnapshot<Map<String, dynamic>> snapshot
          in querySnapshot.docs) {
        orderModels.add(OrderModel.fromFirestoreDocument(snapshot));
      }

      return orderModels;
    } catch (e) {
      print('Error fetching order data: $e');
      throw Exception('Error fetching order data');
    }
  }
}
