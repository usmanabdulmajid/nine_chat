abstract class ICache {
  Future<bool> save(String key, String value);
  Future<bool> remove(String key);
  Future<String?> fetch(String key);
  Future<bool> hasKey(String key);
}
