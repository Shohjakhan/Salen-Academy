import 'dart:convert';

import 'package:salen_academy/src/data/models/sign_in_model.dart';

import '../../../injector_container.dart';
import '../models/error_model.dart';
import '../resources/remote/api_client.dart';
import '../resources/remote/api_exceptions/api_exceptions.dart';

abstract class SignInRepository {
  static Future<dynamic> signIn({
    required String userName,
    required String password,
  }) async {
    try {
      final data = await sl<ApiClient>().request(
        '/login/',
        method: 'POST',
        body: {
          'username': userName,
          'password': password,
        },
      );

      return signInModelFromJson(jsonEncode(data));
    } on ApiException catch (e) {
      throw ErrorModel(
        errorId: 0,
        isFriendly: true,
        message: e.body['non_field_errors'][0],
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
