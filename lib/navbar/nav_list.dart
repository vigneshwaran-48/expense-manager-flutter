import 'package:expense_manager/navbar/constants.dart';
import 'package:expense_manager/navbar/navbar_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class NavList extends StatelessWidget {
  NavList({super.key, required this.selectedIndex, this.isDrawer = false});

  final int selectedIndex;
  bool isDrawer;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: navTitles.length,
      itemBuilder: (context, index) {
        bool isActive = index == selectedIndex;
        return ListTile(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
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
            if (isDrawer) {
              Scaffold.of(context).closeDrawer();
            }
          },
        );
      },
    );
  }
}
