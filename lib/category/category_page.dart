import 'package:expense_manager/category/bloc/category_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryPage extends StatelessWidget {
  const CategoryPage({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryBloc, CategoryState>(
      builder: (context, state) {
        if (state is CategoryInitializing || state.isLoading) {
          return Center(child: CircularProgressIndicator(color: Colors.white));
        }
        if (state.categories != null) {
          return child;
        }
        if (state.isError) {
          return Center(child: Text(state.errMsg));
        }
        return Center(child: Text("Unknown State"));
      },
    );
  }
}
