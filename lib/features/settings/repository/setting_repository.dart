import 'dart:convert';
import 'package:fishermap_ph_mobileapp/data/credentials.dart';
import 'package:fishermap_ph_mobileapp/data/secure_storage.dart';
import 'package:fishermap_ph_mobileapp/features/settings/models/contactModel.dart';
import 'package:fishermap_ph_mobileapp/features/settings/models/passwordModel.dart';
import 'package:http/http.dart' as http;

class SettingRepository {
  Credentials credentials = Credentials();
  SecureStorage secureStorage = SecureStorage();

  Future updatePassword({required PasswordModel passwordModel}) async {
    String token = await secureStorage.getSecureData("token");
    String id = await secureStorage.getSecureData("user_id");

    var response = await http.patch(
        Uri.http(credentials.API, credentials.USER + '/' + id),
        headers: {
          'Authorization': 'Bearer $token',
        },
        body: {
          "password": passwordModel.newPassword
        });

    var data = jsonDecode(response.body);

    return data;
  }

  Future<List<ContactModel>> getContacts() async {
    String token = await secureStorage.getSecureData("token");
    String id = await secureStorage.getSecureData("user_id");

    var response = await http.get(
        Uri.http(credentials.API, credentials.CONTACT_FETCHED + id),
        headers: {
          'Authorization': 'Bearer $token',
        });

    var data = jsonDecode(response.body);

    List<ContactModel> contact_list = [];

    for (Map d in data) {
      contact_list.add(ContactModel(
          name: d["full_name"],
          email_address: d["email_address"],
          contact_number: d["contact_number"],
          address: d["address"]));
    }

    return contact_list;
  }

  Future updateContact(ContactModel contactModel) async {
    String token = await secureStorage.getSecureData("token");
    String id = await secureStorage.getSecureData("user_id");

    var response = await http
        .post(Uri.http(credentials.API, credentials.CONTACT_CREATE), headers: {
      'Authorization': 'Bearer $token',
    }, body: {
      "user_id": id,
      "full_name": contactModel.name,
      "contact_number": contactModel.contact_number,
      "email_address": contactModel.email_address,
      "address": contactModel.address
    });

    var res = jsonDecode(response.body);

    return res;
  }

  Future deleteContact(int contact_index) async {
    String token = await secureStorage.getSecureData("token");
    String id = await secureStorage.getSecureData("user_id");

    var user = await http.get(
      Uri.http(credentials.API, credentials.USER + '/' + id),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    var person = jsonDecode(user.body);

    var response = await http.delete(
        Uri.http(credentials.API, credentials.CONTACT_FETCHED),
        headers: {
          'Authorization': 'Bearer $token',
        },
        body: {
          "user_id": id,
          "contact_id": person["person_to_notify"][contact_index]
        });

    var res = jsonDecode(response.body);

    return res;
  }
}
