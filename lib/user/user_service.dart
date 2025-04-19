import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_manager/user/AppUser.dart'; // Import your user model

class UserService {
  final CollectionReference<Map<String, dynamic>> _usersCollection =
      FirebaseFirestore.instance.collection('users');

  Future<AppUser?> getUser(String userId) async {
    try {
      final docSnapshot = await _usersCollection.doc(userId).get();
      if (docSnapshot.exists && docSnapshot.data() != null) {
        return AppUser.fromFireStore(docSnapshot.data()!, docSnapshot.id);
      }
      return null;
    } catch (e) {
      print('Error fetching user: $e');
      return null;
    }
  }

  Future<void> createUser(AppUser user) async {
    try {
      await _usersCollection.doc(user.id).set(user.toFireStore());
    } catch (e) {
      print('Error creating user: $e');
      rethrow;
    }
  }

  Future<void> updateUser(AppUser user) async {
    try {
      await _usersCollection.doc(user.id).update(user.toFireStore());
    } catch (e) {
      print('Error updating user: $e');
      rethrow;
    }
  }

  Stream<AppUser?> watchUser(String userId) {
    return _usersCollection.doc(userId).snapshots().map((snapshot) {
      if (snapshot.exists && snapshot.data() != null) {
        return AppUser.fromFireStore(snapshot.data()!, snapshot.id);
      }
      return null;
    });
  }
}
