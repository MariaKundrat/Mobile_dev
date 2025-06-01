import 'package:equatable/equatable.dart';
import 'package:lab1/domain/entities/user.dart';

abstract class ProfileState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final User user;
  final bool isEditing;

  ProfileLoaded({required this.user, this.isEditing = false});

  ProfileLoaded copyWith({
    User? user,
    bool? isEditing,
  }) {
    return ProfileLoaded(
      user: user ?? this.user,
      isEditing: isEditing ?? this.isEditing,
    );
  }

  @override
  List<Object?> get props => [user, isEditing];
}

class ProfileSaving extends ProfileState {}

class ProfileSaved extends ProfileState {
  final User updatedUser;
  ProfileSaved(this.updatedUser);

  @override
  List<Object?> get props => [updatedUser];
}

class ProfileDeleting extends ProfileState {}

class ProfileDeleted extends ProfileState {}

class ProfileError extends ProfileState {
  final String message;
  ProfileError(this.message);

  @override
  List<Object?> get props => [message];
}
