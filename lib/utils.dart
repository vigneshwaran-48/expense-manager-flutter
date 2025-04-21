import 'package:flutter/material.dart';

SnackBar buildSnackbar({
  required BuildContext context,
  required String message,
  required bool isError,
  required Function onClose,
}) {
  return SnackBar(
    elevation: 0,
    backgroundColor: Colors.transparent,
    content: Card(
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
            IconButton(onPressed: () => onClose(context), icon: Icon(Icons.close)),
          ],
        ),
      ),
    ),
    behavior: SnackBarBehavior.floating,
  );
}
