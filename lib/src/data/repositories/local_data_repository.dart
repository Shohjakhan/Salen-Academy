import 'dart:convert';

import '../../../injector_container.dart';
import '../models/user_profile_model.dart';
import '../resources/local/local_storage.dart';

abstract class LocalDataRepository {
  ///Language code
  static const _kLanguageCode = 'LANGUAGE_CODE';
  static Future<String> getLanguageCode() async {
    return await sl<LocalStorage>().get(_kLanguageCode) ?? 'en';
  }

  static Future<void> setLanguageCode(dynamic value) async {
    await sl<LocalStorage>().set(_kLanguageCode, value);
  }

  static String getLanguageCodeSync() {
    return sl<LocalStorage>().getSync(_kLanguageCode) ?? 'en';
  }

  static void setLanguageCodeSync(dynamic value) {
    sl<LocalStorage>().setSync(_kLanguageCode, value);
  }

  ///Access token
  static const _kAccessToken = 'ACCESS_TOKEN';
  static Future<String> getAccessToken() async {
    return await sl<LocalStorage>().get(_kAccessToken) ?? '';
  }

  static Future<void> setAccessToken(dynamic value) async {
    await sl<LocalStorage>().set(_kAccessToken, value);
  }

  static String getAccessTokenSync() {
    return sl<LocalStorage>().getSync(_kAccessToken) ?? '';
  }

  static void setAccessTokenSync(dynamic value) {
    sl<LocalStorage>().setSync(_kAccessToken, value);
  }

  ///Profile
  static const _kProfile = 'PROFILE';
  static Future<String> getProfile() async {
    return await sl<LocalStorage>().get(_kProfile) ?? '';
  }

  static Future<void> setProfile(UserProfileModel value) async {
    await sl<LocalStorage>().set(_kProfile, jsonEncode(value.toJson()));
  }

  static UserProfileModel getProfileSync() {
    String value = sl<LocalStorage>().getSync(_kProfile) ?? '';
    return UserProfileModel.fromJson(jsonDecode(value));
  }

  static void setProfileSync(dynamic value) {
    sl<LocalStorage>().setSync(_kProfile, value);
  }

  static Future<void> logout() async {
    await setAccessToken('');
  }
}
