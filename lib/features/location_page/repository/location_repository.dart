import 'dart:convert';

import 'package:fishermap_ph_mobileapp/data/credentials.dart';
import 'package:fishermap_ph_mobileapp/data/secure_storage.dart';
import 'package:fishermap_ph_mobileapp/features/location_page/model/location_model.dart';
import 'package:http/http.dart' as http;

class LocationRepository {
  Credentials credentials = Credentials();
  SecureStorage secureStorage = SecureStorage();

  Future<List<LocationModel>> getLocationLogs() async {
    String token = await secureStorage.getSecureData("token");
    String id = await secureStorage.getSecureData("user_id");

    var response = await http.get(
        Uri.http(credentials.API, credentials.LOCATION_LOG + id),
        headers: {
          'Authorization': 'Bearer $token',
        });

    var data = jsonDecode(response.body);

    List<LocationModel> location_logs = [];

    for (var d in data) {
      location_logs.add(LocationModel(
          longitude: double.parse(d["longitude"].toString()),
          latitude: double.parse(d["latitude"].toString()),
          timestamp: DateTime.parse(d["timestamp"]),
          accuracy: double.parse(d["accuracy"].toString()),
          altitude: double.parse(d["altitude"].toString()),
          heading: double.parse(d["heading"].toString()),
          speed: double.parse(d["speed"].toString()),
          speedAccuracy: double.parse(d["speed_accuracy"].toString())));
    }

    return location_logs;
  }
}
