part of 'expenses_bloc.dart';

@immutable
sealed class ExpensesEvent {}

final class LoadExpenses extends ExpensesEvent {}

final class AddExpense extends ExpensesEvent {
  final Expense expense;

  AddExpense({required this.expense});
}

final class RemoveExpense extends ExpensesEvent {
  final String id;

  RemoveExpense({required this.id});
}

final class SearchExpense extends ExpensesEvent {
  final String term;

  SearchExpense({required this.term});
}
