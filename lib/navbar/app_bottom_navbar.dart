import 'package:expense_manager/navbar/constants.dart';
import 'package:expense_manager/navbar/navbar_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AppBottomNavbar extends StatelessWidget {
  const AppBottomNavbar({super.key});

  @override
  Widget build(BuildContext context) {
    void _onPressed(int index) {
      context.read<NavbarCubit>().updateIndex(index);
      context.go(navRoutes[index]);
    }

    return BlocBuilder<NavbarCubit, int>(
      builder: (blocContext, index) {
        return BottomAppBar(
          elevation: 0,
          shape: CircularNotchedRectangle(),
          notchMargin: 10,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: Icon(Icons.dashboard),
                onPressed: () => _onPressed(0),
              ),
              IconButton(
                icon: Icon(Icons.payment),
                onPressed: () => _onPressed(1),
              ),
              IconButton(
                icon: Icon(Icons.family_restroom),
                onPressed: () => _onPressed(2),
              ),
              IconButton(
                icon: Icon(Icons.category),
                onPressed: () => _onPressed(3),
              ),
            ],
          ),
        );
      },
    );
  }
}
