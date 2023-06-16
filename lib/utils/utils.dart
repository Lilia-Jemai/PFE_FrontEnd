import 'package:flutter/material.dart';

class Utils {
  static void showSnack(BuildContext ctx, IconData ic, bool success, String txt) {
    ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(
        backgroundColor: success ? Colors.green : Colors.orange,
        behavior: SnackBarBehavior.floating,
        content: Row(children: [
          Icon(ic, color: Colors.white),
          SizedBox(
            width: 8,
          ),
          Flexible(
            child: Text(txt),
          )
        ])));
  }
}
