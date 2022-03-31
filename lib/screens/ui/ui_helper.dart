
import 'package:flutter/material.dart';

Future showProgressDialog(BuildContext context) async {
  await showDialog<String>(
      context: context,
      builder: (context) {
        return const Dialog(
          child: Center(
              heightFactor: 2,
              child: CircularProgressIndicator()
          ),
        );
      });
}

/// Show a snack bar with the given information
showSnackBar(BuildContext context, String message,
    {String? actionName, function, SnackBarBehavior? behavior, int? duration}) {
  ScaffoldMessengerState scaffoldMessengerState = ScaffoldMessenger.of(context);
  scaffoldMessengerState.removeCurrentSnackBar();
  scaffoldMessengerState.showSnackBar(SnackBar(
    behavior: behavior ?? SnackBarBehavior.floating,
    duration: Duration(milliseconds: duration ?? 4000),
    content: Text(
      message,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    ),
    action: SnackBarAction(
      label: actionName ?? "OK",
      onPressed: function ?? () {},
    ),
  ));
}

Future showAlertDialog(BuildContext context, String message, {VoidCallback? onPressed}) async {
  await showDialog<String>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(message),
          actions: <Widget>[
            TextButton(
                child: Text('OK'),
                onPressed: onPressed ?? () => Navigator.pop(context)
            ),
          ],
        );
      });
}
