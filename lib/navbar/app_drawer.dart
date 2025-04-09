import 'package:expense_manager/navbar/constants.dart';
import 'package:expense_manager/navbar/navbar_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

const List<Icon> _navIcons = [
  Icon(Icons.dashboard),
  Icon(Icons.payment),
  Icon(Icons.family_restroom),
  Icon(Icons.category),
  Icon(Icons.settings),
];

const List<String> _navTitles = [
  "Dashboard",
  "Expenses",
  "Family",
  "Categories",
  "Settings",
];

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavbarCubit, int>(
      builder: (context, index) {
        return Drawer(
          child: ListView.builder(
            itemCount: _navTitles.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: _navIcons[index],
                title: Text(_navTitles[index]),
                onTap: () {
                  context.read<NavbarCubit>().updateIndex(index);
                  context.go(navRoutes[index]);
                  Navigator.pop(context); // Closes the drawer.
                },
              );
            },
          ),
        );
      },
    );
  }
}
