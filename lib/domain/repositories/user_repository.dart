import 'package:lab1/domain/entities/user.dart';

abstract class UserRepository {
  Future<void> register(User user);
  Future<User?> login(String email, String password);
  Future<User?> getCurrentUser();
  Future<void> updateUser(User user);
  Future<void> deleteUser();
}
