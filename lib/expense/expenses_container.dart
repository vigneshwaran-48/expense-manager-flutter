import 'package:expense_manager/expense/bloc/expenses_bloc.dart';
import 'package:expense_manager/expense/expense_item.dart';
import 'package:expense_manager/expense/expense_service.dart';
import 'package:expense_manager/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExpensesContainer extends StatelessWidget {
  const ExpensesContainer({super.key, required this.userId});

  final String userId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (_) =>
              ExpensesBloc(expenseService: ExpenseService(userId: userId))
                ..add(LoadExpenses()),
      child: _ExpensesContainer(),
    );
  }
}

class _ExpensesContainer extends StatelessWidget {
  const _ExpensesContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ExpensesBloc, ExpensesState>(
      listener: (context, state) {
        if (state is ExpensesError) {
          ScaffoldMessenger.of(context).showSnackBar(
            buildSnackbar(
              context: context,
              isError: true,
              message: state.errMsg,
              onClose: () => ScaffoldMessenger.of(context).clearSnackBars(),
            ),
          );
        }
      },
      builder: (context, state) {
        if (state is ExpensesLoading) {
          return Center(child: CircularProgressIndicator(color: Colors.white));
        }
        if (state is ExpensesLoaded) {
          return Column(
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
                child: ListView.builder(
                  itemCount: state.expenses.length,
                  itemBuilder: (context, index) {
                    return ExpenseItem(expense: state.expenses[index]);
                  },
                ),
              ),
            ],
          );
        }
        if (state is ExpensesError) {
          return Center(child: Text("Error while loading expenses"));
        }
        return Center(child: Text("Unknown expense state $state"));
      },
    );
  }
}

class _SearchBar extends StatefulWidget {
  const _SearchBar({super.key});

  @override
  State<StatefulWidget> createState() => _SearchBarState();
}

class _SearchBarState extends State<_SearchBar> {
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: TextField(
        controller: _searchController,
        textAlignVertical: TextAlignVertical.center,
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
