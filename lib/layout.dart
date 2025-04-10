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

    return Scaffold(
      appBar: AppBar(title: Text("Home")),
      drawer: isTabLikeScreen ? AppDrawer() : null,
      bottomNavigationBar: isMobile ? AppBottomNavbar() : null,
      body: Row(
        children: [
          if (!isMobile && !isTabLikeScreen)
            SizedBox(width: 250, child: AppSidebar()),
          Expanded(child: child),
        ],
      ),
    );
  }
}
