import 'package:flutter/material.dart';

class AppSnackBar extends StatelessWidget {
  const AppSnackBar({super.key, required this.message, required this.isError});

  final String message;
  final bool isError;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      color: isError ? Colors.red : Theme.of(context).colorScheme.onPrimary,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(isError ? Icons.error : Icons.info),
            SizedBox(width: 10),
            Expanded(child: Text(message)),
            IconButton(
              onPressed: () => ScaffoldMessenger.of(context).clearSnackBars(),
              icon: Icon(Icons.close),
            ),
          ],
        ),
      ),
    );
  }
}

SnackBar buildSnackBar({required String message, required bool isError}) {
  return SnackBar(
    elevation: 0,
    backgroundColor: Colors.transparent,
    behavior: SnackBarBehavior.floating,
    content: AppSnackBar(message: message, isError: isError),
  );
}
