import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salen_academy/src/data/models/user_profile_model.dart';
import 'package:salen_academy/src/data/repositories/sign_up_repository.dart';

import '../../data/models/error_model.dart';
import '../../data/models/sign_up_model.dart';
import '../../data/repositories/local_data_repository.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit() : super(SignUpState.init());

  get value => null;

  Future<void> onSignUp({
    required String userName,
    required String email,
    required String password,
  }) async {
    emit(state.copyWith(isLoading: true));
    try {
      var data = await SignUpRepository.signUp(
        userName: userName,
        email: email,
        password: password,
      );

      if (data is SignUpModel) {
        await LocalDataRepository.setAccessToken(data.tokens.access);
        await LocalDataRepository.setProfile(data.userProfile);

        emit(state.copyWith(isLoading: false, userProfile: data.userProfile));
      } else {
        emit(state.copyWith(isLoading: false, isError: true, error: data));
      }
    } on ErrorModel catch (e) {
      emit(state.copyWith(isLoading: false, isError: true, error: e));
    }
  }
}
