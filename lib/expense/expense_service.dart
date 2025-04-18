import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_manager/expense/expense.dart';

class ExpenseService {
  final String userId;

  final CollectionReference<Map<String, dynamic>> _expenseCollection;

  ExpenseService({required this.userId})
    : _expenseCollection = FirebaseFirestore.instance
          .collection("users")
          .doc(userId)
          .collection("expenses");

  Future<List<Expense>> getExpenses() async {
    try {
      final snapshot = await _expenseCollection.get();
      return snapshot.docs.map((doc) => Expense.fromFireStore(doc)).toList();
    } on FirebaseFirestore catch (err) {
      print(err);
      rethrow;
    }
  }
}
