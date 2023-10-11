import 'package:flutter/material.dart';
import 'colors.dart';

class BRFontStyle {
  static TextStyle h1({Color color = BRColors.primaryText}) {
    return TextStyle(
      fontFamily: 'Inter',
      fontSize: 45,
      height: 1.3,
      fontWeight: FontWeight.w400,
      color: color,
    );
  }

  static TextStyle h2({Color color = BRColors.primaryText}) {
    return TextStyle(
      fontFamily: 'Inter',
      fontSize: 26,
      height: 1.3,
      fontWeight: FontWeight.w400,
      color: color,
    );
  }

  static TextStyle header(
    double size, {
    Color color = BRColors.primaryText,
    FontStyle fontStyle = FontStyle.italic,
    double? letterSpacing,
    FontWeight fontWeight = FontWeight.w400,
  }) {
    return TextStyle(
      fontFamily: 'Inter',
      fontSize: size,
      letterSpacing: letterSpacing,
      fontStyle: fontStyle,
      fontWeight: fontWeight,
      color: color,
    );
  }

  static TextStyle body(
      {double size = 14, Color color = BRColors.primaryText, TextDecoration? decoration, double? letterSpacing}) {
    return TextStyle(
      fontFamily: 'Inter',
      fontSize: size,
      height: 1.5,
      fontWeight: FontWeight.w400,
      decoration: decoration,
      color: color,
      letterSpacing: letterSpacing,
    );
  }

  static TextStyle bodyMedium(
      {double size = 14, Color color = BRColors.primaryText, TextDecoration? decoration, double? letterSpacing}) {
    return TextStyle(
      fontFamily: 'Inter',
      fontSize: size,
      height: 1.5,
      fontWeight: FontWeight.w600,
      decoration: decoration,
      color: color,
      letterSpacing: letterSpacing,
    );
  }
}
