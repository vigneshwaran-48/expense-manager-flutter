import 'package:expense_manager/expense/expense.dart';
import 'package:flutter/material.dart';

class ExpenseItem extends StatelessWidget {
  const ExpenseItem({super.key, required this.expense});

  final Expense expense;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(expense.title!),
          Text(expense.amount.toString()),
          Text(expense.date!.toDate().toString()),
          Text(expense.createdBy!.email)
        ],
      ),
    );
  }
}
