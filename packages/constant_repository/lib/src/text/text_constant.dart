import 'package:constant_repository/src/color/color.dart';
import 'package:flutter/material.dart';

class TextConstant {
  static TextFontSize fontSize = const TextFontSize();
  static TextFontWeight fontWeight = const TextFontWeight();
  static TextFontColor fontColor = const TextFontColor();
}

class TextFontSize {
  const TextFontSize();

  double get largeTitle => 36.0;
  double get title1 => 30.0;
  double get title2 => 24.0;
  double get title3 => 22.0;
  double get headline => 19.0;
  double get body => 19.0;
  double get callout => 18.0;
  double get subhead => 17.0;
  double get footnote => 15.0;
  double get caption1 => 14.0;
  double get caption2 => 13.0;
}

class TextFontWeight {
  const TextFontWeight();

  FontWeight get largeTitle => FontWeight.w800;
  FontWeight get title1 => FontWeight.w700;
  FontWeight get title2 => FontWeight.w600;
  FontWeight get title3 => FontWeight.w500;
  FontWeight get headline => FontWeight.w500;
  FontWeight get body => FontWeight.normal;
  FontWeight get callout => FontWeight.normal;
  FontWeight get subhead => FontWeight.normal;
  FontWeight get footnote => FontWeight.normal;
  FontWeight get caption1 => FontWeight.normal;
  FontWeight get caption2 => FontWeight.normal;
}

class TextFontColor {
  const TextFontColor();

  Color get largeTitle => Colors.black87;
  Color get title1 => Colors.black87;
  Color get title2 => Colors.black87;
  Color get title3 => Colors.black54;
  Color get headline => Colors.black54;
  Color get body => Colors.black54;
  Color get bodyLight => Colors.white;
  Color get callout => Colors.black45;
  Color get subhead => Colors.black45;
  Color get footnote => Colors.black45;
  Color get caption1 => Colors.black45;
  Color get caption2 => Colors.black45;

  Color get primary => ColorConstant.primary;
  Color get primaryVariant => ColorConstant.primaryVariant;
  Color get secondary => ColorConstant.secondary;
  Color get secondaryVariant => ColorConstant.secondaryVariant;
}
