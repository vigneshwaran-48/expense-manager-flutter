import 'package:expense_manager/navbar/app_bottom_navbar.dart';
import 'package:expense_manager/navbar/app_drawer.dart';
import 'package:expense_manager/navbar/app_sidebar.dart';
import 'package:expense_manager/navbar/constants.dart';
import 'package:expense_manager/navbar/navbar_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppLayout extends StatelessWidget {
  const AppLayout({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    bool isMobile = width <= 550;
    bool isTabLikeScreen = width > 550 && width < 1200;

    return SafeArea(
      child: Container(
        color: Theme.of(context).colorScheme.onPrimary,
        padding: EdgeInsets.all(isMobile ? 10 : 15),
        child: Row(
          children: [
            if (!isMobile && !isTabLikeScreen)
              Card(
                margin: EdgeInsets.zero,
                color: Theme.of(context).colorScheme.surface,
                child: Row(
                  children: [
                    AppSidebar(),
                    Container(
                      width: 15,
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ],
                ),
              ),
            Expanded(
              child: Scaffold(
                appBar: _appBar(),
                drawer: isTabLikeScreen ? AppDrawer() : null,
                bottomNavigationBar: isMobile ? AppBottomNavbar() : null,
                body: Column(
                  children: [
                    Container(
                      height: 15,
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                    Expanded(child: child),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

AppBar _appBar() {
  return AppBar(
    title: BlocBuilder<NavbarCubit, int>(
      builder: (context, index) {
        return Text(navTitles[index]);
      },
    ),
  );
}
