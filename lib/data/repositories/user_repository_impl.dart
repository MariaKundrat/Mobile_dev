import 'package:lab1/data/local/user_local_storage.dart';
import 'package:lab1/domain/entities/user.dart';
import 'package:lab1/domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final UserLocalStorage storage = UserLocalStorage();

  @override
  Future<void> register(User user) => storage.saveUser(user);

  @override
  Future<User?> login(String email, String password) async {
    final user = await storage.getUser();
    if (user != null && user.email == email && user.password == password) {
      return user;
    }
    return null;
  }

  @override
  Future<User?> getCurrentUser() => storage.getUser();

  @override
  Future<void> updateUser(User user) => storage.saveUser(user);

  @override
  Future<void> deleteUser() => storage.deleteUser();
}
