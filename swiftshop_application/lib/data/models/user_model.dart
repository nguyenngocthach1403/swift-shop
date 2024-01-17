import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? accountId;
  String? address;
  String? avatar;
  String? email;
  String? fullname;
  String? password;
  String? phonenumber;
  String? position;

  UserModel(
      {this.accountId,
      this.address,
      this.avatar,
      this.email,
      this.fullname,
      this.password,
      this.phonenumber,
      this.position});

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
