import 'package:expense_manager/expense/bloc/expenses_bloc.dart';
import 'package:expense_manager/expense/expense.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    expense.title!,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  ExpenseDeleteButton(id: expense.id!),
                ],
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

class ExpenseDeleteButton extends StatefulWidget {
  const ExpenseDeleteButton({super.key, required this.id});

  final String id;

  @override
  State<StatefulWidget> createState() => _ExpenseDeleteButtonState();
}

class _ExpenseDeleteButtonState extends State<ExpenseDeleteButton> {
  bool _deleting = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 48.0,
      height: 48.0,
      child: Stack(
        alignment: Alignment.center,
        children: [
          if (!_deleting)
            IconButton(
              onPressed: () {
                setState(() {
                  _deleting = true;
                });
                context.read<ExpensesBloc>().add(RemoveExpense(id: widget.id));
              },
              icon: const Icon(Icons.delete),
              color: Colors.red,
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            ),
          if (_deleting)
            const SizedBox(
              width: 24.0,
              height: 24.0,
              child: CircularProgressIndicator(
                color: Colors.red,
                strokeWidth: 2.0,
              ),
            ),
        ],
      ),
    );
  }
}
