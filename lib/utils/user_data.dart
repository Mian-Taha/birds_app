import 'package:shared_preferences/shared_preferences.dart';

class UserData {
  static SharedPreferences? _prefs;

  // Initialize shared preferences
  static Future<void> _initPrefs() async {
    if (_prefs == null) {
      _prefs = await SharedPreferences.getInstance();
    }
  }

  // Store user data in shared preferences
  static Future<void> storeUserData(String email, String name,String password) async {
    await _initPrefs();
    await _prefs!.setString('email', email);
    await _prefs!.setString('name', name);
    await _prefs!.setString('password', password);
  }

  // Get stored user data from shared preferences
  static Future<Map<String, String>> getUserData() async {
    await _initPrefs();
    String? email = _prefs!.getString('email');
    String? name = _prefs!.getString('name');
    String? password = _prefs!.getString('password');
    return {'email': email ?? '', 'name': name ?? '','password': password ?? '',};
  }

  // Clear user data from shared preferences
  static Future<void> clearUserData() async {
    await _initPrefs();
    await _prefs!.remove('email');
    await _prefs!.remove('name');
    await _prefs!.remove('password');
  }
}
