import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lab1/data/repositories/user_repository_impl.dart';
import 'package:lab1/domain/entities/user.dart';
import 'package:lab1/domain/repositories/user_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum AuthStatus { unknown, authenticated, unauthenticated, loading, error }

class AuthServiceState {
  final AuthStatus status;
  final String? errorMessage;

  AuthServiceState(this.status, {this.errorMessage});
}

class AuthServiceCubit extends Cubit<AuthServiceState> {
  AuthServiceCubit() : super(AuthServiceState(AuthStatus.unknown));

  Future<void> checkLoginStatus() async {
    emit(AuthServiceState(AuthStatus.loading));
    final loggedIn = await AuthService.isUserLoggedIn();
    if (loggedIn) {
      emit(AuthServiceState(AuthStatus.authenticated));
    } else {
      emit(AuthServiceState(AuthStatus.unauthenticated));
    }
  }

  Future<void> login(String username, String password) async {
    emit(AuthServiceState(AuthStatus.loading));
    final success = await AuthService.validateCredentials(username, password);
    if (success) {
      await AuthService.setLoggedIn(true);
      await AuthService.saveCredentials(username, password);
      emit(AuthServiceState(AuthStatus.authenticated));
    } else {
      emit(AuthServiceState(AuthStatus.error,
          errorMessage: 'Invalid credentials',),);
    }
  }

  Future<void> logout() async {
    await AuthService.logout();
    emit(AuthServiceState(AuthStatus.unauthenticated));
  }
}

class AuthService {
  static final UserRepository _repository = UserRepositoryImpl();
  static const String _loggedInKey = 'is_logged_in';
  static const String _usernameKey = 'username';
  static const String _passwordKey = 'password';

  static Future<String?> getUsername() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_usernameKey);
  }

  static Future<bool> isUserLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_loggedInKey) ?? false;
  }

  static Future<bool> loginWithSavedCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    final username = prefs.getString(_usernameKey);
    final password = prefs.getString(_passwordKey);

    if (username != null && password != null) {
      final user = await _repository.login(username, password);
      return user != null;
    }
    return false;
  }

  static Future<void> saveCredentials(String username, String password) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_usernameKey, username);
    await prefs.setString(_passwordKey, password);
  }

  static Future<bool> validateCredentials(
    String username,
    String password,
  ) async {
    final user = await _repository.login(username, password);
    return user != null;
  }

  static Future<void> setLoggedIn(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_loggedInKey, value);
  }

  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_loggedInKey, false);
  }

  static Future<User?> getCurrentUser() async {
    return await _repository.getCurrentUser();
  }

  static Future<void> updateUser(User user) async {
    await _repository.updateUser(user);

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_usernameKey, user.email);
    await prefs.setString(_passwordKey, user.password);
  }
}
