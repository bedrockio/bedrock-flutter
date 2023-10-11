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
