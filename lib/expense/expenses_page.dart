import 'package:expense_manager/expense/expenses_container.dart';
import 'package:expense_manager/user/bloc/user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExpensesPage extends StatelessWidget {
  const ExpensesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        if (state is UserLoading) {
          return Center(child: CircularProgressIndicator(color: Colors.white));
        }
        if (state is UserLoaded) {
          return ExpensesContainer(userId: state.user.id);
        }
        if (state is UserError) {
          return Center(child: Text(state.errMsg));
        }
        return Center(child: Text("Unknown State"));
      },
    );
  }
}
