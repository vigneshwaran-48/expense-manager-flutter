import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationService {
  final FirebaseAuth _firebase = FirebaseAuth.instance;

  Stream<User?> authStateChanges() {
    return _firebase.authStateChanges();
  }

  Future<User?> signUp(String email, String password) async {
    try {
      final UserCredential userCredential = await _firebase
          .createUserWithEmailAndPassword(
            email: email.trim(),
            password: password.trim(),
          );
      return userCredential.user;
    } on FirebaseAuthException catch (err) {
      print(err.toString());
    }
    return null;
  }

  Future<void> signOut() async {
    final User? firebaseUser = _firebase.currentUser;
    if (firebaseUser != null) {
      await _firebase.signOut();
    }
  }

  User? getCurrentUser() {
    return _firebase.currentUser;
  }
}
