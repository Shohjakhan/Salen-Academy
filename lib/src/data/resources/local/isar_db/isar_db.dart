import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import '../local_storage.dart';
import 'isar_cache.dart';

class IsarDB implements LocalStorage {
  late Future<Isar> db;

  IsarDB() {
    db = openDb();
  }

  @override
  Future<void> clear() async {
    final isar = await db;
    await isar.writeTxn(() => isar.clear());
  }

  @override
  Future<void> delete(String key) async {
    final isar = await db;
    final cache = await isar.isarCaches.filter().keyEqualTo(key).findFirst();
    if (cache != null) {
      await isar.writeTxn(() async => await isar.isarCaches.delete(cache.id));
    }
  }

  @override
  Future<dynamic> get(String key) async {
    final isar = await db;
    final cache = await isar.isarCaches.filter().keyEqualTo(key).findFirst();
    if (cache != null) {
      return cache.value;
    }
  }

  @override
  Future<void> set(String key, value) async {
    final isar = await db;

    var cache = IsarCache();
    final old = await isar.isarCaches.filter().keyEqualTo(key).findFirst();

    if (old != null) {
      cache = old;
      cache.value = value;
    } else {
      cache.key = key;
      cache.value = value;
    }

    await isar.writeTxn(() async => await isar.isarCaches.put(cache));
  }

  Future<Isar> openDb() async {
    if (Isar.instanceNames.isEmpty) {
      final dir = await getApplicationDocumentsDirectory();
      return await Isar.open(
        [IsarCacheSchema],
        directory: dir.path,
        inspector: true,
      );
    }
    return Future.value(Isar.getInstance());
  }

  @override
  getSync(String key) {
    final isar = Isar.getInstance();
    final cache = isar?.isarCaches.filter().keyEqualTo(key).findFirstSync();
    if (cache != null) {
      return cache.value;
    }
  }

  @override
  void setSync(String key, value) {
    final isar = Isar.getInstance();

    var cache = IsarCache();
    final old = isar?.isarCaches.filter().keyEqualTo(key).findFirstSync();

    if (old != null) {
      cache = old;
      cache.value = value;
    } else {
      cache.key = key;
      cache.value = value;
    }

    isar?.writeTxnSync(() => isar.isarCaches.putSync(cache));
  }
}
