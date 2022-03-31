import 'package:dghome3d/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'buttons.dart';

Widget appScaffold(BuildContext context,
    {required Widget body,
      PreferredSizeWidget? appBar,
      VoidCallback? onAppBarLeadingTap,
    }) {
  return Scaffold(
    appBar: appBar ?? AppBar(
      leading: appBackButton(context, onPressed: onAppBarLeadingTap),
      backgroundColor: Colors.transparent,
      elevation: 0,
    ),
    body: Container(
      padding: EdgeInsets.fromLTRB(sideMargin, 48, sideMargin, sideMargin),
      child: body,
    ),
  );
}