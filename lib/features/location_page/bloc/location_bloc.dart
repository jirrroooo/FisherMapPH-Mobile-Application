import 'package:bloc/bloc.dart';
import 'package:fishermap_ph_mobileapp/features/location_page/model/location_model.dart';
import 'package:fishermap_ph_mobileapp/features/location_page/repository/location_repository.dart';
import 'package:meta/meta.dart';

part 'location_event.dart';
part 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  final LocationRepository locationRepository;

  LocationBloc(this.locationRepository) : super(LocationInitial()) {
    on<LocationFetched>(_getLocationLogs);
  }

  void _getLocationLogs(
      LocationFetched event, Emitter<LocationState> emit) async {
    emit(LocationFetchedLoading());

    try {
      final location_logs = await locationRepository.getLocationLogs();
      emit(LocationFetchedSuccess(location_logs: location_logs));
    } catch (e) {
      emit(LocationFetchedFailure(e.toString()));
    }
  }
}
