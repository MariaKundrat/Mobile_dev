import 'package:lab1/domain/entities/user.dart';

abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final User user;
  ProfileLoaded(this.user);
}

class ProfileSaving extends ProfileState {}

class ProfileSaved extends ProfileState {
  final User updatedUser;
  ProfileSaved(this.updatedUser);
}

class ProfileDeleting extends ProfileState {}

class ProfileDeleted extends ProfileState {}

class ProfileError extends ProfileState {
  final String message;
  ProfileError(this.message);
}
