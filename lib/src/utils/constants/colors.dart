import 'package:flutter/material.dart';

extension BRColors on Colors {
  /// #423629
  static const Color primary = Color(0xff423629);

  /// #2a2a2a
  static const Color primaryText = Color(0xff2a2a2a);

  /// #f4f0ea
  static const Color primaryAccent = Color(0xfff4f0ea);

  /// #ffffff
  static const Color secondary = Color(0xffffffff);
}

class BRColorScheme {
  final Color backgroundColor;
  final Color textColor;

  const BRColorScheme({required this.backgroundColor, required this.textColor});

  BRColorScheme reverse() {
    return BRColorScheme(backgroundColor: textColor, textColor: backgroundColor);
  }

  static const BRColorScheme secondary = BRColorScheme(
    backgroundColor: BRColors.secondary,
    textColor: BRColors.primaryText,
  );

  static const BRColorScheme primaryText = BRColorScheme(
    backgroundColor: BRColors.primaryText,
    textColor: BRColors.secondary,
  );
}

extension ColorExtension on Color {
  MaterialColor toMaterialColor() {
    return MaterialColor(
      // ignore: deprecated_member_use
      value,
      <int, Color>{
        50: this,
        100: this,
        200: this,
        300: this,
        400: this,
        500: this,
        600: this,
        700: this,
        800: this,
        900: this,
      },
    );
  }
}
