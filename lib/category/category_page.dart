import 'package:expense_manager/category/bloc/category_bloc.dart';
import 'package:expense_manager/category/category_service.dart';
import 'package:expense_manager/user/bloc/user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryPage extends StatelessWidget {
  const CategoryPage({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        if (state is UserLoading) {
          return Center(child: CircularProgressIndicator(color: Colors.white));
        }
        if (state is UserLoaded) {
          return BlocProvider(
            create:
                (_) => CategoryBloc(
                  categoryService: CategoryService(userId: state.user.id),
                )..add(LoadCategories()),
            child: child,
          );
        }
        if (state is UserError) {
          return Center(child: Text(state.errMsg));
        }
        return Center(child: Text("Unknown State"));
      },
    );
  }
}
