import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_manager/expense/expense.dart';
import 'package:expense_manager/user/AppUser.dart';
import 'package:expense_manager/user/user_service.dart';

class ExpenseService {
  final String userId;

  final UserService _userService = UserService();
  final CollectionReference<Map<String, dynamic>> _expenseCollection;

  ExpenseService({required this.userId})
    : _expenseCollection = FirebaseFirestore.instance
          .collection("users")
          .doc(userId)
          .collection("expenses");

  Future<List<Expense>> getExpenses() async {
    try {
      final snapshot = await _expenseCollection.get();
      final expenseFutures =
          snapshot.docs.map((doc) => Expense.fromFireStore(doc)).toList();
      return await Future.wait(expenseFutures);
    } on FirebaseFirestore catch (err) {
      print(err);
      rethrow;
    } catch (err) {
      print(err);
      rethrow;
    }
  }

  Future<Expense> addExpense(Expense expense) async {
    try {
      final user = await _userService.getUserRef(userId);
      final result = await FirebaseFirestore.instance
          .collection("users")
          .doc(userId)
          .collection("expenses")
          .add(expense.toFireStore(user));
      return Expense(
        id: result.id,
        title: expense.title,
        description: expense.description,
        createdBy: AppUser.fromFireStore((await user.get()).data()!, user.id),
      );
    } on FirebaseException catch (err) {
      print(err);
      rethrow;
    }
  }

  Future<void> removeExpense(String id) async {
    try {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(userId)
          .collection("expenses")
          .doc(id)
          .delete();
    } on FirebaseException catch (err) {
      print(err);
      rethrow;
    }
  }

  Future<List<Expense>> searchExpenses(String term) async {
    term = term.toLowerCase();
    try {
      final results =
          await FirebaseFirestore.instance
              .collection("users")
              .doc(userId)
              .collection("expenses")
              .where("titleLowerCase", isGreaterThanOrEqualTo: term)
              .where("titleLowerCase", isLessThanOrEqualTo: "$term\uf8ff")
              .get();
      final expenseFutures =
          results.docs.map((doc) => Expense.fromFireStore(doc)).toList();
      return await Future.wait(expenseFutures);
    } on FirebaseException catch (err) {
      print(err);
      rethrow;
    }
  }
}
