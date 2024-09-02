import 'package:shared_preferences/shared_preferences.dart';

class PrefsUtils {
  Future<bool> save(String key, dynamic value) async {
    SharedPreferences p = await SharedPreferences.getInstance();

    if (value is String) {
      return p.setString(key, value);
    } else if (value is int) {
      return p.setInt(key, value);
    } else if (value is double) {
      return p.setDouble(key, value);
    } else if (value is bool) {
      return p.setBool(key, value);
    } else if (value == null) {
      return p.remove(key);
    } else {
      throw Exception("Unsupported data type");
    }
  }

  Future<T?> get<T>(String key) async {
    SharedPreferences p = await SharedPreferences.getInstance();
    dynamic value = p.get(key);
    return value;
  }

  Future<bool> clear(String key) async {
    SharedPreferences p = await SharedPreferences.getInstance();
    return p.remove(key);
  }

  Future<bool> clearAll() async {
    SharedPreferences p = await SharedPreferences.getInstance();
    return p.clear();
  }
}
