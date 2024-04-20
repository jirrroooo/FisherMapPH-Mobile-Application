part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

final class AppStarted extends AuthEvent {}

final class AuthLoginRequested extends AuthEvent {
  final String email_address;
  final String password;

  AuthLoginRequested({required this.email_address, required this.password});
}

final class AuthLogoutRequested extends AuthEvent {}

final class AuthRegisterRequested extends AuthEvent {
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

  AuthRegisterRequested(
      {required this.first_name,
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
      required this.fishing_vessel_type});
}
