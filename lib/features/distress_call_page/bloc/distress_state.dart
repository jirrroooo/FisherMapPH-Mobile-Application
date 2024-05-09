part of 'distress_bloc.dart';

@immutable
sealed class DistressState {}

final class DistressInitial extends DistressState {}

final class DistressFetchedSuccess extends DistressState {
  final List<DistressLogModel> distress_logs;

  DistressFetchedSuccess({required this.distress_logs});
}

final class DistressFetchedFailure extends DistressState {
  final String error;

  DistressFetchedFailure(this.error);
}

final class DistressFetchedLoading extends DistressState {}

final class SendDistressSignalSuccess extends DistressState {}

final class SendDistressSignalLoading extends DistressState {}

final class SendDistressSignalFailure extends DistressState {
  final String error;

  SendDistressSignalFailure(this.error);
}
