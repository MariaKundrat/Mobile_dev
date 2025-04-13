import 'dart:convert';
import 'package:lab1/domain/entities/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserLocalStorage {
  final String key = 'user_data';

  Future<void> saveUser(User user) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, jsonEncode(user.toMap()));
  }

  Future<User?> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString(key);
    if (data == null) return null;
    return User.fromMap(jsonDecode(data) as Map<String, dynamic>);
  }

  Future<void> deleteUser() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }
}
