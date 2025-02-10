import 'dart:convert';

import '../../../injector_container.dart';
import '../models/error_model.dart';
import '../models/video_list_model.dart';
import '../resources/remote/api_client.dart';
import '../resources/remote/api_exceptions/api_exceptions.dart';

abstract class VideoListRepository {
  static Future<dynamic> getVideos() async {
    try {
      final data = await sl<ApiClient>().request(
        '/list_videos/',
        method: 'GET',
      );

      return videosFromJson(jsonEncode(data['list']));
    } on ApiException catch (e) {
      throw ErrorModel.fromJson(e.body['error']);
    } catch (e) {
      throw ErrorModel(errorId: 0, isFriendly: false, message: e.toString());
    }
  }
}
