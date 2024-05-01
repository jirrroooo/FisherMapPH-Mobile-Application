part of 'alert_bloc.dart';

@immutable
sealed class AlertEvent {}

final class AlertFetched extends AlertEvent {}
