import 'dart:convert';

import 'package:fishermap_ph_mobileapp/data/credentials.dart';
import 'package:fishermap_ph_mobileapp/data/secure_storage.dart';
import 'package:fishermap_ph_mobileapp/features/alert_page/model/alert_model.dart';
import 'package:fishermap_ph_mobileapp/features/distress_call_page/model/position_model.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

class SeaMapRepository {
  Credentials credentials = Credentials();
  SecureStorage secureStorage = SecureStorage();

  Future<PositionModel> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.

    var currentLocation = await Geolocator.getCurrentPosition();

    PositionModel positionModel = PositionModel(
        user_id: "",
        longitude: currentLocation.longitude,
        latitude: currentLocation.latitude,
        timestamp: DateTime.now(),
        accuracy: currentLocation.accuracy,
        altitude: currentLocation.altitude,
        heading: currentLocation.heading,
        speed: currentLocation.speed,
        speed_accuracy: currentLocation.speedAccuracy);

    return positionModel;
  }

  Future<List<AlertModel>> getNearbyAlerts() async {
    String token = await secureStorage.getSecureData("token");
    String id = await secureStorage.getSecureData("user_id");

    var currentPosition = await determinePosition();

    Map<String, dynamic> query = {
      'latitude': currentPosition.latitude.toString(),
      'longitude': currentPosition.longitude.toString(),
      'radius': "100"
    };

    print(query);

    var response = await http
        .get(Uri.http(credentials.API, credentials.ALERT_MAP, query), headers: {
      'Authorization': 'Bearer $token',
    });

    print(response.request.toString());

    var data = jsonDecode(response.body);

    print(data.toString());

    List<AlertModel> alert_logs = [];

    for (var d in data) {
      alert_logs.add(AlertModel(
          description: d["description"],
          level: d["level"],
          effective: DateTime.parse(d["effective"]),
          expires: DateTime.parse(d["expires"]),
          instruction: d["instruction"],
          title: d["title"],
          radius: d["radius"],
          location: d["location"]));
    }

    return alert_logs;
  }
}
