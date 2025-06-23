import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salen_academy/src/data/repositories/local_data_repository.dart';
import 'package:salen_academy/src/data/repositories/profile_repository.dart';

import '../../data/models/error_model.dart';
import '../../data/models/user_profile_model.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileState.init());

  Future<void> getProfile() async {
    emit(state.copyWith(isLoading: true, isError: false));
    try {
      var profile = await LocalDataRepository.getProfile();
      emit(state.copyWith(isLoading: false, userProfile: profile));
    } catch (e) {
      emit(
        state.copyWith(
          isLoading: false,
          isError: true,
          error: ErrorModel(
            errorId: 0,
            isFriendly: false,
            message: e.toString(),
          ),
        ),
      );
    }
  }

  Future<void> setProfile({
    required String fullName,
    required String email,
    required String oldPaswd,
    required String newPaswd,
  }) async {
    emit(state.copyWith(isLoading: true, isError: false));
    try {
      var profile = await ProfileRepository.setProfile(
        fullName: fullName,
        email: email,
        oldPaswd: oldPaswd,
        newPaswd: newPaswd,
      );

      await LocalDataRepository.setProfile(profile);
      emit(state.copyWith(isLoading: false, userProfile: profile));
    } catch (e) {
      emit(
        state.copyWith(
          isLoading: false,
          isError: true,
          error: ErrorModel(
            errorId: 0,
            isFriendly: false,
            message: e.toString(),
          ),
        ),
      );
    }
  }
}
