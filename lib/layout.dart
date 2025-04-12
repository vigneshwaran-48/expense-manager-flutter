import 'package:expense_manager/navbar/app_bottom_navbar.dart';
import 'package:expense_manager/navbar/app_drawer.dart';
import 'package:expense_manager/navbar/app_sidebar.dart';
import 'package:flutter/material.dart';

class AppLayout extends StatelessWidget {
  const AppLayout({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    bool isMobile = width <= 550;
    bool isTabLikeScreen = width > 550 && width < 1200;

    return Container(
      color: Theme.of(context).colorScheme.onPrimary,
      padding: EdgeInsets.all(isMobile ? 0 : 15),
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
    );
  }
}

AppBar _appBar() {
  return AppBar(
    title: Text(
      "Home",
      style: TextStyle(backgroundColor: const Color(0xFF1B1B1B)),
    ),
  );
}
