import 'package:bloc/bloc.dart';
import 'package:fishermap_ph_mobileapp/features/settings/models/contactModel.dart';
import 'package:fishermap_ph_mobileapp/features/settings/models/passwordModel.dart';
import 'package:fishermap_ph_mobileapp/features/settings/repository/setting_repository.dart';
import 'package:meta/meta.dart';

part 'setting_event.dart';
part 'setting_state.dart';

class SettingBloc extends Bloc<SettingEvent, SettingState> {
  final SettingRepository settingRepository;

  SettingBloc(this.settingRepository) : super(SettingInitial()) {
    on<PasswordUpdateRequested>(_passwordUpdateRequested);
    on<ContactFetched>(_contactFetched);
    on<ContactCreateRequested>(_contactCreateRequested);
    on<ContactDeleteRequested>(_contactDeleteRequested);
  }

  void _passwordUpdateRequested(
      PasswordUpdateRequested event, Emitter<SettingState> emit) async {
    emit(PasswordUpdateLoading());
    PasswordModel passwordModel = PasswordModel(
        oldPassword: event.oldPassword,
        newPassword: event.newPassword,
        confirmNewPassword: event.confirmNewPassword);

    try {
      final res =
          await settingRepository.updatePassword(passwordModel: passwordModel);

      if (res._id) {
        emit(PasswordUpdateSuccess());
      } else {
        emit(PasswordUpdateFailure('Password Update Failed'));
      }
    } catch (e) {
      emit(PasswordUpdateFailure(e.toString()));
    }
  }

  void _contactFetched(ContactFetched event, Emitter<SettingState> emit) async {
    emit(ContactFetchedLoading());

    try {
      final res = await settingRepository.getContacts();

      emit(ContactFetchedSuccess(list_contact: res));
    } catch (e) {
      emit(ContactFetchedFailure(e.toString()));
    }
  }

  void _contactCreateRequested(
      ContactCreateRequested event, Emitter<SettingState> emit) async {
    emit(ContactCreateLoading());

    ContactModel contactModel = ContactModel(
        name: event.name,
        email_address: event.email_address,
        contact_number: event.contact_number,
        address: event.address);

    try {
      final res = await settingRepository.updateContact(contactModel);

      if (res["statusCode"] != null && res["statusCode"] == 404) {
        emit(ContactCreateFailure(res["message"]));
      }

      emit(ContactCreateSuccess());
    } catch (e) {
      emit(ContactCreateFailure(e.toString()));
    }
  }

  void _contactDeleteRequested(
      ContactDeleteRequested event, Emitter<SettingState> emit) async {
    emit(ContactDeleteLoading());

    int index = event.index;

    try {
      final res = await settingRepository.deleteContact(index);

      if (res["statusCode"] != null && res["statusCode"] == 404) {
        emit(ContactCreateFailure(res["message"]));
      }

      emit(ContactDeleteSuccess());
    } catch (e) {
      emit(ContactDeleteFailure(e.toString()));
    }
  }
}
