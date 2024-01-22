import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:swiftshop_application/data/models/profile_info_model.dart';
import 'package:swiftshop_application/data/models/user_model.dart';

class UserData {
  static Future updateData(UserModel user) async {
    final userCollection = FirebaseFirestore.instance.collection('accounts');
    final docRef = userCollection.doc(user.accountId);

    final newUser = UserModel(
      accountId: user.accountId,
      address: user.address,
      avatar: user.avatar,
      email: user.email,
      fullname: user.fullname,
      password: user.password,
      phonenumber: user.phonenumber,
      position: user.position,
    ).toJson();

    try {
      await docRef.update(newUser);
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
