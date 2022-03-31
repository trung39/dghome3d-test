import 'package:flutter/material.dart';

Color primaryColor = const Color(0xFF575DFB);
ThemeData appThemeData = ThemeData(
  primaryColor: primaryColor,
  primarySwatch: Colors.blue,
  iconTheme: IconThemeData(
    color: primaryColor,
  ),
  buttonTheme: ButtonThemeData(),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      minimumSize: MaterialStateProperty.all(Size.fromHeight(40)),
      textStyle: MaterialStateProperty.all(
          TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      padding:
          MaterialStateProperty.all(const EdgeInsets.fromLTRB(12, 20, 12, 20)),
      backgroundColor: MaterialStateProperty.all(primaryColor),
      shape: MaterialStateProperty.all(RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(textFieldBorderRadius))),
    )
  )
);
double sideMargin = 24;
double textFieldBorderRadius = 16;

