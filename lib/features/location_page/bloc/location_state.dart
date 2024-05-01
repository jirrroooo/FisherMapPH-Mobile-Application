part of 'location_bloc.dart';

@immutable
sealed class LocationState {}

final class LocationInitial extends LocationState {}

final class LocationFetchedSuccess extends LocationState {
  final List<LocationModel> location_logs;

  LocationFetchedSuccess({required this.location_logs});
}

final class LocationFetchedFailure extends LocationState {
  final String error;

  LocationFetchedFailure(this.error);
}

final class LocationFetchedLoading extends LocationState {}
