import 'package:dghome3d/assets/svg_loader.dart';
import 'package:dghome3d/theme.dart';
import 'package:flutter/material.dart';

Widget loginSelectiveButton(BuildContext context,
    {required String title, String? svgIcon, IconData? iconData, GestureTapCallback? onTap}) {
  assert(svgIcon != null || iconData != null,
      "A svg or iconData should be provided");
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 8),
    decoration: BoxDecoration(
      border: Border.all(color: Colors.black, width: 1.5),
      borderRadius: BorderRadius.circular(8),
    ),
    child: InkWell(
      onTap: onTap ?? (){},
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              (svgIcon != null)
                  ? ImageAssets.svgAssets(context, svgIcon)
                  : Icon(iconData, color: primaryColor,),
              const SizedBox(width: 8,),
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold),)
            ],
          ),
        ),
      ),
    ),
  );
}

Widget appBackButton(BuildContext context, {VoidCallback? onPressed}) {
  return IconButton(
    onPressed: () {
      if (onPressed != null) {
        onPressed();
      } else {
        Navigator.of(context).maybePop();
      }
    },
    icon: const Icon(Icons.keyboard_backspace, color: Colors.black,),
  );
}

Widget underlineTextButton({required String text, GestureTapCallback? onTap, bool isBoldText = true}) {
  return InkWell(
    onTap: onTap ?? (){},
    child: Padding(
      padding: const EdgeInsets.fromLTRB(8,8,8,8),
      child: Text(text,
        style: TextStyle(
            fontSize: 16,
            fontWeight: isBoldText ? FontWeight.bold : FontWeight.normal,
            decoration: TextDecoration.underline,
            decorationStyle: TextDecorationStyle.solid,
            color: primaryColor
        ),
      ),
    ),
  );
}
