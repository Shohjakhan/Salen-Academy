part of 'sign_up_cubit.dart';

class SignUpState extends Equatable {
  final bool isLoading;
  final bool isError;
  final ErrorModel? error;
  final UserProfileModel? userProfile;

  const SignUpState({
    required this.isLoading,
    required this.isError,
    this.error,
    this.userProfile,
  });

  factory SignUpState.init() {
    return SignUpState(isLoading: false, isError: false);
  }

  SignUpState copyWith({
    bool? isLoading,
    bool? isError,
    ErrorModel? error,
    UserProfileModel? userProfile,
  }) {
    return SignUpState(
      isLoading: isLoading ?? this.isLoading,
      isError: isError ?? this.isError,
      error: error ?? this.error,
      userProfile: userProfile ?? this.userProfile,
    );
  }

  @override
  List<Object> get props => [
        isLoading.hashCode,
        isError.hashCode,
        error.hashCode,
        userProfile.hashCode,
      ];
}
