import 'package:flutter/material.dart';

void showNotificationDialog(String title, String? content, BuildContext context) {
  showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(title),
        content: content != null ? Text(content) : Text("Có lỗi xảy ra"),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'OK'),
            child: const Text('OK'),
          ),
        ],
      ));
}
