import '/src/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class BRTheme {
  static ThemeData theme() {
    return ThemeData(
      scaffoldBackgroundColor: BRColors.secondary,
      primarySwatch: BRColors.primary.toMaterialColor(),
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: BRColors.primary,
        strokeCap: StrokeCap.round,
      ),
      bottomAppBarTheme: const BottomAppBarThemeData(
        color: BRColors.primaryAccent,
        elevation: 1,
        shape: CircularNotchedRectangle(),
        padding: EdgeInsets.zero,
      ),
      tabBarTheme: TabBarThemeData(
          indicatorColor: Colors.transparent,
          dividerColor: Colors.transparent,
          splashFactory: NoSplash.splashFactory,
          overlayColor: WidgetStateProperty.all<Color>(Colors.transparent)),
      fontFamily: 'Inter',
      textTheme: const TextTheme(
          titleLarge: TextStyle(
            fontSize: 45,
            height: 1.3,
            fontWeight: FontWeight.w400,
          ),
          titleMedium: TextStyle(
            fontSize: 26,
            height: 1.3,
            fontWeight: FontWeight.w400,
          ),
          bodyMedium: TextStyle(
            fontSize: 14,
            height: 1.5,
            fontWeight: FontWeight.w400,
          ),
          bodySmall: TextStyle(
            fontSize: 12,
            height: 1.5,
            fontWeight: FontWeight.w400,
          ),
          bodyLarge: TextStyle(
            fontSize: 20,
            height: 1.5,
            fontWeight: FontWeight.w400,
          )).apply(bodyColor: BRColors.primaryText, displayColor: BRColors.primaryText),
      appBarTheme: const AppBarTheme(
          backgroundColor: BRColors.primary,
          foregroundColor: BRColors.secondary,
          titleTextStyle: TextStyle(
              fontFamily: 'Inter', fontSize: 20, height: 1.3, fontWeight: FontWeight.w500, color: BRColors.secondary)),
    );
  }
}
