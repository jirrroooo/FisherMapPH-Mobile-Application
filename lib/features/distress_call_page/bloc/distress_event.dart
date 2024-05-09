part of 'distress_bloc.dart';

@immutable
sealed class DistressEvent {}

final class DistressFetched extends DistressEvent {}

final class SendDistressSignal extends DistressEvent {
  final String type;
  final String content;

  SendDistressSignal({required this.type, required this.content});
}
