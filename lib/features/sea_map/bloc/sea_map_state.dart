part of 'sea_map_bloc.dart';

@immutable
sealed class SeaMapState {}

final class SeaMapInitial extends SeaMapState {}

final class SeaMapLocationFetchedLoading extends SeaMapState {}

final class SeaMapLocationFetchedSuccess extends SeaMapState {
  final PositionModel currentLocation;

  SeaMapLocationFetchedSuccess({required this.currentLocation});
}

final class SeaMapLocationFetchedFailed extends SeaMapState {
  final String error;

  SeaMapLocationFetchedFailed(this.error);
}

final class AlertMapFetchedLoading extends SeaMapState {}

final class AlertMapFetchedSuccess extends SeaMapState {
  final PositionModel currentLocation;
  final List<AlertModel> alerts;

  AlertMapFetchedSuccess({required this.currentLocation, required this.alerts});
}

final class AlertMapFetchedFailed extends SeaMapState {
  final String error;

  AlertMapFetchedFailed(this.error);
}

final class BoundaryMapFetchedLoading extends SeaMapState {}

final class BoundaryMapFetchedSuccess extends SeaMapState {
  final BoundaryModel? boundaryModel;
  final PositionModel currentLocation;

  BoundaryMapFetchedSuccess(
      {required this.boundaryModel, required this.currentLocation});
}

final class BoundaryMapFetchedFailed extends SeaMapState {
  final String error;

  BoundaryMapFetchedFailed(this.error);
}
