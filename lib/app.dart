import 'package:flutter/material.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    bool isMobile = width <= 550;
    bool isTabLikeScreen = width > 550 && width < 1200;

    return Scaffold(
      appBar: AppBar(title: Text("Home")),
      drawer: isTabLikeScreen ? _drawer() : null,
      bottomNavigationBar: isMobile ? _bottomNavigationBar() : null,
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

BottomNavigationBar _bottomNavigationBar() {
  return BottomNavigationBar(
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
