import 'package:flutter/material.dart';

class ReusableDialog {
  static Future<void> show(
    BuildContext context, {
    required String title,
    required String message,
    String positiveButtonText = 'OK',
    String? negativeButtonText,
    VoidCallback? onPositiveButtonPressed,
    VoidCallback? onNegativeButtonPressed,
  }) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            if (negativeButtonText != null)
              TextButton(
                onPressed: () {
                  if (onNegativeButtonPressed != null) {
                    onNegativeButtonPressed();
                  }
                  Navigator.of(context).pop();
                },
                child: Text(negativeButtonText),
              ),
            TextButton(
              onPressed: () {
                if (onPositiveButtonPressed != null) {
                  onPositiveButtonPressed();
                }
                Navigator.of(context).pop();
              },
              child: Text(positiveButtonText),
            ),
          ],
        );
      },
    );
  }
}
