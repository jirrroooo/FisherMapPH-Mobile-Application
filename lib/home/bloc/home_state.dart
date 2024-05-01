part of 'home_bloc.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class InfoSuccess extends HomeState {
  final InfoModel infoModel;

  InfoSuccess({required this.infoModel});
}

final class InfoFailure extends HomeState {
  final String error;

  InfoFailure(this.error);
}

final class InfoLoading extends HomeState {}
