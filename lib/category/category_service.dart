import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_manager/category/category.dart';
import 'package:expense_manager/user/user_service.dart';

class CategoryService {
  final String userId;
  final UserService _userService = UserService();
  final CollectionReference<Map<String, dynamic>> _categoriesCollection;

  CategoryService({required this.userId})
    : _categoriesCollection = FirebaseFirestore.instance
          .collection("users")
          .doc(userId)
          .collection("categories");

  CategoryService.init(this._categoriesCollection) : userId = "";

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

  Future<Category> addCategory(Category category) async {
    try {
      final user = await _userService.getUserRef(userId);
      final result = await _categoriesCollection.add(category.toFireStore());
      return Category(
        id: result.id,
        name: category.name,
        description: category.description,
      );
    } on FirebaseException catch (err) {
      print(err);
      rethrow;
    }
  }
}
