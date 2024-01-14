import 'package:firebase_auth/firebase_auth.dart';

class RegisterViewModel {
  FirebaseAuth auth = FirebaseAuth.instance;
  Future<UserCredential> signupUserWithFirebase(String email, String password) {
    final userCredential =
        auth.createUserWithEmailAndPassword(email: email, password: password);
    return userCredential;
  }
}
