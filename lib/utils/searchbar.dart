import 'package:flutter/material.dart';

class AppSearchBar extends StatefulWidget {
  const AppSearchBar({super.key, required this.onSearch});

  final Function(String value) onSearch;

  @override
  State<StatefulWidget> createState() => _SearchBarState();
}

class _SearchBarState extends State<AppSearchBar> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: TextField(
        textAlignVertical: TextAlignVertical.center,
        controller: _searchController,
        onChanged: widget.onSearch,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.search),
          hintText: "Search",
          border: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.grey),
          ),
        ),
      ),
    );
  }
}
