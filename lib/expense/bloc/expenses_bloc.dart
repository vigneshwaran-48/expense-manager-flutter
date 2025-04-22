import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_manager/expense/expense.dart';
import 'package:expense_manager/expense/expense_service.dart';
import 'package:meta/meta.dart';

part 'expenses_event.dart';

part 'expenses_state.dart';

class ExpensesBloc extends Bloc<ExpensesEvent, ExpensesState> {
  final ExpenseService expenseService;

  ExpensesBloc({required this.expenseService}) : super(ExpensesInitial()) {
    on<LoadExpenses>((event, emit) async {
      try {
        emit(ExpensesLoading());
        final expenses = await expenseService.getExpenses();
        emit(ExpensesLoaded(expenses: expenses));
      } on FirebaseException catch (err) {
        print(err);
        emit(
          ExpensesError(
            errMsg:
                err.message != null
                    ? err.message!
                    : "Error while getting expenses",
          ),
        );
      } catch (err) {
        print(err);
        emit(ExpensesError(errMsg: "Error while getting expenses"));
      }
    });

    on<AddExpense>((event, emit) async {
      try {
        emit(AddingExpense());
        final addedExpense = await expenseService.addExpense(event.expense);
        emit(ExpenseAdded(expense: addedExpense));
      } on FirebaseException catch (err) {
        print(err);
        emit(
          ExpensesError(
            errMsg:
                err.message != null
                    ? err.message!
                    : "Error while adding expenses",
          ),
        );
      } catch (err) {
        print(err);
        emit(ExpensesError(errMsg: "Error while adding expenses"));
      }
    });

    on<RemoveExpense>((event, emit) async {
      try {
        emit(ExpenseDeleting(id: event.id));
        await expenseService.removeExpense(event.id);
        emit(ExpenseDeleted(id: event.id));
      } on FirebaseException catch (err) {
        print(err);
        emit(ExpensesError(errMsg: "Error while removing expense"));
      } catch (err) {
        print(err);
        emit(ExpensesError(errMsg: "Error while removing expense"));
      }
    });
  }
}
