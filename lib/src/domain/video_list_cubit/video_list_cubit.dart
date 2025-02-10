import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salen_academy/src/data/models/video_list_model.dart';
import 'package:salen_academy/src/data/repositories/video_list_repository.dart';

import '../../data/models/error_model.dart';

part 'video_list_state.dart';

class VideoListCubit extends Cubit<VideoListState> {
  VideoListCubit() : super(VideoListState.init());

  Future<void> getVideos() async {
    emit(state.copyWith(isLoading: true, isError: false));
    try {
      var data = await VideoListRepository.getVideos();
      if (data is List<VideoModel>) {
        emit(state.copyWith(isLoading: false, videos: data));
      }
    } on ErrorModel catch (e) {
      emit(state.copyWith(isLoading: false, isError: true, error: e));
    }
  }
}
