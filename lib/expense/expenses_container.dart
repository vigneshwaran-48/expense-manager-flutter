import 'package:expense_manager/expense/bloc/expenses_bloc.dart';
import 'package:expense_manager/expense/expense_item.dart';
import 'package:expense_manager/utils/app_snackbar.dart';
import 'package:expense_manager/utils/searchbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExpensesContainer extends StatelessWidget {
  const ExpensesContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Row(
            children: [
              Flexible(
                child: Container(
                  constraints: BoxConstraints(maxWidth: 500, minWidth: 100),
                  child: AppSearchBar(
                    onSearch: (value) {
                      context.read<ExpensesBloc>().add(
                        SearchExpense(term: value),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
          Divider(),
          Expanded(
            child: BlocConsumer<ExpensesBloc, ExpensesState>(
              listener: (context, state) {
                if (state is ExpensesError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    buildSnackBar(isError: true, message: state.errMsg),
                  );
                }
                if (state is ExpenseDeleted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    buildSnackBar(message: "Deleted expense", isError: false),
                  );
                  context.read<ExpensesBloc>().add(LoadExpenses());
                  return;
                }
              },
              builder: (context, state) {
                if (state is ExpensesLoading || state is ExpenseDeleted) {
                  return Center(
                    child: CircularProgressIndicator(color: Colors.white),
                  );
                }
                if (state is SearchingExpenses) {
                  return Center(child: Icon(Icons.search));
                }
                if (state is ExpensesError) {
                  return Center(child: Text(state.errMsg));
                }
                if (state is ExpensesLoaded) {
                  return GridView.builder(
                    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 400,
                      mainAxisExtent: 300,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemCount: state.expenses.length,
                    itemBuilder:
                        (context, index) =>
                            ExpenseItem(expense: state.expenses[index]),
                  );
                }
                return Center(child: Text("Unknown expense state $state"));
              },
            ),
          ),
        ],
      ),
    );
  }
}
