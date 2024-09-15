import 'package:flutter/material.dart';

showNotification(BuildContext context,
    {required String message, bool error = false}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      backgroundColor: error ? Colors.deepOrange : null,
    ),
  );
}

showConfirmModal(
  BuildContext context, {
  required Widget child,
  required Function onConfirmed,
}) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        actionsPadding: EdgeInsets.symmetric(horizontal: 20),
        content: child,
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              onConfirmed();
            },
            child: Text('OK'),
          ),
        ],
      );
    },
  );
}
