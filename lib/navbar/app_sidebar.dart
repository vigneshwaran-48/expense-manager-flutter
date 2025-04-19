import 'package:expense_manager/navbar/nav_list.dart';
import 'package:expense_manager/navbar/navbar_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppSidebar extends StatelessWidget {
  const AppSidebar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavbarCubit, int>(
      builder: (context, currentIndex) {
        return Container(
          constraints: BoxConstraints(maxWidth: 200),
          padding: EdgeInsets.all(10),
          child: NavList(selectedIndex: currentIndex),
        );
      },
    );
  }
}
