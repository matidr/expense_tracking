import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future<T?> showAppDialog<T>(
  BuildContext context,
  String title,
  String description,
  String buttonText,
) {
  Widget titleWidget = Text(title);
  Widget contentWidget = Text(description);
  List<Widget> actions = [
    TextButton(
      onPressed: () {
        Navigator.pop(context);
      },
      child: Text(buttonText),
    ),
  ];

  if (Platform.isIOS) {
    return showCupertinoDialog(
      context: context,
      builder: (ctx) => CupertinoAlertDialog(
        title: titleWidget,
        content: contentWidget,
        actions: actions,
      ),
    );
  } else {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: titleWidget,
        content: contentWidget,
        actions: actions,
      ),
    );
  }
}
