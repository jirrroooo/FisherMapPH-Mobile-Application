import 'package:bloc/bloc.dart';
import 'package:fishermap_ph_mobileapp/features/sea_map/repository/sea_map_repository.dart';
import 'package:geolocator/geolocator.dart';
import 'package:meta/meta.dart';

part 'sea_map_event.dart';
part 'sea_map_state.dart';

class SeaMapBloc extends Bloc<SeaMapEvent, SeaMapState> {
  final SeaMapRepository seaMapRepository;

  SeaMapBloc(this.seaMapRepository) : super(SeaMapInitial()) {
    on<LocationFetchedRequested>(_getCurrentLocation);
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
}
