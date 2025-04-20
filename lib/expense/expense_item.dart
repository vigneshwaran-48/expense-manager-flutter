import 'dart:math';

import 'package:expense_manager/expense/expense.dart';
import 'package:flutter/material.dart';

class ExpenseItem extends StatelessWidget {
  const ExpenseItem({super.key, required this.expense});

  final Expense expense;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(7),
        color: Theme.of(context).colorScheme.onPrimary,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                expense.title!,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(expense.date!.toDate().toString()),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "₹ ${expense.amount.toString()}",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Text(expense.createdBy!.email),
            ],
          ),
        ],
      ),
    );
  }
}
