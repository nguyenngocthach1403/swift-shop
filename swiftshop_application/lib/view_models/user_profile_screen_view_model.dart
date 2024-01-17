import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
