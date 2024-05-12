part of 'sea_map_bloc.dart';

@immutable
sealed class SeaMapEvent {}

final class LocationFetchedRequested extends SeaMapEvent {}

final class AlertMapFetchedRequested extends SeaMapEvent {}
