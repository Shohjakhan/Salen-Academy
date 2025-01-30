import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salen_academy/src/data/repositories/sign_up_repository.dart';

import '../../data/models/error_model.dart';
import '../../data/models/user_model.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit() : super(SignUpState.init());

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

      if (data is UserModel) {
        emit(state.copyWith(isLoading: false, userModel: data));
      } else {
        emit(state.copyWith(isLoading: false, isError: true, error: data));
      }
    } on ErrorModel catch (e) {
      emit(state.copyWith(isLoading: false, isError: true, error: e));
    }
  }
}
