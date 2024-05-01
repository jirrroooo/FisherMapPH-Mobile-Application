import 'package:bloc/bloc.dart';
import 'package:fishermap_ph_mobileapp/home/model/info_model.dart';
import 'package:fishermap_ph_mobileapp/home/repository/home_repository.dart';
import 'package:meta/meta.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeRepository homeRepository;

  HomeBloc(this.homeRepository) : super(HomeInitial()) {
    on<InfoFetched>(_getUserInfo);
  }

  void _getUserInfo(InfoFetched event, Emitter<HomeState> emit) async {
    emit(InfoLoading());

    try {
      final info = await homeRepository.getUserInformation();

      emit(InfoSuccess(infoModel: info));
    } catch (e) {
      emit(InfoFailure(e.toString()));
    }
  }
}
