import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_manager/user/AppUser.dart';

class Expense {
  final String? id;
  final String? title;
  final String? description;
  final AppUser? createdBy;
  final double? amount;
  final Timestamp? date;

  const Expense({
    this.id,
    this.title,
    this.description,
    this.createdBy,
    this.amount,
    this.date,
  });

  static Future<Expense> fromFireStore(
    QueryDocumentSnapshot<Map<String, dynamic>> data,
  ) async {
    final createdByRef =
        data.get("createdBy") as DocumentReference<Map<String, dynamic>>?;
    AppUser? createdByUser;
    final createdBySnapshot = await createdByRef?.get();
    createdByUser = AppUser.fromFireStore(
      createdBySnapshot!.data()!,
      createdBySnapshot.id,
    );

    return Expense(
      id: data.id,
      title: data.get("title"),
      description: data.get("description"),
      createdBy: createdByUser,
      amount: data.get("amount"),
      date: data.get("date"),
    );
  }

  Map<String, dynamic> toFireStore(DocumentReference createdBy) {
    return {
      "id": id,
      "title": title,
      "description": description,
      "createdBy": createdBy,
      "amount": amount,
      "date": date,
      "titleLowerCase": title?.toLowerCase(), // Used for searching
    };
  }
}
