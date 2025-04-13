import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static const _usernameKey = 'username';
  static const _passwordKey = 'password';
  static const _isLoggedInKey = 'is_logged_in';

  static Future<bool> isUserLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_isLoggedInKey) ?? false;
  }

  static Future<bool> loginWithSavedCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    final username = prefs.getString(_usernameKey);
    final password = prefs.getString(_passwordKey);

    if (username != null && password != null) {
      return true;
    }
    return false;
  }

  static Future<void> saveCredentials(String username, String password) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_usernameKey, username);
    await prefs.setString(_passwordKey, password);

    await prefs.setBool(_isLoggedInKey, true);
  }

  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_usernameKey);
    await prefs.remove(_passwordKey);
    await prefs.setBool(_isLoggedInKey, false);
  }

  static Future<String?> getUsername() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_usernameKey);
  }

  static Future<void> setLoggedIn(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_isLoggedInKey, value);
  }

  static Future<bool> validateCredentials(
    String username,
    String password,
  ) async {
    final prefs =
        await SharedPreferences.getInstance(); // Ensure you await this.
    final savedUsername = prefs.getString(_usernameKey);
    final savedPassword = prefs.getString(_passwordKey);

    if (savedUsername == null || savedPassword == null) {
      return false;
    }

    return username == savedUsername && password == savedPassword;
  }
}
