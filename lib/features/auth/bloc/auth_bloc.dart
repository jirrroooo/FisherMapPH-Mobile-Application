import 'package:bloc/bloc.dart';
import 'package:fishermap_ph_mobileapp/data/secure_storage.dart';
import 'package:fishermap_ph_mobileapp/features/auth/models/loginModel.dart';
import 'package:fishermap_ph_mobileapp/features/auth/models/registerModel.dart';
import 'package:fishermap_ph_mobileapp/features/auth/repository/auth_repository.dart';
import 'package:flutter/foundation.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthLoginRequested>(_onAuthLoginRequested);
    on<AuthRegisterRequested>(_onAuthRegisterRequested);
    // on<AuthLogoutRequested>(_onAuthLogoutRequested);
  }

  AuthRepository authRepository = AuthRepository();
  SecureStorage secureStorage = SecureStorage();

  void _onAuthLoginRequested(
    AuthLoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

    try {
      LoginModel loginCredentials = LoginModel(
          email_address: event.email_address, password: event.password);

      /* TODO: Email and Password Frontend Authentication */

      var data = await authRepository.login(login: loginCredentials);

      if (data["token"] != null) {
        emit(AuthLoginSuccess());

        secureStorage.writeSecureData("token", data["token"].toString());
      } else {
        return emit(AuthFailure(data["error"]));
      }
    } catch (e) {
      return emit(AuthFailure(e.toString()));
    }
  }

  void _onAuthRegisterRequested(
    AuthRegisterRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      RegisterModel registerCredentials = RegisterModel(
          first_name: event.first_name,
          last_name: event.last_name,
          email_address: event.email_address,
          password: event.password,
          contact_number: event.contact_number,
          address: event.address,
          birthday: event.birthday,
          civil_status: event.civil_status,
          user_type: event.user_type,
          fishing_vessel_type: event.fishing_vessel_type);

      /* TODO: Email and Password Frontend Authentication */

      var data = await authRepository.register(register: registerCredentials);

      if (data["status"] == "success") {
        emit(AuthRegisterSuccess());
      } else {
        print(data);
        return emit(AuthFailure(data["status"]));
      }
    } catch (e) {
      return emit(AuthFailure(e.toString()));
    }
  }
}
