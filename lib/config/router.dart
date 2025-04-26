import 'package:expense_manager/auth/bloc/auth_bloc.dart';
import 'package:expense_manager/auth/bloc/auth_event.dart';
import 'package:expense_manager/auth/bloc/auth_state.dart';
import 'package:expense_manager/auth/login_page.dart';
import 'package:expense_manager/auth/signup_page.dart';
import 'package:expense_manager/category/categories_container.dart';
import 'package:expense_manager/category/category_page.dart';
import 'package:expense_manager/config/app_listener.dart';
import 'package:expense_manager/expense/create/expense_create.dart';
import 'package:expense_manager/expense/expenses_container.dart';
import 'package:expense_manager/expense/expenses_page.dart';
import 'package:expense_manager/layout.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static final AppRouter instance = AppRouter._internal();

  AppRouter._internal();

  GoRouter? _router;

  GoRouter get router {
    if (_router == null) {
      _init();
    }
    return _router!;
  }

  void _init() {
    _router = GoRouter(
      initialLocation: "/",
      redirect: (context, state) {
        final isAuthURL =
            state.matchedLocation == "/login" ||
            state.matchedLocation == "/signup";
        if (!isAuthURL && FirebaseAuth.instance.currentUser == null) {
          return "/login";
        }
        return null;
      },
      routes: [
        ShellRoute(
          builder: (context, state, child) => AppListener(child: child),
          routes: [
            ShellRoute(
              builder: (context, state, child) => AppLayout(child: child),
              routes: [
                GoRoute(
                  path: "/",
                  builder: (context, state) => Text("Dashboard"),
                ),
                ShellRoute(
                  builder:
                      (context, state, child) => ExpensesPage(child: child),
                  routes: [
                    GoRoute(
                      path: "/expenses",
                      builder: (context, state) => const ExpensesContainer(),
                    ),
                    GoRoute(
                      path: "/expenses/create",
                      builder: (context, state) => const ExpenseCreatePage(),
                    ),
                  ],
                ),
                GoRoute(
                  path: "/family",
                  builder: (context, state) => Text("Family"),
                ),
                ShellRoute(
                  builder:
                      (context, state, child) => CategoryPage(child: child),
                  routes: [
                    GoRoute(
                      path: "/categories",
                      builder: (context, state) => CategoriesContainer(),
                    ),
                  ],
                ),
                GoRoute(
                  path: "/settings",
                  builder: (context, state) => Text("Settings"),
                ),
              ],
            ),
            GoRoute(path: "/signup", builder: (context, state) => SignupPage()),
            GoRoute(path: "/login", builder: (context, state) => LoginPage()),
          ],
        ),
      ],
    );
  }
}
