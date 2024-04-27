part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class AuthLoginSuccess extends AuthState {
  // final LoginSuccessModel loginSuccessModel;

  // AuthLoginSuccess({required this.loginSuccessModel});
}

final class AuthRegisterSuccess extends AuthState {
  // final RegisterSuccessModel registerSuccessModel;

  // AuthRegisterSuccess({required this.registerSuccessModel});
}

final class AuthFailure extends AuthState {
  final String error;

  AuthFailure(this.error);
}

final class AuthSocketException extends AuthState {
  final String error;

  AuthSocketException(this.error);
}

final class AuthLoading extends AuthState {}
