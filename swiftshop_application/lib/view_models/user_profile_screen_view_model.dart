import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:swiftshop_application/data/models/user_model.dart';

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

class UserData {
  static Future updateData(UserModel user) async {
    try {
      await FirebaseFirestore.instance
          .collection('accounts')
          .doc(user.accountId)
          .set(
        {
          'fullname': user.fullname,
          'address': user.address,
          'phonenumber': user.phonenumber,
          'avatar': user.avatar,
        },
        SetOptions(merge: true),
      );
    } catch (e) {
      print("$e");
    }
  }
}

// ViewModel của User
class ProfileViewModel {
  final String accountId;

  ProfileViewModel(this.accountId);

  Future<ProfileInfoModel> getProfileData() async {
    try {
      DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
          .instance
          .collection('accounts')
          .doc(accountId)
          .get();

      ProfileInfoModel proflieModel =
          ProfileInfoModel.fromFirestoreDocument(snapshot);

      return proflieModel;
    } catch (e) {
      print('Error getting profile data: $e');
      throw Exception('Error getting profile data');
    }
  }
}
