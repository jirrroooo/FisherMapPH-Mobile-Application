part of 'sea_map_bloc.dart';

@immutable
sealed class SeaMapState {}

final class SeaMapInitial extends SeaMapState {}

final class SeaMapLocationFetchedLoading extends SeaMapState {}

final class SeaMapLocationFetchedSuccess extends SeaMapState {
  final Position currentLocation;

  SeaMapLocationFetchedSuccess({required this.currentLocation});
}

final class SeaMapLocationFetchedFailed extends SeaMapState {
  final String error;

  SeaMapLocationFetchedFailed(this.error);
}
