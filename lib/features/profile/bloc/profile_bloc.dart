import 'package:bloc/bloc.dart';
import 'package:fishermap_ph_mobileapp/features/profile/model/profile_model.dart';
import 'package:fishermap_ph_mobileapp/features/profile/repository/profile_repository.dart';
import 'package:meta/meta.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileRepository profileRepository;

  ProfileBloc(this.profileRepository) : super(ProfileInitial()) {
    on<ProfileFetched>(_getUserProfile);
    on<ProfileUpdateRequested>(_updateProfile);
  }

  void _getUserProfile(ProfileFetched event, Emitter<ProfileState> emit) async {
    emit(ProfileFetchedLoading());

    try {
      final profileModel = await profileRepository.getUser();
      emit(ProfileFetchedSuccess(profileModel: profileModel));
    } catch (e) {
      emit(ProfileFetchedFailure(e.toString()));
    }
  }

  void _updateProfile(
      ProfileUpdateRequested event, Emitter<ProfileState> emit) async {
    emit(ProfileUpdateLoading());

    ProfileModel profileModel = ProfileModel(
        first_name: event.first_name,
        last_name: event.last_name,
        sex: event.sex,
        email_address: event.email_address,
        contact_number: event.contact_number,
        address: event.address,
        birthday: event.birthday,
        civil_status: event.civil_status,
        isAuthenticated: event.isAuthenticated,
        fishing_vessel_type: event.fishing_vessel_type,
        createdAt: event.createdAt);

    try {
      final res = await profileRepository.updateUser(profileModel);

      emit(ProfileUpdateSuccess());
    } catch (e) {
      emit(ProfileFetchedFailure(e.toString()));
    }
  }
}
