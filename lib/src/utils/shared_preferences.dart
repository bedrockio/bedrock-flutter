import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class IBRSharedPreferences {
  Future<void> setPosition(Position position);
  Position? getPosition();

  Future<void> deleteData();
}

manageSharedPreferences() async {
  final prefs = await SharedPreferences.getInstance();
  if (prefs.getBool('first_run') ?? true) {
    FlutterSecureStorage storage = const FlutterSecureStorage();

    await storage.deleteAll();

    prefs.setBool('first_run', false);
  }
}

class BRSharedPreferences extends IBRSharedPreferences {
  late SharedPreferences _prefs;

  static BRSharedPreferences? _instance;

  static BRSharedPreferences get shared {
    _instance ??= BRSharedPreferences._();
    return _instance!;
  }

  static void load() {
    BRSharedPreferences.shared;
  }

  BRSharedPreferences._() {
    SharedPreferences.getInstance().then((value) => _prefs = value);
  }

  @visibleForTesting
  static set shared(BRSharedPreferences instance) {
    _instance = instance;
  }

  @override
  Future<void> setPosition(Position position) async {
    final positionMap = <String, dynamic>{};
    positionMap['latitude'] = position.latitude;
    positionMap['longitude'] = position.longitude;
    await _prefs.setString('position', json.encode(positionMap));
  }

  @override
  Position? getPosition() {
    if (_prefs.getString('position') != null) {
      final latitude = json.decode(_prefs.getString('position')!)['latitude'];
      final longitude = json.decode(_prefs.getString('position')!)['longitude'];

      Position position = Position(
          latitude: latitude,
          longitude: longitude,
          accuracy: 0.0,
          altitude: 0.0,
          speed: 0.0,
          heading: 0.0,
          speedAccuracy: 0.0,
          altitudeAccuracy: 0.0,
          headingAccuracy: 0.0,
          timestamp: DateTime.now());

      return position;
    }
    return null;
  }

  @override
  Future<void> deleteData() async {
    _prefs.clear();
  }
}
