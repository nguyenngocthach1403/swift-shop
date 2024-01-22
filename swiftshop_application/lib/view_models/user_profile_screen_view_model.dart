import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:swiftshop_application/data/models/profile_info_model.dart';
import 'package:swiftshop_application/data/models/user_model.dart';

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
