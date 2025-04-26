import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_manager/category/category.dart';

class CategoryService {
  final String userId;
  final CollectionReference<Map<String, dynamic>> _categoriesCollection;

  CategoryService({required this.userId})
    : _categoriesCollection = FirebaseFirestore.instance
          .collection("users")
          .doc(userId)
          .collection("categories");

  Future<List<Category>> getCategories() async {
    try {
      final snapshot = await _categoriesCollection.get();
      return snapshot.docs
          .map((doc) => Category.fromFireStore(doc.id, doc.data()))
          .toList();
    } catch (err) {
      print(err);
      rethrow;
    }
  }
}
