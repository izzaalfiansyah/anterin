import 'package:shared_preferences/shared_preferences.dart';

class AuthToken {
  static String key = 'token';

  static Future<String?> get() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(key);

    return token;
  }

  static Future<void> set(String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  static Future<void> remove() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
  }
}
