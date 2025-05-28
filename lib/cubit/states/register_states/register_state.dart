import 'package:equatable/equatable.dart';

class RegisterState extends Equatable {
  final String fullName;
  final String email;
  final String password;
  final String confirmPassword;
  final bool isFormValid;
  final bool isSubmitting;
  final String? errorMessage;

  const RegisterState({
    this.fullName = '',
    this.email = '',
    this.password = '',
    this.confirmPassword = '',
    this.isFormValid = false,
    this.isSubmitting = false,
    this.errorMessage,
  });

  RegisterState copyWith({
    String? fullName,
    String? email,
    String? password,
    String? confirmPassword,
    bool? isFormValid,
    bool? isSubmitting,
    String? errorMessage,
  }) {
    return RegisterState(
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      isFormValid: isFormValid ?? this.isFormValid,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        fullName,
        email,
        password,
        confirmPassword,
        isFormValid,
        isSubmitting,
        errorMessage,
      ];
}
