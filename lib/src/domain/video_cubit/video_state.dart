part of 'video_cubit.dart';

class VideoState extends Equatable {
  final bool isLoading;
  final bool isError;
  final ErrorModel? error;
  final String videoLink;

  const VideoState({
    required this.isLoading,
    required this.isError,
    required this.videoLink,
    this.error,
  });

  factory VideoState.init() {
    return VideoState(
      isLoading: false,
      isError: false,
      videoLink: '',
    );
  }

  VideoState copyWith({
    bool? isLoading,
    bool? isError,
    ErrorModel? error,
    String? videoLink,
  }) {
    return VideoState(
      isLoading: isLoading ?? this.isLoading,
      isError: isError ?? this.isError,
      error: error ?? this.error,
      videoLink: videoLink ?? this.videoLink,
    );
  }

  @override
  List<Object> get props => [];
}
