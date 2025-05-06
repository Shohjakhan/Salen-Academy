abstract class LocalStorage {
  Future<dynamic> get(String key);
  Future<void> set(String key, dynamic value);
  dynamic getSync(String key);
  void setSync(String key, dynamic value);
  Future<void> delete(String key);
  Future<void> clear();
}
