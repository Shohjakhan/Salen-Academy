import '../../../injector_container.dart';
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

  ///Language code
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

  static Future<void> logout() async {
    await setAccessToken('');
  }
}
