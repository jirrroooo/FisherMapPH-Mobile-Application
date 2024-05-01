import 'dart:convert';

import 'package:fishermap_ph_mobileapp/data/credentials.dart';
import 'package:fishermap_ph_mobileapp/features/auth/models/loginModel.dart';
import 'package:fishermap_ph_mobileapp/features/auth/models/registerModel.dart';
import 'package:http/http.dart' as http;

class AuthRepository {
  Credentials credentials = Credentials();

  Future<dynamic> login({required LoginModel login}) async {
    var response = await http.post(Uri.http(credentials.API, credentials.LOGIN),
        body: {
          'email_address': login.email_address,
          'password': login.password
        });

    return jsonDecode(response.body);
  }

  Future<dynamic> register({required RegisterModel register}) async {
    var response =
        await http.post(Uri.http(credentials.API, credentials.REGISTER), body: {
      'first_name': register.first_name,
      'last_name': register.last_name,
      'sex': register.sex,
      'email_address': register.email_address,
      'password': register.password,
      'contact_number': register.contact_number,
      'address': register.address,
      'birthday': register.birthday.toString(),
      'civil_status': register.civil_status,
      'user_type': register.user_type,
      'fishing_vessel_type': register.fishing_vessel_type
    });

    return jsonDecode(response.body);
  }

  Future<dynamic> createLog(String id) async {
    var response =
        await http.post(Uri.http(credentials.API, credentials.LOG), body: {
      'user_id': id,
    });

    return jsonDecode(response.body);
  }

  Future<dynamic> getUserId(String token) async {
    var response = await http.get(
        Uri.http(credentials.API, credentials.USER_ID + "/" + token),
        headers: {
          'Authorization': 'Bearer $token',
        });

    return jsonDecode(response.body);
  }
}
