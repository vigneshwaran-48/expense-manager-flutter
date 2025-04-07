import 'package:flutter/material.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    bool isMobile = width <= 550;
    bool isTabLikeScreen = width > 550 && width < 1200;

    return Scaffold(
      appBar: AppBar(title: Text("Home")),
      drawer: isTabLikeScreen ? Drawer() : null,
      bottomNavigationBar:
          isMobile
              ? BottomNavigationBar(
                items: [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: "Home",
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: "Expenses",
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: "Family",
                  ),
                ],
              )
              : null,
    );
  }
}
