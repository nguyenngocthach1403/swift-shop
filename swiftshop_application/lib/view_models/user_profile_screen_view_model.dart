import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:swiftshop_application/data/models/order_model.dart';
import 'package:swiftshop_application/data/models/user_model.dart';

// ViewModel của User
class ProfileViewModel {
  final String accountId;

  ProfileViewModel(this.accountId);

  Future<UserModel> getProfileData() async {
    try {
      DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
          .instance
          .collection('accounts')
          .doc(accountId)
          .get();

      UserModel userModel = UserModel.fromFirestoreDocument(snapshot);

      return userModel;
    } catch (e) {
      print('Error getting profile data: $e');
      throw Exception('Error getting profile data');
    }
  }
}

// ViewModel của Order
class OrderViewModel {
  final String title;

  OrderViewModel(this.title);

  Future<List<OrderModel>> fetchOrderItems() async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await FirebaseFirestore.instance
              .collection('order detail')
              .where('State', isEqualTo: title)
              .get();

      List<OrderModel> orderModels = [];

      for (QueryDocumentSnapshot<Map<String, dynamic>> snapshot
          in querySnapshot.docs) {
        OrderModel orderModel = OrderModel.fromFirestoreDocument(snapshot);
        orderModels.add(orderModel);
      }

      return orderModels;
    } catch (e) {
      print('Error getting order data: $e');
      throw Exception('Error getting order data');
    }
  }
}
