import 'package:expense_manager/expense/bloc/expenses_bloc.dart';
import 'package:expense_manager/expense/expense_item.dart';
import 'package:expense_manager/utils.dart';
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
                  child: _SearchBar(),
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
                  return Center(child: Text("Error while loading expenses"));
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

class _SearchBar extends StatefulWidget {
  const _SearchBar({super.key});

  @override
  State<StatefulWidget> createState() => _SearchBarState();
}

class _SearchBarState extends State<_SearchBar> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void handleSearch(_) {
    context.read<ExpensesBloc>().add(
      SearchExpense(term: _searchController.text),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: TextField(
        textAlignVertical: TextAlignVertical.center,
        controller: _searchController,
        onChanged: handleSearch,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.search),
          hintText: "Search",
          border: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.grey),
          ),
        ),
      ),
    );
  }
}
