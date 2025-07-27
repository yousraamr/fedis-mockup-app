import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static SharedPreferences? _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static Future<bool> saveData(String key, dynamic value) async {
    if (value is String) return await _prefs!.setString(key, value);
    if (value is bool) return await _prefs!.setBool(key, value);
    if (value is int) return await _prefs!.setInt(key, value);
    if (value is double) return await _prefs!.setDouble(key, value);
    return false;
  }

  static dynamic getData(String key) {
    return _prefs!.get(key);
  }

  static Future<void> removeData(String key) async {
    await _prefs!.remove(key);
  }

  static Future<void> clear() async {
    await _prefs!.clear();
  }
}