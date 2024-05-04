import 'dart:convert';

import 'package:fishermap_ph_mobileapp/data/credentials.dart';
import 'package:fishermap_ph_mobileapp/data/secure_storage.dart';
import 'package:fishermap_ph_mobileapp/features/distress_call_page/model/distress_log_model.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class DistressRepository {
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
}
