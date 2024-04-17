import 'dart:convert';

class LoginModel {
  final String email_address;
  final String password;
  LoginModel({
    required this.email_address,
    required this.password,
  });

  LoginModel copyWith({
    String? email_address,
    String? password,
  }) {
    return LoginModel(
      email_address: email_address ?? this.email_address,
      password: password ?? this.password,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email_address': email_address,
      'password': password,
    };
  }

  factory LoginModel.fromMap(Map<String, dynamic> map) {
    return LoginModel(
      email_address: map['email_address'] as String,
      password: map['password'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory LoginModel.fromJson(String source) =>
      LoginModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'LoginModel(email_address: $email_address, password: $password)';

  @override
  bool operator ==(covariant LoginModel other) {
    if (identical(this, other)) return true;

    return other.email_address == email_address && other.password == password;
  }

  @override
  int get hashCode => email_address.hashCode ^ password.hashCode;
}
