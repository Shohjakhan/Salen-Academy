import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salen_academy/src/data/models/sign_in_model.dart';
import 'package:salen_academy/src/data/repositories/local_data_repository.dart';
import 'package:salen_academy/src/data/repositories/sign_in_repository.dart';

import '../../data/models/error_model.dart';

part 'sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  SignInCubit() : super(SignInState.init());

  Future<void> onSignIn({
    required String email,
    required String password,
  }) async {
    emit(state.copyWith(isLoading: true, isError: false));
    try {
      var data = await SignInRepository.signIn(
        email: email,
        password: password,
      );
      if (data is SignInModel) {
        await LocalDataRepository.setAccessToken(data.access);
        emit(state.copyWith(isLoading: false, signInModel: data));
      }
    } on ErrorModel catch (e) {
      emit(state.copyWith(isLoading: false, isError: true, error: e));
    }
  }
}
