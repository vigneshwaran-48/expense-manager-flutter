import 'package:cloud_firestore/cloud_firestore.dart';

class Expense {
  final String? id;
  final String? title;
  final String? description;
  final String? createdBy;

  const Expense({this.id, this.title, this.description, this.createdBy});

  factory Expense.fromFireStore(
    QueryDocumentSnapshot<Map<String, dynamic>> data,
  ) {
    return Expense(
      id: data.id,
      title: data.get("title"),
      description: data.get("description"),
      createdBy: data.get("createdBy"),
    );
  }
}
