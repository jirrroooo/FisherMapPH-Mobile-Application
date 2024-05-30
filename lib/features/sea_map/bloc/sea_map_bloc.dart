import 'package:bloc/bloc.dart';
import 'package:fishermap_ph_mobileapp/features/alert_page/model/alert_model.dart';
import 'package:fishermap_ph_mobileapp/features/distress_call_page/model/position_model.dart';
import 'package:fishermap_ph_mobileapp/features/sea_map/model/boundary_model.dart';
import 'package:fishermap_ph_mobileapp/features/sea_map/repository/sea_map_repository.dart';
import 'package:fishermap_ph_mobileapp/functions/map_function.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:meta/meta.dart';

part 'sea_map_event.dart';
part 'sea_map_state.dart';

class SeaMapBloc extends Bloc<SeaMapEvent, SeaMapState> {
  final SeaMapRepository seaMapRepository;

  SeaMapBloc(this.seaMapRepository) : super(SeaMapInitial()) {
    on<LocationFetchedRequested>(_getCurrentLocation);
    on<AlertMapFetchedRequested>(_getNearbyAlerts);
    on<BoundaryMapFetchedRequested>(_getBoundary);
  }

  void _getCurrentLocation(
      LocationFetchedRequested event, Emitter<SeaMapState> emit) async {
    emit(SeaMapLocationFetchedLoading());

    try {
      final currentLocation = await seaMapRepository.determinePosition();

      emit(SeaMapLocationFetchedSuccess(currentLocation: currentLocation));
    } catch (e) {
      emit(SeaMapLocationFetchedFailed(e.toString()));
    }
  }

  void _getNearbyAlerts(
      AlertMapFetchedRequested event, Emitter<SeaMapState> emit) async {
    MapFunction mapFunction = MapFunction();
    try {
      final currentLocation = await seaMapRepository.determinePosition();
      final alerts = await seaMapRepository.getNearbyAlerts();

      emit(AlertMapFetchedSuccess(
          currentLocation: currentLocation, alerts: alerts));
    } catch (e) {
      emit(AlertMapFetchedFailed(e.toString()));
    }
  }

  void _getBoundary(
      BoundaryMapFetchedRequested event, Emitter<SeaMapState> emit) async {
    try {
      BoundaryModel? boundaryModel = await seaMapRepository.getBoundary();
      final currentLocation = await seaMapRepository.determinePosition();

      emit(BoundaryMapFetchedSuccess(
          boundaryModel: boundaryModel, currentLocation: currentLocation));
    } catch (e) {
      emit(BoundaryMapFetchedFailed(e.toString()));
    }
  }
}
