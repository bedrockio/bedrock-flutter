import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class IBedrockSharedPreferences {
  Future<void> setPosition(Position position);
  Future<Position?> getPosition();

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

class BedrockSharedPreferences extends IBedrockSharedPreferences {
  @override
  Future<void> setPosition(Position position) async {
    final prefs = await SharedPreferences.getInstance();
    final positionMap = <String, dynamic>{};
    positionMap['latitude'] = position.latitude;
    positionMap['longitude'] = position.longitude;
    await prefs.setString('position', json.encode(positionMap));
  }

  @override
  Future<Position?> getPosition() async {
    final prefs = await SharedPreferences.getInstance();

    if (prefs.getString('position') != null) {
      final latitude = json.decode(prefs.getString('position')!)['latitude'];
      final longitude = json.decode(prefs.getString('position')!)['longitude'];

      Position position = Position(
          latitude: latitude,
          longitude: longitude,
          accuracy: 0.0,
          altitude: 0.0,
          speed: 0.0,
          heading: 0.0,
          speedAccuracy: 0.0,
          timestamp: null);

      return position;
    }
    return null;
  }

  @override
  Future<void> deleteData() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }
}
