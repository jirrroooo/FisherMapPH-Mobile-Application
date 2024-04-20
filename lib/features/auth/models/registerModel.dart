// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class RegisterModel {
  final String first_name;
  final String last_name;
  final String sex;
  final String email_address;
  final String password;
  final String confirm_password;
  final String contact_number;
  final String address;
  final DateTime birthday;
  final String civil_status;
  final String user_type;
  final String fishing_vessel_type;
  RegisterModel({
    required this.first_name,
    required this.last_name,
    required this.sex,
    required this.email_address,
    required this.password,
    required this.confirm_password,
    required this.contact_number,
    required this.address,
    required this.birthday,
    required this.civil_status,
    required this.user_type,
    required this.fishing_vessel_type,
  });

  RegisterModel copyWith({
    String? first_name,
    String? last_name,
    String? sex,
    String? email_address,
    String? password,
    String? confirm_password,
    String? contact_number,
    String? address,
    DateTime? birthday,
    String? civil_status,
    String? user_type,
    String? fishing_vessel_type,
  }) {
    return RegisterModel(
      first_name: first_name ?? this.first_name,
      last_name: last_name ?? this.last_name,
      sex: sex ?? this.sex,
      email_address: email_address ?? this.email_address,
      password: password ?? this.password,
      confirm_password: confirm_password ?? this.confirm_password,
      contact_number: contact_number ?? this.contact_number,
      address: address ?? this.address,
      birthday: birthday ?? this.birthday,
      civil_status: civil_status ?? this.civil_status,
      user_type: user_type ?? this.user_type,
      fishing_vessel_type: fishing_vessel_type ?? this.fishing_vessel_type,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'first_name': first_name,
      'last_name': last_name,
      'sex': sex,
      'email_address': email_address,
      'password': password,
      'confirm_password': confirm_password,
      'contact_number': contact_number,
      'address': address,
      'birthday': birthday.millisecondsSinceEpoch,
      'civil_status': civil_status,
      'user_type': user_type,
      'fishing_vessel_type': fishing_vessel_type,
    };
  }

  factory RegisterModel.fromMap(Map<String, dynamic> map) {
    return RegisterModel(
      first_name: map['first_name'] as String,
      last_name: map['last_name'] as String,
      sex: map['sex'] as String,
      email_address: map['email_address'] as String,
      password: map['password'] as String,
      confirm_password: map['confirm_password'] as String,
      contact_number: map['contact_number'] as String,
      address: map['address'] as String,
      birthday: DateTime.fromMillisecondsSinceEpoch(map['birthday'] as int),
      civil_status: map['civil_status'] as String,
      user_type: map['user_type'] as String,
      fishing_vessel_type: map['fishing_vessel_type'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory RegisterModel.fromJson(String source) =>
      RegisterModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'RegisterModel(first_name: $first_name, last_name: $last_name, sex: $sex, email_address: $email_address, password: $password, confirm_password: $confirm_password, contact_number: $contact_number, address: $address, birthday: $birthday, civil_status: $civil_status, user_type: $user_type, fishing_vessel_type: $fishing_vessel_type)';
  }

  @override
  bool operator ==(covariant RegisterModel other) {
    if (identical(this, other)) return true;

    return other.first_name == first_name &&
        other.last_name == last_name &&
        other.sex == sex &&
        other.email_address == email_address &&
        other.password == password &&
        other.confirm_password == confirm_password &&
        other.contact_number == contact_number &&
        other.address == address &&
        other.birthday == birthday &&
        other.civil_status == civil_status &&
        other.user_type == user_type &&
        other.fishing_vessel_type == fishing_vessel_type;
  }

  @override
  int get hashCode {
    return first_name.hashCode ^
        last_name.hashCode ^
        sex.hashCode ^
        email_address.hashCode ^
        password.hashCode ^
        confirm_password.hashCode ^
        contact_number.hashCode ^
        address.hashCode ^
        birthday.hashCode ^
        civil_status.hashCode ^
        user_type.hashCode ^
        fishing_vessel_type.hashCode;
  }
}
