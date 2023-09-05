import 'package:flutter/material.dart';

void showToast(BuildContext context, String message, Color? color) {
  final scaffold = ScaffoldMessenger.of(context);
  scaffold.showSnackBar(
    SnackBar(
      backgroundColor: color,
      content: Text(message),
      action: SnackBarAction(
        label: 'Ok',
        textColor: Colors.white,
        onPressed: scaffold.hideCurrentSnackBar,
      ),
    ),
  );
}
