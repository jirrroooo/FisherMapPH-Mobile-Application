part of 'setting_bloc.dart';

@immutable
sealed class SettingState {}

final class SettingInitial extends SettingState {}

final class PasswordUpdateSuccess extends SettingState {}

final class PasswordUpdateLoading extends SettingState {}

final class PasswordUpdateFailure extends SettingState {
  final String error;

  PasswordUpdateFailure(this.error);
}

final class ContactFetchedLoading extends SettingState {}

final class ContactFetchedSuccess extends SettingState {
  final List<ContactModel> list_contact;

  ContactFetchedSuccess({required this.list_contact});
}

final class ContactFetchedFailure extends SettingState {
  final String error;

  ContactFetchedFailure(this.error);
}

final class ContactCreateSuccess extends SettingState {}

final class ContactCreateLoading extends SettingState {}

final class ContactCreateFailure extends SettingState {
  final String error;

  ContactCreateFailure(this.error);
}

final class ContactDeleteLoading extends SettingState {}

final class ContactDeleteSuccess extends SettingState {}

final class ContactDeleteFailure extends SettingState {
  final String error;

  ContactDeleteFailure(this.error);
}
