
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ImageAssets {
  static SvgPicture svgAssets(
      context,
      String name, {
        Color? color,
        double? width,
        double? height,
        BoxFit fit = BoxFit.contain,
      }) {
    return SvgPicture.asset(
      name,
      color: color,
      width: width ?? MediaQuery.of(context).size.width * 0.06,
      height: height ?? MediaQuery.of(context).size.width * 0.06,
      fit: fit,
    );
  }
}
