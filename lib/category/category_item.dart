import 'package:expense_manager/category/category.dart';
import 'package:flutter/material.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem({super.key, required this.category});

  final Category category;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(7),
        color: Theme.of(context).colorScheme.onPrimary,
      ),
      child: Column(
        children: [
          Text(category.name!),
          Text(category.description != null ? category.description! : ""),
        ],
      ),
    );
  }
}
