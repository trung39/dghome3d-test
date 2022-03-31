import 'package:dghome3d/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

Widget titleText(String text) {
  return Text(text,
    style: TextStyle(
        color: primaryColor,
        fontWeight: FontWeight.bold,
        fontSize: 42
    ),
  );
}

Widget highlightText(String text, ) {
  return Text(text,
    style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold),
  );
}

Widget textField({required String title, Widget? prefix, IconData? leading, String? hint, bool isPassword = false}) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(title, style: TextStyle(fontSize: 16),),
      Padding(
        padding: const EdgeInsets.only(top: 8),
        child: TextFormField(
          textAlign: (leading == null && prefix == null) ? TextAlign.center : TextAlign.start,
          decoration: InputDecoration(
            prefixIcon: leading != null ? Icon(leading, color: primaryColor) : prefix,
            hintText: isPassword ? "•••••••" : hint,
            hintStyle: TextStyle(color: Colors.grey),
            contentPadding: const EdgeInsets.fromLTRB(12, 18, 12, 18),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: primaryColor, width: 1),
              borderRadius: BorderRadius.circular(textFieldBorderRadius),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: primaryColor, width: 2),
              borderRadius: BorderRadius.circular(textFieldBorderRadius),
            ),
          ),
          obscureText: isPassword,
          obscuringCharacter: "•",
        ),
      )
    ],
  );
}