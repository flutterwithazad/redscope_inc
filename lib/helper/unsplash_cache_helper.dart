import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static Future<void> saveData(String key, String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
  }

  static Future<String?> getData(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  static Future<bool> isDataCached(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(key);
  }
}
