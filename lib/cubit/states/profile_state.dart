part of '../profile_cubit.dart';

abstract class ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final User user;
  final bool isEditing;

  ProfileLoaded({required this.user, this.isEditing = false});

  ProfileLoaded copyWith({User? user, bool? isEditing}) {
    return ProfileLoaded(
      user: user ?? this.user,
      isEditing: isEditing ?? this.isEditing,
    );
  }
}

class ProfileError extends ProfileState {
  final String message;
  ProfileError(this.message);
}
