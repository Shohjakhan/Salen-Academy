part of 'profile_cubit.dart';

class ProfileState extends Equatable {
  final bool isLoading;
  final bool isError;
  final ErrorModel? error;
  final UserProfileModel? userProfile;

  const ProfileState({
    required this.isLoading,
    required this.isError,
    this.error,
    this.userProfile,
  });

  factory ProfileState.init() {
    return ProfileState(
      isLoading: false,
      isError: false,
    );
  }

  ProfileState copyWith({
    bool? isLoading,
    bool? isError,
    ErrorModel? error,
    UserProfileModel? userProfile,
  }) {
    return ProfileState(
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
