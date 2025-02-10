part of 'video_list_cubit.dart';

class VideoListState extends Equatable {
  final bool isLoading;
  final bool isError;
  final ErrorModel? error;
  final List<VideoModel> videos;

  const VideoListState({
    required this.isLoading,
    required this.isError,
    required this.videos,
    this.error,
  });

  factory VideoListState.init() {
    return VideoListState(
      isLoading: false,
      isError: false,
      videos: [],
    );
  }

  VideoListState copyWith({
    bool? isLoading,
    bool? isError,
    ErrorModel? error,
    List<VideoModel>? videos,
  }) {
    return VideoListState(
      isLoading: isLoading ?? this.isLoading,
      isError: isError ?? this.isError,
      videos: videos ?? this.videos,
      error: error ?? this.error,
    );
  }

  @override
  List<Object> get props => [
        isLoading.hashCode,
        isError.hashCode,
        error.hashCode,
        videos.hashCode,
      ];
}
