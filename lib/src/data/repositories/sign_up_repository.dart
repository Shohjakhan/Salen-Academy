import 'dart:convert';

import 'package:salen_academy/src/data/models/sign_up_model.dart';

import '../../../injector_container.dart';
import '../models/error_model.dart';
import '../resources/remote/api_client.dart';
import '../resources/remote/api_exceptions/api_exceptions.dart';

abstract class SignUpRepository {
  static Future<dynamic> signUp({
    required String userName,
    required String email,
    required String password,
  }) async {
    try {
      final data = await sl<ApiClient>().request(
        '/auth/register/',
        method: 'POST',
        body: {
          'full_name': userName,
          'email': email,
          'password': password,
          'password_confirm': password,
        },
      );

      return signUpModelFromJson(jsonEncode(data));
    } on ApiException catch (e) {
      throw ErrorModel(errorId: 0, message: e.body['error'], isFriendly: true);
    } catch (e) {
      throw ErrorModel(errorId: 0, isFriendly: false, message: e.toString());
    }
  }
}
