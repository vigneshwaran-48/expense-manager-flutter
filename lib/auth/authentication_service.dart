import 'package:expense_manager/auth/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationService {
  final FirebaseAuth _firebase = FirebaseAuth.instance;

  Future<UserModal?> signUp(String email, String password) async {
    try {
      final UserCredential userCredential = await _firebase
          .createUserWithEmailAndPassword(
            email: email.trim(),
            password: password.trim(),
          );
      final User? firebaseUser = userCredential.user;
      if (firebaseUser != null) {
        return UserModal(
          id: firebaseUser.uid,
          email: firebaseUser.email ?? "",
          displayName: firebaseUser.displayName ?? "",
        );
      }
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
}
