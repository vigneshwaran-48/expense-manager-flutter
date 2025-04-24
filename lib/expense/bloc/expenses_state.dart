part of 'expenses_bloc.dart';

@immutable
sealed class ExpensesState {}

final class ExpensesInitial extends ExpensesState {}

final class ExpensesLoading extends ExpensesState {}

final class ExpensesError extends ExpensesState {
  final String errMsg;

  ExpensesError({required this.errMsg});
}

final class ExpensesLoaded extends ExpensesState {
  final List<Expense> expenses;

  ExpensesLoaded({required this.expenses});
}

final class ExpenseAdded extends ExpensesState {
  final Expense expense;

  ExpenseAdded({required this.expense});
}

final class AddingExpense extends ExpensesState {}

final class ExpenseDeleted extends ExpensesState {
  final String id;

  ExpenseDeleted({required this.id});
}

final class SearchingExpenses extends ExpensesState {}
