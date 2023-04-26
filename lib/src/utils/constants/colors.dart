import 'package:flutter/material.dart';

extension BRColors on Colors {
  /// #2a2a2a
  static const Color black = Color(0xff2a2a2a);

  /// #423629
  static const Color brown = Color(0xff423629);

  /// #f4f0ea
  static const Color lightBrown = Color(0xfff4f0ea);

  /// #ffffff
  static const Color white = Color(0xffffffff);
}

class BRColorScheme {
  final Color backgroundColor;
  final Color textColor;

  const BRColorScheme({required this.backgroundColor, required this.textColor});

  BRColorScheme reverse() {
    return BRColorScheme(backgroundColor: textColor, textColor: backgroundColor);
  }

  static const BRColorScheme white = BRColorScheme(
    backgroundColor: BRColors.white,
    textColor: BRColors.black,
  );

  static const BRColorScheme black = BRColorScheme(
    backgroundColor: BRColors.black,
    textColor: BRColors.white,
  );
}
