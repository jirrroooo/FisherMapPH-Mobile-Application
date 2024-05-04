part of 'distress_bloc.dart';

@immutable
sealed class DistressEvent {}

final class DistressFetched extends DistressEvent {}
