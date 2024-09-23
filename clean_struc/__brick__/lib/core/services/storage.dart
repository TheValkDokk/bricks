import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@lazySingleton
class StorageService {
  late final SharedPreferences _storage;

  @PostConstruct(preResolve: false)
  Future<void> init() async {
    _storage = await SharedPreferences.getInstance();
  }

  Future<void> write(String key, String value) async {
    await _storage.setString(key, value);
  }

  Future<String?> read(String key) async {
    return _storage.getString(key);
  }

  Future<void> delete(String key) async {
    await _storage.remove(key);
  }
}
