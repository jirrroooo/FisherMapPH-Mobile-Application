part of 'profile_bloc.dart';

@immutable
sealed class ProfileEvent {}

final class ProfileFetched extends ProfileEvent {}

final class ProfileUpdateRequested extends ProfileEvent {
  final String first_name;
  final String last_name;
  final String sex;
  final String email_address;
  final String contact_number;
  final String address;
  final String region;
  final DateTime birthday;
  final bool isAuthenticated;
  final String civil_status;
  final String fishing_vessel_type;
  final DateTime createdAt;

  ProfileUpdateRequested(
      {required this.first_name,
      required this.last_name,
      required this.sex,
      required this.email_address,
      required this.isAuthenticated,
      required this.createdAt,
      required this.contact_number,
      required this.address,
      required this.region,
      required this.birthday,
      required this.civil_status,
      required this.fishing_vessel_type});
}
