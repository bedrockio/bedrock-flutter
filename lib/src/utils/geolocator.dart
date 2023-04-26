import 'package:bedrock_flutter/src/env/environment.dart';
import 'package:bedrock_flutter/src/utils/shared_preferences.dart';
import 'package:geolocator/geolocator.dart';

Future<Position?> getUserLocation() async {
  Position? position;

  try {
    if (env == Stage.uat) {
      position = await BedrockSharedPreferences().getPosition();

      position ??= await Geolocator.getCurrentPosition();
    } else {
      position = await Geolocator.getCurrentPosition();
    }
  } catch (_) {}

  return position;
}
