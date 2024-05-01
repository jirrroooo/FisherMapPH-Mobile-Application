import 'package:bloc/bloc.dart';
import 'package:fishermap_ph_mobileapp/features/alert_page/model/alert_model.dart';
import 'package:fishermap_ph_mobileapp/features/alert_page/repository/alert_repository.dart';
import 'package:meta/meta.dart';

part 'alert_event.dart';
part 'alert_state.dart';

class AlertBloc extends Bloc<AlertEvent, AlertState> {
  final AlertRepository alertRepository;

  AlertBloc(this.alertRepository) : super(AlertInitial()) {
    on<AlertFetched>(_getAlertLogs);
  }

  void _getAlertLogs(AlertFetched event, Emitter emit) async {
    emit(AlertFetchedLoading());

    try {
      final alert_logs = await alertRepository.getAlertLogs();

      emit(AlertFetchedSuccess(alert_logs: alert_logs));
    } catch (e) {
      emit(AlertFetchedFailure(e.toString()));
    }
  }
}
