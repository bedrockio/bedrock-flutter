import 'package:flutter/material.dart';

class SettingsController with ChangeNotifier {
  ThemeMode _themeMode;
  ThemeMode get themeMode => _themeMode;

  SettingsController({
    ThemeMode mode = ThemeMode.system,
  }) : _themeMode = mode;

  void updateThemeMode(ThemeMode? newThemeMode) {
    if (newThemeMode == null) return;
    if (newThemeMode == _themeMode) return;

    _themeMode = newThemeMode;
    notifyListeners();
  }
}
