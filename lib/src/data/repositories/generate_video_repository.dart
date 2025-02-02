import 'dart:convert';

import '../../../injector_container.dart';
import '../models/error_model.dart';
import '../models/generated_video_model.dart';
import '../resources/remote/api_client.dart';
import '../resources/remote/api_exceptions/api_exceptions.dart';

abstract class GenerateVideoRepository {
  static Future<dynamic> getVideo({
    required String topic,
    required String quality,
    required String langCode,
  }) async {
    try {
      final data = await sl<ApiClient>().request(
        '/generate_video/',
        method: 'POST',
        body: {
          'prompt': topic,
          'quality': quality,
          'language': langCode,
        },
      );

      return generatedVideoModelFromJson(jsonEncode(data));
    } on ApiException catch (e) {
      throw ErrorModel.fromJson(e.body['error']);
    } catch (e) {
      throw ErrorModel(errorId: 0, isFriendly: false, message: e.toString());
    }
  }
}
