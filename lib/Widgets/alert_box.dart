import 'package:flutter/material.dart';

Widget alertbox(String message, BuildContext context) {
  return AlertDialog(
    title: const Row(
      children: [
        Icon(Icons.error, color: Colors.red),
        SizedBox(width: 10),
        Text('Error'),
      ],
    ),
    content: Text(message),
    actions: <Widget>[
      TextButton(
        child: const Text('Okay'),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
    ],
  );
}
