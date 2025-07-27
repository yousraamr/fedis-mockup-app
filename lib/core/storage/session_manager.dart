import 'package:shared_preferences/shared_preferences.dart';

class SessionManager {
  static const String _keyToken = 'token';
  static const String _keyUserName = 'userName';
  static const String _keyEmail = 'email';

  /// Save user session data
  static Future<void> saveSession({
    required String token,
    required String userName,
    required String email,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyToken, token);
    await prefs.setString(_keyUserName, userName);
    await prefs.setString(_keyEmail, email);
  }

  /// Retrieve token
  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyToken);
  }

  /// Retrieve user name
  static Future<String?> getUserName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyUserName);
  }

  /// Retrieve email
  static Future<String?> getEmail() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyEmail);
  }

  /// Clear session
  static Future<void> clearSession() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keyToken);
    await prefs.remove(_keyUserName);
    await prefs.remove(_keyEmail);
  }
}
