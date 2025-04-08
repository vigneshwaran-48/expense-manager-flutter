import 'package:expense_manager/layout.dart';
import 'package:flutter/cupertino.dart';
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
      routes: [
        ShellRoute(
          builder:
              (context, state, child) =>
                  AppLayout(key: UniqueKey(), child: child),
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
      ],
    );
  }
}
