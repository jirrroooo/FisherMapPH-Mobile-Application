part of 'profile_bloc.dart';

@immutable
sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}

final class ProfileFetchedSuccess extends ProfileState {
  final ProfileModel profileModel;

  ProfileFetchedSuccess({required this.profileModel});
}

final class ProfileFetchedFailure extends ProfileState {
  final String error;

  ProfileFetchedFailure(this.error);
}

final class ProfileFetchedLoading extends ProfileState {}

final class ProfileUpdateSuccess extends ProfileState {
  ProfileUpdateSuccess();
}

final class ProfileUpdateFailed extends ProfileState {
  final String error;

  ProfileUpdateFailed(this.error);
}

final class ProfileUpdateLoading extends ProfileState {}
