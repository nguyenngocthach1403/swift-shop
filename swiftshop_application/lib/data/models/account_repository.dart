import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AccountRepository {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestoreInstance = FirebaseFirestore.instance;
  Future<UserCredential> loginUserWithFirebase(String email, String password) {
    final userCredential =
        auth.signInWithEmailAndPassword(email: email, password: password);
    return userCredential;
  }

  Future<UserCredential> signupUserWithFirebase(
      String fullname, String email, String password) {
    final userCredential =
        auth.createUserWithEmailAndPassword(email: email, password: password);
    return userCredential;
  }

  Future addDataToFirestore(
      Map<String, dynamic> data, String collectionName, String docName) async {
    try {
      await _firestoreInstance
          .collection(collectionName)
          .doc(docName)
          .set(data);
    } catch (e) {
      print(e);
      throw Exception(e.toString());
    }
  }

  Future updateDataToFirestore(
      Map<String, dynamic> data, String collectionName, String docName) async {
    try {
      await _firestoreInstance
          .collection(collectionName)
          .doc(docName)
          .update(data);
    } catch (e) {
      print(e);
      throw Exception(e.toString());
    }
  }

  Future getUserDataFromFirestore(String collectionName, String docName) async {
    try {
      final userData = await _firestoreInstance
          .collection(collectionName)
          .doc(docName)
          .get();
    } catch (e) {
      print(e);
      throw Exception(e.toString());
    }
  }

  bool isUserLoggedIn() {
    if (auth.currentUser != null) {
      return true;
    } else {
      return false;
    }
  }
}
