import 'dart:convert';

import 'package:fishermap_ph_mobileapp/data/credentials.dart';
import 'package:fishermap_ph_mobileapp/data/secure_storage.dart';
import 'package:fishermap_ph_mobileapp/home/model/info_model.dart';
import 'package:http/http.dart' as http;

class HomeRepository {
  Credentials credentials = Credentials();
  SecureStorage secureStorage = SecureStorage();

  Future<InfoModel> getUserInformation() async {
    String token = await secureStorage.getSecureData("token");
    String id = await secureStorage.getSecureData("user_id");

    var response = await http
        .get(Uri.http(credentials.API, credentials.USER + "/" + id), headers: {
      'Authorization': 'Bearer $token',
    });

    var data = jsonDecode(response.body);

    InfoModel infoModel = InfoModel(
        first_name: data["first_name"],
        last_name: data["last_name"],
        createdAt: DateTime.parse(data["createdAt"]),
        isAuthenticated: data["isAuthenticated"]);

    return infoModel;
  }
}
