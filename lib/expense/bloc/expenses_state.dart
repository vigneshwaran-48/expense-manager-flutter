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
