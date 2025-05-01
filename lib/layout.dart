import 'package:expense_manager/category/AddCategoryModal.dart';
import 'package:expense_manager/navbar/app_bottom_navbar.dart';
import 'package:expense_manager/navbar/app_drawer.dart';
import 'package:expense_manager/navbar/app_sidebar.dart';
import 'package:expense_manager/navbar/constants.dart';
import 'package:expense_manager/navbar/navbar_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AppLayout extends StatelessWidget {
  const AppLayout({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    bool isMobile = width <= 550;
    bool isTabLikeScreen = width > 550 && width < 1200;

    String uri = GoRouterState.of(context).uri.toString();

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
                extendBody: true,
                appBar: _appBar(),
                drawer: isTabLikeScreen ? AppDrawer() : null,
                floatingActionButton:
                    uri == "/expenses" || uri == "/categories"
                        ? FloatingActionButton(
                          onPressed: () {
                            if (uri == "/expenses") {
                              context.go("/expenses/create");
                              return;
                            }
                            // Otherwise considering it as /categories' add button
                            showAddCategoryModal(context);
                          },
                          shape: CircleBorder(),
                          child: Icon(Icons.add),
                        )
                        : null,
                floatingActionButtonLocation:
                    isMobile
                        ? FloatingActionButtonLocation.centerDocked
                        : FloatingActionButtonLocation.endFloat,
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
