import 'dart:convert';

import 'package:fishermap_ph_mobileapp/data/credentials.dart';
import 'package:fishermap_ph_mobileapp/data/secure_storage.dart';
import 'package:fishermap_ph_mobileapp/features/profile/model/profile_model.dart';

import 'package:http/http.dart' as http;

class ProfileRepository {
  Credentials credentials = Credentials();
  SecureStorage secureStorage = SecureStorage();

  Future<ProfileModel> getUser() async {
    String token = await secureStorage.getSecureData("token");
    String id = await secureStorage.getSecureData("user_id");

    var response = await http
        .get(Uri.http(credentials.API, credentials.USER + '/' + id), headers: {
      'Authorization': 'Bearer $token',
    });

    var data = jsonDecode(response.body);

    ProfileModel profileModel = ProfileModel(
        first_name: data["first_name"],
        last_name: data["last_name"],
        sex: data["sex"],
        email_address: data["email_address"],
        contact_number: data["contact_number"],
        address: data["address"],
        birthday: DateTime.parse(data["birthday"]),
        civil_status: data["civil_status"],
        isAuthenticated: data["isAuthenticated"],
        fishing_vessel_type: data["fishing_vessel_type"],
        createdAt: DateTime.parse(data["createdAt"]));

    return profileModel;
  }

  Future updateUser(ProfileModel data) async {
    String token = await secureStorage.getSecureData("token");
    String id = await secureStorage.getSecureData("user_id");

    var response = await http.patch(
        Uri.http(credentials.API, credentials.USER + '/' + id),
        headers: {
          'Authorization': 'Bearer $token',
        },
        body: {
          "sex": data.sex,
          "email_address": data.email_address,
          "contact_number": data.contact_number,
          "address": data.address,
          "birthday": data.birthday.toIso8601String(),
          "civil_status": data.civil_status,
          "fishing_vessel_type": data.fishing_vessel_type,
        });

    var res = jsonDecode(response.body);

    return res;
  }
}
