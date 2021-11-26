abstract class ICache {
  Future<bool> save(String key, String value);
  Future<bool> remove(String key);
  String? fetch(String key);
  Future<bool> hasKey(String key);
  Future<bool> saveBool(String key, bool value);
  bool? fetchBool(String key);
}
