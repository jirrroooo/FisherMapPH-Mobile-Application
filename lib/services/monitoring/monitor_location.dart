import 'dart:convert';
import 'package:fishermap_ph_mobileapp/data/credentials.dart';
import 'package:fishermap_ph_mobileapp/data/secure_storage.dart';
import 'package:fishermap_ph_mobileapp/features/alert_page/model/alert_model.dart';
import 'package:fishermap_ph_mobileapp/features/distress_call_page/model/position_model.dart';
import 'package:fishermap_ph_mobileapp/features/sea_map/repository/sea_map_repository.dart';
import 'package:fishermap_ph_mobileapp/services/notification/local_notification.dart';
import 'package:http/http.dart' as http;

class MonitorLocation {
  SeaMapRepository seaMapRepository = SeaMapRepository();
  Credentials credentials = Credentials();
  SecureStorage secureStorage = SecureStorage();

  bool isNearDanger = false;

  void monitorLocation() {
    updateLocation();
    _checkAlertArea();
  }

  void updateLocation() async {
    String token = await secureStorage.getSecureData("token");
    String id = await secureStorage.getSecureData("user_id");

    PositionModel positionModel = await seaMapRepository.determinePosition();

    try {
      var locationResponse = await http.post(
          Uri.http(credentials.API, credentials.LOCATION),
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json'
          },
          body: jsonEncode({
            "user_id": id,
            "longitude": positionModel.longitude,
            "latitude": positionModel.latitude,
            "timestamp": positionModel.timestamp.toIso8601String(),
            "accuracy": positionModel.accuracy,
            "altitude": positionModel.altitude,
            "heading": positionModel.heading,
            "speed": positionModel.speed,
            "speed_accuracy": positionModel.speed_accuracy
          }));

      var locationData = jsonDecode(locationResponse.body);

      print('Location Update Successful!!!');
    } catch (e) {
      print('Location Update Failed');
    }
  }

  void _checkAlertArea() async {
    String token = await secureStorage.getSecureData("token");
    String id = await secureStorage.getSecureData("user_id");

    var currentPosition = await seaMapRepository.determinePosition();

    Map<String, dynamic> query = {
      'latitude': currentPosition.latitude.toString(),
      'longitude': currentPosition.longitude.toString(),
      'radius': "1"
    };

    var response = await http
        .get(Uri.http(credentials.API, credentials.ALERT_MAP, query), headers: {
      'Authorization': 'Bearer $token',
    });

    var data = jsonDecode(response.body);

    // print('Data ==> ' + data.toString());

    List<AlertModel> alert_logs = [];

    for (var d in data) {
      alert_logs.add(AlertModel(
          id: d["_id"],
          description: d["description"],
          level: d["level"],
          effective: DateTime.parse(d["effective"]),
          expires: DateTime.parse(d["expires"]),
          instruction: d["instruction"],
          title: d["title"],
          radius: d["radius"],
          location: d["location"]));
    }

    if (alert_logs.length == 0) {
      isNearDanger = false;
      return;
    }

    isNearDanger = true;

    for (AlertModel alert in alert_logs) {
      LocalNotification.showSimpleNotification(
          title: '${alert.title} within ${alert.radius} km radius',
          body: '${alert.description}. ${alert.instruction}',
          payload: '${alert.description}. ${alert.instruction}');

      var test = await http
          .post(Uri.http(credentials.API, credentials.ADD_ALERT_LOG), headers: {
        'Authorization': 'Bearer $token',
      }, body: {
        "user_id": id,
        "alert_id": alert.id
      });
    }
  }
}
