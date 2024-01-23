import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileInfoModel {
  final String accountId;
  final String fullname;
  final String email;
  final String phonenumber;
  final String address;

  ProfileInfoModel({
    required this.accountId,
    required this.fullname,
    required this.email,
    required this.phonenumber,
    required this.address,
  });

  factory ProfileInfoModel.fromFirestoreDocument(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    return ProfileInfoModel(
      accountId: snapshot.id,
      fullname: snapshot.data()?['fullname'] ?? '',
      email: snapshot.data()?['email'] ?? '',
      phonenumber: snapshot.data()?['phonenumber'] ?? '',
      address: snapshot.data()?['address'] ?? '',
    );
  }
}
