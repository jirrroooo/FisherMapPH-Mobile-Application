import 'package:bloc/bloc.dart';
import 'package:fishermap_ph_mobileapp/features/distress_call_page/model/distress_log_model.dart';
import 'package:fishermap_ph_mobileapp/features/distress_call_page/repository/ditress_repository.dart';
import 'package:meta/meta.dart';

part 'distress_event.dart';
part 'distress_state.dart';

class DistressBloc extends Bloc<DistressEvent, DistressState> {
  final DistressRepository distressRepository;

  DistressBloc(this.distressRepository) : super(DistressInitial()) {
    on<DistressFetched>(_getDistressLogs);
  }

  void _getDistressLogs(DistressFetched event, Emitter emit) async {
    emit(DistressFetchedLoading());

    try {
      final distress_logs = await distressRepository.getDistressLogs();

      emit(DistressFetchedSuccess(distress_logs: distress_logs));
    } catch (e) {
      emit(DistressFetchedFailure(e.toString()));
    }
  }
}
