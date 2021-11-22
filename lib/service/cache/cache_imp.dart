import 'package:nine_chat/service/cache/cache_contract.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Cache implements ICache {
  final SharedPreferences _preference;
  Cache(this._preference);
  @override
  Future<String?> fetch(String key) async {
    if (!_preference.containsKey(key)) return null;
    return _preference.getString(key);
  }

  @override
  Future<bool> hasKey(String key) async {
    return _preference.containsKey(key);
  }

  @override
  Future<bool> remove(String key) async {
    return _preference.remove(key);
  }

  @override
  Future<bool> save(String key, String value) {
    return _preference.setString(key, value);
  }
}
