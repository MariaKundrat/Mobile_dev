import 'package:lab1/data/repositories/user_repository_impl.dart';
import 'package:lab1/domain/entities/user.dart';
import 'package:lab1/domain/repositories/user_repository.dart';

class LoginLogic {
  final UserRepository _repository = UserRepositoryImpl();

  Future<bool> login(String email, String password) async {
    final user = await _repository.login(email, password);
    return user != null;
  }

  Future<String?> validateRegistration(
    String email,
    String name,
    String password,
  ) async {
    if (email.isEmpty || !email.contains('@')) {
      return Future.value('Incorrect email format');
    }

    if (name.isEmpty || name.contains(RegExp(r'[0-9]'))) {
      return Future.value('The name cannot be empty or contain numbers');
    }

    if (password.length < 6) {
      return Future.value('Password must contain at least 6 characters');
    }

    return Future.value();
  }

  Future<bool> register(String email, String name, String password) async {
    final validationError = await validateRegistration(email, name, password);
    if (validationError != null) {
      return false;
    }

    final existingUser = await _repository.login(email, password);
    if (existingUser != null) {
      return false;
    }

    final user = User(email: email, name: name, password: password);
    await _repository.register(user);
    return true;
  }

  Future<User?> getCurrentUser() {
    return _repository.getCurrentUser();
  }

  Future<bool> updateUserInfo(User updatedUser) async {
    await _repository.updateUser(updatedUser);
    return true;
  }

  Future<bool> deleteUserAccount() async {
    await _repository.deleteUser();
    return true;
  }
}
