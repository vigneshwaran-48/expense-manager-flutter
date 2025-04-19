part of 'expenses_bloc.dart';

@immutable
sealed class ExpensesEvent {}

final class LoadExpenses extends ExpensesEvent {}

final class AddExpense extends ExpensesEvent {
  final Expense expense;

  AddExpense({required this.expense});
}
