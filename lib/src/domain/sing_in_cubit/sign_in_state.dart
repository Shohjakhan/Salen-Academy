part of 'sign_in_cubit.dart';

class SignInState extends Equatable {
  final bool isLoading;
  final bool isError;
  final ErrorModel? error;
  final SignInModel? signInModel;

  const SignInState({
    required this.isLoading,
    required this.isError,
    this.signInModel,
    this.error,
  });

  factory SignInState.init() {
    return SignInState(isLoading: false, isError: false);
  }

  SignInState copyWith({
    bool? isLoading,
    bool? isError,
    ErrorModel? error,
    SignInModel? signInModel,
  }) {
    return SignInState(
      isLoading: isLoading ?? this.isLoading,
      isError: isError ?? this.isError,
      error: error ?? this.error,
      signInModel: signInModel ?? this.signInModel,
    );
  }

  @override
  List<Object> get props => [
        isLoading.hashCode,
        isError.hashCode,
        error.hashCode,
        signInModel.hashCode,
      ];
}
