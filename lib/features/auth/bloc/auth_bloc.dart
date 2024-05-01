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
    on<AppStarted>(_onAppStarted);
    // on<AuthLogoutRequested>(_onAuthLogoutRequested);
  }

  AuthRepository authRepository = AuthRepository();
  SecureStorage secureStorage = SecureStorage();

  void _onAuthLoginRequested(
    AuthLoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

    var emailMatch = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

    if (!emailMatch.hasMatch(event.email_address)) {
      emit(AuthFailure('Invalid Email Address!'));
      return;
    }

    if (event.password.length < 6) {
      emit(AuthFailure('Password length is less than 6'));
      return;
    }

    try {
      LoginModel loginCredentials = LoginModel(
          email_address: event.email_address, password: event.password);

      var id;
      var data = await authRepository.login(login: loginCredentials);

      if (data["token"] != null && data["userType"] == "user") {
        emit(AuthLoginSuccess());

        secureStorage.writeSecureData("token", data["token"].toString());
        id = await authRepository.getUserId(data["token"]);

        print("ID => " + id["id"]);

        secureStorage.writeSecureData("user_id", id["id"]);
      } else if (data["token"] != null && data["userType"] != "user") {
        return emit(
            AuthFailure("Admin, Please Log In to FisherMap PH Website"));
      } else {
        return emit(AuthFailure(data["message"][0]));
      }
    } catch (e) {
      var socketException = RegExp(r'.*SocketException.*');

      if (socketException.hasMatch(e.toString())) {
        emit(AuthSocketException(e.toString()));
        return;
      }

      emit(AuthFailure(e.toString()));

      return;
    }
  }

  void _onAuthRegisterRequested(
    AuthRegisterRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

    RegisterModel registerCredentials = RegisterModel(
        first_name: event.first_name,
        last_name: event.last_name,
        sex: event.sex,
        email_address: event.email_address,
        password: event.password,
        confirm_password: event.confirm_password,
        contact_number: event.contact_number,
        address: event.address,
        birthday: event.birthday,
        civil_status: event.civil_status,
        user_type: event.user_type,
        fishing_vessel_type: event.fishing_vessel_type);

    var emailMatch = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

    if (event.sex == "male" || event.sex == "female") {
    } else {
      emit(AuthFailure('Invalid Sex Selection'));
      return;
    }

    if (!emailMatch.hasMatch(event.email_address)) {
      emit(AuthFailure('Invalid Email Address!'));
      return;
    }

    if (event.contact_number.length != 11) {
      emit(AuthFailure('Invalid Contact Number!'));
      return;
    }

    if (event.civil_status == "married" ||
        event.civil_status == "legally separated" ||
        event.civil_status == "single" ||
        event.civil_status == "widowed") {
    } else {
      emit(AuthFailure('Invalid Civil Status Selection'));
      return;
    }

    if (event.fishing_vessel_type == "small" ||
        event.fishing_vessel_type == "medium" ||
        event.fishing_vessel_type == "large") {
    } else {
      emit(AuthFailure('Invalid Fishing Vessel Type Selection'));
      return;
    }

    if (event.password.length < 6) {
      emit(AuthFailure('Password length is less than 6'));
      return;
    }

    if (event.password != event.confirm_password) {
      emit(AuthFailure('Password do not match!'));
      return;
    }

    try {
      var data = await authRepository.register(register: registerCredentials);
      var logResponse;

      if (data["status"] == "success") {
        logResponse = await authRepository.createLog(data["id"]);

        if (logResponse["status"] == "success") {
          emit(AuthRegisterSuccess());
        }
      } else {
        emit(AuthFailure(data["status"]));
      }

      return;
    } catch (e) {
      var socketException = RegExp(r'.*SocketException.*');

      if (socketException.hasMatch(e.toString())) {
        emit(AuthSocketException(e.toString()));
        return;
      }

      emit(AuthFailure(e.toString()));

      return;
    }
  }

  void _onAppStarted(
    AppStarted event,
    Emitter<AuthState> emit,
  ) {
    emit(AuthInitial());
    return;
  }
}
