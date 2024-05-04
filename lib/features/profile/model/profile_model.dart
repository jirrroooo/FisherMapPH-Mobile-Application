import 'dart:convert';

class ProfileModel {
  final String first_name;
  final String last_name;
  final String sex;
  final String email_address;
  final String contact_number;
  final String address;
  final DateTime birthday;
  final String civil_status;
  final bool isAuthenticated;
  final String fishing_vessel_type;
  final DateTime createdAt;
  ProfileModel({
    required this.first_name,
    required this.last_name,
    required this.sex,
    required this.email_address,
    required this.contact_number,
    required this.address,
    required this.birthday,
    required this.civil_status,
    required this.isAuthenticated,
    required this.fishing_vessel_type,
    required this.createdAt,
  });

  ProfileModel copyWith({
    String? first_name,
    String? last_name,
    String? sex,
    String? email_address,
    String? contact_number,
    String? address,
    DateTime? birthday,
    String? civil_status,
    bool? isAuthenticated,
    String? fishing_vessel_type,
    DateTime? createdAt,
  }) {
    return ProfileModel(
      first_name: first_name ?? this.first_name,
      last_name: last_name ?? this.last_name,
      sex: sex ?? this.sex,
      email_address: email_address ?? this.email_address,
      contact_number: contact_number ?? this.contact_number,
      address: address ?? this.address,
      birthday: birthday ?? this.birthday,
      civil_status: civil_status ?? this.civil_status,
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      fishing_vessel_type: fishing_vessel_type ?? this.fishing_vessel_type,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'first_name': first_name,
      'last_name': last_name,
      'sex': sex,
      'email_address': email_address,
      'contact_number': contact_number,
      'address': address,
      'birthday': birthday.millisecondsSinceEpoch,
      'civil_status': civil_status,
      'isAuthenticated': isAuthenticated,
      'fishing_vessel_type': fishing_vessel_type,
      'createdAt': createdAt.millisecondsSinceEpoch,
    };
  }

  factory ProfileModel.fromMap(Map<String, dynamic> map) {
    return ProfileModel(
      first_name: map['first_name'] as String,
      last_name: map['last_name'] as String,
      sex: map['sex'] as String,
      email_address: map['email_address'] as String,
      contact_number: map['contact_number'] as String,
      address: map['address'] as String,
      birthday: DateTime.fromMillisecondsSinceEpoch(map['birthday'] as int),
      civil_status: map['civil_status'] as String,
      isAuthenticated: map['isAuthenticated'] as bool,
      fishing_vessel_type: map['fishing_vessel_type'] as String,
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory ProfileModel.fromJson(String source) =>
      ProfileModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ProfileModel(first_name: $first_name, last_name: $last_name, sex: $sex, email_address: $email_address, contact_number: $contact_number, address: $address, birthday: $birthday, civil_status: $civil_status, isAuthenticated: $isAuthenticated, fishing_vessel_type: $fishing_vessel_type, createdAt: $createdAt)';
  }

  @override
  bool operator ==(covariant ProfileModel other) {
    if (identical(this, other)) return true;

    return other.first_name == first_name &&
        other.last_name == last_name &&
        other.sex == sex &&
        other.email_address == email_address &&
        other.contact_number == contact_number &&
        other.address == address &&
        other.birthday == birthday &&
        other.civil_status == civil_status &&
        other.isAuthenticated == isAuthenticated &&
        other.fishing_vessel_type == fishing_vessel_type &&
        other.createdAt == createdAt;
  }

  @override
  int get hashCode {
    return first_name.hashCode ^
        last_name.hashCode ^
        sex.hashCode ^
        email_address.hashCode ^
        contact_number.hashCode ^
        address.hashCode ^
        birthday.hashCode ^
        civil_status.hashCode ^
        isAuthenticated.hashCode ^
        fishing_vessel_type.hashCode ^
        createdAt.hashCode;
  }
}
