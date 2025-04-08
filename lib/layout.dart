import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

const List<String> routes = [
  "/",
  "/expenses",
  "/family",
  "/categories",
  "settings",
];

class AppLayout extends StatefulWidget {
  const AppLayout({super.key, required this.child});

  final Widget child;

  @override
  State<StatefulWidget> createState() => _AppLayoutState(child: child);
}

class _AppLayoutState extends State<AppLayout> {
  _AppLayoutState({required this.child});

  final Widget child;

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    bool isMobile = width <= 550;
    bool isTabLikeScreen = width > 550 && width < 1200;

    void _onTap(int index) {
      context.go(routes[index]);
      setState(() {
        _currentIndex = index;
      });
    }

    return Scaffold(
      appBar: AppBar(title: Text("Home")),
      drawer: isTabLikeScreen ? _drawer() : null,
      bottomNavigationBar:
          isMobile ? _bottomNavigationBar(_onTap, _currentIndex) : null,
      body: child,
    );
  }
}

Drawer _drawer() {
  return Drawer(
    child: ListView(
      children: [
        ListTile(
          leading: Icon(Icons.dashboard),
          title: const Text("Dashboard"),
        ),
        ListTile(leading: Icon(Icons.payment), title: const Text("Expenses")),
        ListTile(
          leading: Icon(Icons.family_restroom),
          title: const Text("Family"),
        ),
        ListTile(
          leading: Icon(Icons.category),
          title: const Text("Categories"),
        ),
        ListTile(leading: Icon(Icons.settings), title: const Text("Settings")),
      ],
    ),
  );
}

BottomNavigationBar _bottomNavigationBar(
  void Function(int) onTap,
  int currentIndex,
) {
  return BottomNavigationBar(
    onTap: onTap,
    currentIndex: currentIndex,
    items: [
      BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: "Dashboard"),
      BottomNavigationBarItem(icon: Icon(Icons.payment), label: "Expenses"),
      BottomNavigationBarItem(
        icon: Icon(Icons.family_restroom),
        label: "Family",
      ),
      BottomNavigationBarItem(icon: Icon(Icons.category), label: "Categories"),
      BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Settings"),
    ],
  );
}
