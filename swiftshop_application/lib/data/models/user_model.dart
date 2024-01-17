import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String accountId;
  final String fullname;
  final String email;
  final String phonenumber;
  final String address;

  UserModel({
    required this.accountId,
    required this.fullname,
    required this.email,
    required this.phonenumber,
    required this.address,
  });

  factory UserModel.fromFirestoreDocument(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    return UserModel(
      accountId: snapshot.id,
      fullname: snapshot.data()?['fullname'] ?? '',
      email: snapshot.data()?['email'] ?? '',
      phonenumber: snapshot.data()?['phonenumber'] ?? '',
      address: snapshot.data()?['address'] ?? '',
    );
  }
}
