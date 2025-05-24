import 'package:equatable/equatable.dart';

class AuthState extends Equatable {
  final bool isLoading;
  final bool isLoggedIn;
  final String? error;

  const AuthState({
    required this.isLoading,
    required this.isLoggedIn,
    this.error,
  });

  factory AuthState.initial() => const AuthState(
        isLoading: true,
        isLoggedIn: false,
      );

  AuthState copyWith({
    bool? isLoading,
    bool? isLoggedIn,
    String? error,
  }) {
    return AuthState(
      isLoading: isLoading ?? this.isLoading,
      isLoggedIn: isLoggedIn ?? this.isLoggedIn,
      error: error,
    );
  }

  @override
  List<Object?> get props => [isLoading, isLoggedIn, error];
}
