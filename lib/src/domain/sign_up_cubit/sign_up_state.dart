part of 'sign_up_cubit.dart';

class SignUpState extends Equatable {
  final bool isLoading;
  final bool isError;
  final ErrorModel? error;
  final UserModel? userModel;

  const SignUpState({
    required this.isLoading,
    required this.isError,
    this.error,
    this.userModel,
  });

  factory SignUpState.init() {
    return SignUpState(isLoading: false, isError: false);
  }

  SignUpState copyWith({
    bool? isLoading,
    bool? isError,
    ErrorModel? error,
    UserModel? userModel,
  }) {
    return SignUpState(
      isLoading: isLoading ?? this.isLoading,
      isError: isError ?? this.isError,
      error: error ?? this.error,
      userModel: userModel ?? this.userModel,
    );
  }

  @override
  List<Object> get props => [
        isLoading.hashCode ^
            isError.hashCode ^
            error.hashCode ^
            userModel.hashCode,
      ];
}
