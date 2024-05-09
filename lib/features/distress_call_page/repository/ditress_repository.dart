import 'dart:convert';

import 'package:fishermap_ph_mobileapp/data/credentials.dart';
import 'package:fishermap_ph_mobileapp/data/secure_storage.dart';
import 'package:fishermap_ph_mobileapp/features/distress_call_page/model/distress_log_model.dart';
import 'package:fishermap_ph_mobileapp/features/sea_map/repository/sea_map_repository.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class DistressRepository {
  SeaMapRepository seaMapRepository = SeaMapRepository();
  Credentials credentials = Credentials();
  SecureStorage secureStorage = SecureStorage();

  Future<List<DistressLogModel>> getDistressLogs() async {
    String token = await secureStorage.getSecureData("token");
    String id = await secureStorage.getSecureData("user_id");

    var response = await http.get(
        Uri.http(credentials.API, credentials.DISTRESS_LOG + id),
        headers: {
          'Authorization': 'Bearer $token',
        });

    var data = jsonDecode(response.body);

    List<DistressLogModel> distress_logs = [];

    for (var d in data) {
      String? status = "";

      if (d["report"]["status"] == "no_response") {
        status = "No Response";
      } else {
        status = toBeginningOfSentenceCase(d["report"]["status"]);
      }

      distress_logs.add(DistressLogModel(
          type: d["report"]["type"],
          content: d["report"]["content"],
          status: status.toString(),
          createdAt: DateTime.parse(d["report"]["createdAt"]),
          latitude: double.parse(d["positionInfo"]["latitude"]),
          longitude: double.parse(d["positionInfo"]["longitude"])));
    }

    return distress_logs;
  }

  Future<bool> sendDistressCall(String type, String content) async {
    String token = await secureStorage.getSecureData("token");
    String id = await secureStorage.getSecureData("user_id");

    Position currentLocation = await seaMapRepository.determinePosition();

    try {
      var locationResponse = await http
          .post(Uri.http(credentials.API, credentials.LOCATION), headers: {
        'Authorization': 'Bearer $token',
      }, body: {
        "user_id": id,
        "longitude": currentLocation.longitude,
        "latitude": currentLocation.latitude,
        "timestamp": currentLocation.timestamp,
        "accuracy": currentLocation.accuracy,
        "altitude": currentLocation.altitude,
        "heading": currentLocation.heading,
        "speed": currentLocation.speed,
        "speed_accuracy": currentLocation.speedAccuracy
      });

      var locationData = jsonDecode(locationResponse.body);

      var reportResponse = await http.post(
          Uri.http(credentials.API, credentials.DISTRESS_LOG + id),
          headers: {
            'Authorization': 'Bearer $token',
          },
          body: {
            "user_id": id,
            "position_id": locationData["_id"],
            "type": type,
            "content": content,
            "status": "no_response"
          });

      var reportData = jsonDecode(reportResponse.body);

      if (reportData["_id"] == null) {
        return false;
      }

      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
