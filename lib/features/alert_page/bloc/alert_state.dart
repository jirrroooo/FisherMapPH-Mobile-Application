part of 'alert_bloc.dart';

@immutable
sealed class AlertState {}

final class AlertInitial extends AlertState {}

final class AlertFetchedSuccess extends AlertState {
  final List<AlertModel> alert_logs;

  AlertFetchedSuccess({required this.alert_logs});
}

final class AlertFetchedFailure extends AlertState {
  final String error;

  AlertFetchedFailure(this.error);
}

final class AlertFetchedLoading extends AlertState {}
