part of 'setting_bloc.dart';

@immutable
sealed class SettingEvent {}

final class PasswordUpdateRequested extends SettingEvent {
  final String oldPassword;
  final String newPassword;
  final String confirmNewPassword;

  PasswordUpdateRequested(
      {required this.oldPassword,
      required this.newPassword,
      required this.confirmNewPassword});
}

final class ContactFetched extends SettingEvent {}

final class ContactCreateRequested extends SettingEvent {
  final String name;
  final String email_address;
  final String contact_number;
  final String address;

  ContactCreateRequested(
      {required this.name,
      required this.email_address,
      required this.contact_number,
      required this.address});
}

final class ContactDeleteRequested extends SettingEvent {
  final int index;

  ContactDeleteRequested({
    required this.index,
  });
}
