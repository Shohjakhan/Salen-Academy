import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salen_academy/src/data/models/generated_video_model.dart';
import 'package:salen_academy/src/data/repositories/generate_video_repository.dart';
import 'package:salen_academy/src/data/repositories/local_data_repository.dart';
import 'package:salen_academy/src/data/resources/remote/socket_client.dart';

import '../../data/models/error_model.dart';

part 'video_state.dart';

class VideoCubit extends Cubit<VideoState> {
  VideoCubit() : super(VideoState.init());

  Future<void> getVideo({
    required String topic,
    required String quality,
    required String langCode,
  }) async {
    emit(state.copyWith(isLoading: true));

    try {
      var data = await GenerateVideoRepository.getVideo(
        topic: topic,
        quality: quality,
        langCode: langCode,
      );

      if (data is GeneratedVideoModel) {
        emit(state.copyWith(isLoading: false, videoLink: data.videoLink));
      }
    } on ErrorModel catch (e) {
      emit(state.copyWith(isLoading: false, isError: true, error: e));
    }
  }

  Future<void> socketInit() async {
    String token = LocalDataRepository.getAccessTokenSync();

    await SocketClient.init(
        'https://salenacademy.com/ws/video-status/?token=$token');
  }

  Future<void> onVideo() async {
    try {
      var socket = SocketClient.socket;
      if (socket.connected) {
        socket.on('event', (data) {});
      } else {
        await socketInit();
        onVideo();
      }
    } catch (e) {}
  }
}
