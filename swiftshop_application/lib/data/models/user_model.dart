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
  factory UserModel.formSnapShot(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return UserModel(
        accountId: snapshot['accountId'],
        address: snapshot['address'],
        avatar: snapshot['avatar'],
        fullname: snapshot['fullname'],
        password: snapshot['password'],
        phonenumber: snapshot['phonenumber'],
        position: snapshot['position']);
  }

  Map<String, dynamic> toJson() => {
        "accountId": accountId,
        "address": address,
        "avatar": avatar,
        "fullname": fullname,
        "password": password,
        "phonenumber": phonenumber,
        "position": position
      };
  // UserModel.fromJson(Map<String, dynamic> json) {
  //   accountId = json['accountId'];
  //   address = json['address'];
  //   avatar = json['avatar'];
  //   fullname = json['fullname'];
  //   password = json['password'];
  //   phonenumber = json['phonenumber'];
  //   position = json['position'];
  // }
}
