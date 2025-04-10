import 'package:expense_manager/navbar/constants.dart';
import 'package:expense_manager/navbar/navbar_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AppSidebar extends StatelessWidget {
  const AppSidebar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavbarCubit, int>(
      builder: (context, currentIndex) {
        return Center(
          child: ListView.builder(
            itemCount: navTitles.length,
            itemBuilder: (context, index) {
              bool isActive = index == currentIndex;
              return ListTile(
                selected: isActive,
                leading: navIcons[index],
                textColor: Colors.white30,
                selectedColor: Colors.white,
                selectedTileColor: Colors.red,
                iconColor: Colors.white30,
                title: Text(navTitles[index]),
                onTap: () {
                  context.read<NavbarCubit>().updateIndex(index);
                  context.go(navRoutes[index]);
                },
              );
            },
          ),
        );
      },
    );
  }
}
