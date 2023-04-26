import 'package:shared_preferences/shared_preferences.dart';

enum BedrockPreferenceKey { isHomeFirstVisit, isGuestUser, hasUsedApp }

class BedrockPreferences {
  static BedrockPreferences shared = BedrockPreferences();

  SharedPreferences? preferences;

  Future<void> load() async {
    preferences = await SharedPreferences.getInstance();
  }

  bool getBool(BedrockPreferenceKey key) {
    return preferences?.getBool(key.name) ?? false;
  }

  bool hasValue(BedrockPreferenceKey key) {
    return preferences?.get(key.name) != null;
  }

  setBool(BedrockPreferenceKey key, bool value) {
    preferences?.setBool(key.name, value);
  }
}
