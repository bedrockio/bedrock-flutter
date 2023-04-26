import 'package:bedrock_flutter/src/utils/constants/padding.dart';
import 'package:bedrock_flutter/src/utils/geolocator.dart';
import 'package:bedrock_flutter/src/utils/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

Position? position;

class ChangeLocationScreen extends StatelessWidget {
  static const route = '/change_location_screen';

  final latitudeController = TextEditingController();
  final longitudeController = TextEditingController();

  ChangeLocationScreen({super.key}) {
    getUserLocation().then((value) {
      if (value != null) {
        latitudeController.text = value.latitude.toString();
        longitudeController.text = value.longitude.toString();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Change location'),
        backgroundColor: Colors.red,
        actions: [
          TextButton(
            onPressed: () async {
              if (isNumeric(latitudeController.text) && isNumeric(longitudeController.text)) {
                Position position = Position(
                    latitude: double.parse(latitudeController.text),
                    longitude: double.parse(longitudeController.text),
                    accuracy: 0.0,
                    altitude: 0.0,
                    speed: 0.0,
                    heading: 0.0,
                    speedAccuracy: 0.0,
                    timestamp: null);

                await BedrockSharedPreferences().setPosition(position).then((value) => {
                      ScaffoldMessenger.of(context)
                          .showSnackBar(const SnackBar(content: Text('Location data changed.')))
                    });
              } else {
                ScaffoldMessenger.of(context)
                    .showSnackBar(const SnackBar(content: Text('Invalid latitude or longitude.')));
              }
            },
            child: const Text('Save', style: TextStyle(color: Colors.white)),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(BRPadding.small),
        child: Column(children: [
          TextFormField(
            controller: latitudeController,
            cursorColor: Colors.black,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              label: Text('Latitude'),
              contentPadding: EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
            ),
          ),
          TextFormField(
            controller: longitudeController,
            cursorColor: Colors.black,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              label: Text('Longitude'),
              contentPadding: EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
            ),
          ),
        ]),
      ),
    );
  }

  bool isNumeric(String? s) {
    if (s == null) {
      return false;
    }
    return double.tryParse(s) != null;
  }
}
