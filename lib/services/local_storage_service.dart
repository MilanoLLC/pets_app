
import 'package:pets_app/helpers/STORAGE_KEYS.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class ILocalStorageService {
  void set<T>(String key, T content);
  T? get<T>(String key);
  bool? hasKey(String key);

  void clearUserData();
}

class LocalStorageService extends ILocalStorageService {
  static LocalStorageService? _instance;
  static SharedPreferences? _preferences;

  static Future<LocalStorageService?> getInstance() async {
    _instance ??= LocalStorageService();
    _preferences ??= await SharedPreferences.getInstance();
    return _instance;
  }

  @override
  void set<T>(String key, T content) {
    if (content is String) {
      _preferences?.setString(key, content);
    }
    if (content is bool) {
      _preferences?.setBool(key, content);
    }
    if (content is int) {
      _preferences?.setInt(key, content);
    }
    if (content is double) {
      _preferences?.setDouble(key, content);
    }
    if (content is List<String>) {
      _preferences?.setStringList(key, content);
    }
  }

  @override
  T? get<T>(String key) {
    if (hasKey(key) != null) {
      var item = _preferences?.get(key);
      return item as T;
    }
    return null;
  }

  @override
  bool? hasKey(String key) {
    return _preferences?.containsKey(key);
  }

  @override
  void clearUserData() {
    _preferences?.remove(STORAGE_KEYS.token);
    _preferences?.remove(STORAGE_KEYS.userId);
    // _preferences?.clear();
  }
}
