import 'dart:convert';

class PasswordModel {
  final String oldPassword;
  final String newPassword;
  final String confirmNewPassword;
  PasswordModel({
    required this.oldPassword,
    required this.newPassword,
    required this.confirmNewPassword,
  });

  PasswordModel copyWith({
    String? oldPassword,
    String? newPassword,
    String? confirmNewPassword,
  }) {
    return PasswordModel(
      oldPassword: oldPassword ?? this.oldPassword,
      newPassword: newPassword ?? this.newPassword,
      confirmNewPassword: confirmNewPassword ?? this.confirmNewPassword,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'oldPassword': oldPassword,
      'newPassword': newPassword,
      'confirmNewPassword': confirmNewPassword,
    };
  }

  factory PasswordModel.fromMap(Map<String, dynamic> map) {
    return PasswordModel(
      oldPassword: map['oldPassword'] as String,
      newPassword: map['newPassword'] as String,
      confirmNewPassword: map['confirmNewPassword'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory PasswordModel.fromJson(String source) =>
      PasswordModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'PasswordModel(oldPassword: $oldPassword, newPassword: $newPassword, confirmNewPassword: $confirmNewPassword)';

  @override
  bool operator ==(covariant PasswordModel other) {
    if (identical(this, other)) return true;

    return other.oldPassword == oldPassword &&
        other.newPassword == newPassword &&
        other.confirmNewPassword == confirmNewPassword;
  }

  @override
  int get hashCode =>
      oldPassword.hashCode ^ newPassword.hashCode ^ confirmNewPassword.hashCode;
}
