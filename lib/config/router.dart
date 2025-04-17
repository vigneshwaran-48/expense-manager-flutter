import 'package:expense_manager/auth/bloc/auth_bloc.dart';
import 'package:expense_manager/auth/bloc/auth_state.dart';
import 'package:expense_manager/auth/login_page.dart';
import 'package:expense_manager/auth/signup_page.dart';
import 'package:expense_manager/layout.dart';
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
        final authState = context.read<AuthBloc>();
        final isAuthURL =
            state.matchedLocation == "/login" ||
            state.matchedLocation == "/signup";
        if (!isAuthURL && authState is! Authenticated) {
          return "/login";
        }
        return null;
      },
      routes: [
        ShellRoute(
          builder: (context, state, child) => AppLayout(child: child),
          routes: [
            GoRoute(path: "/", builder: (context, state) => Text("Dashboard")),
            GoRoute(
              path: "/expenses",
              builder: (context, state) => Text("Expenses"),
            ),
            GoRoute(
              path: "/family",
              builder: (context, state) => Text("Family"),
            ),
            GoRoute(
              path: "/categories",
              builder: (context, state) => Text("Categories"),
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
    );
  }
}
