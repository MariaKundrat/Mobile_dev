import '../../domain/entities/user.dart';
import '../../domain/repositories/user_repository.dart';
import '../local/user_local_storage.dart';

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
