import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swiftshop_application/data/models/account_repository.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthProvider extends ChangeNotifier {
  bool _isLoading = false;
  UserCredential? _userCredential;
  Map<String, dynamic> _userData = {};
  AccountRepository fauth = AccountRepository();
  bool get isLoading => _isLoading;
  UserCredential? get userCredential => _userCredential;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _store = FirebaseFirestore.instance;

  Map<String, dynamic> get userData => _userData;

  Future<UserCredential> loginUserWithFirebase(
      String email, String password) async {
    setLoader(true);
    try {
      _userCredential = await fauth.loginUserWithFirebase(email, password);
      setLoader(false);
      return _userCredential!;
    } catch (e) {
      print(e);
      setLoader(false);
      return Future.error(e);
    }
  }

  Future<UserCredential> signupUserWithFirebase(
      String fullname, String email, String password) async {
    var isSuccess = false;
    setLoader(true);
    _userCredential =
        await fauth.signupUserWithFirebase(fullname, email, password);

    final data = {
      'accountId': _userCredential!.user!.uid,
      'address': '',
      'avatar': '',
      'email': email,
      'fullname': fullname,
      'password': password,
      'phonenumber': '',
      'position': '',
    };
    String uid = _userCredential!.user!.uid;
    isSuccess = await addUserToFirebase(data, 'accounts', uid);
    if (isSuccess) {
      return _userCredential!;
    } else {
      throw Exception('Error to Sign up the user');
    }
  }

  Future<bool> addUserToFirebase(
      Map<String, dynamic> data, String collectionName, String docName) async {
    var value = false;
    try {
      await fauth.addDataToFirestore(data, collectionName, docName);
      value = true;
    } catch (e) {
      print(e);
      value = false;
    }
    return value;
  }

  setLoader(bool loader) {
    _isLoading = loader;
    notifyListeners();
  }

  Future<bool> signInWithGoogle() async {
    bool res = false;
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn();
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();
      final GoogleSignInAuthentication? googleSignInAuth =
          await googleSignInAccount?.authentication;

      final credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuth?.accessToken,
          idToken: googleSignInAuth?.idToken);

      UserCredential userCredential =
          await _auth.signInWithCredential(credential);

      User? user = userCredential.user;
      if (user != null) {
        if (userCredential.additionalUserInfo!.isNewUser) {
          await _store.collection('accounts').doc(user.uid).set({
            'fullname': user.displayName,
            'accountId': user.uid,
            'avatar': user.photoURL,
            'email': user.email,
            'phonenumber': "",
            'position': "",
            'address': "",
          });
        }
        res = true;
      }
    } catch (e) {
      res = false;
    }
    return res;
  }
}

final authProvider =
    ChangeNotifierProvider<AuthProvider>((ref) => AuthProvider());
final passwordVisibleProvider = StateProvider<bool>((ref) => true);
