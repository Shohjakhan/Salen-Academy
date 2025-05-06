import 'package:isar/isar.dart';

part 'isar_cache.g.dart';

@Collection()
class IsarCache {
  Id id = Isar.autoIncrement;
  late String key;
  late String value; // Change 'Value' to 'value'
}
