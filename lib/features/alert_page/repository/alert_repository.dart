import 'dart:convert';

import 'package:fishermap_ph_mobileapp/data/credentials.dart';
import 'package:fishermap_ph_mobileapp/data/secure_storage.dart';
import 'package:fishermap_ph_mobileapp/features/alert_page/model/alert_model.dart';
import 'package:http/http.dart' as http;

class AlertRepository {
  Credentials credentials = Credentials();
  SecureStorage secureStorage = SecureStorage();

  Future<List<AlertModel>> getAlertLogs() async {
    String token = await secureStorage.getSecureData("token");
    String id = await secureStorage.getSecureData("user_id");

    print("TOKEN ==> " + token);
    print("ID ==> " + id);

    var response = await http
        .get(Uri.http(credentials.API, credentials.ALERT_LOG + id), headers: {
      'Authorization': 'Bearer $token',
    });

    print("RES ===> " + response.body);

    var data = jsonDecode(response.body);

    print("DATA ====>  " + data.toString());

    List<AlertModel> alert_logs = [];

    for (var d in data) {
      print(d is Map);
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

    print("alert_logs ====> " + alert_logs.toString());

    return alert_logs;
  }
}