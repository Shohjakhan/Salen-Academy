import 'dart:convert';

import 'package:salen_academy/src/data/models/user_profile_model.dart';

import '../../../injector_container.dart';
import '../models/error_model.dart';
import '../resources/remote/api_client.dart';
import '../resources/remote/api_exceptions/api_exceptions.dart';

abstract class ProfileRepository {
  static Future<dynamic> setProfile({
    required String fullName,
    required String email,
    required String oldPaswd,
    required String newPaswd,
  }) async {
    try {
      final data = await sl<ApiClient>().request(
        '/user/profile/',
        method: 'PUT',
        body: {
          'full_name': fullName,
          'first_name': fullName.split(' ').first,
          'last_name': fullName.split(' ').last,
          'email': email,
        },
      );

      if (oldPaswd.isNotEmpty) {
        await sl<ApiClient>().request(
          '/user/password/change/',
          method: 'POST',
          body: {
            'old_password': oldPaswd,
            'new_password': newPaswd,
            'new_password_confirm': newPaswd,
          },
        );
      }

      return UserProfileModel.fromJson(data);
    } on ApiException catch (e) {
      throw ErrorModel(
        errorId: 0,
        isFriendly: true,
        message: e.body['error'],
      );
    } catch (e) {
      throw ErrorModel(
        errorId: 0,
        isFriendly: false,
        message: e.toString(),
      );
    }
  }
}
