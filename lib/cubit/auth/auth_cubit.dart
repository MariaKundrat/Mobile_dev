import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lab1/cubit/auth/auth_state.dart';
import 'package:lab1/services/auth_service.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthState.initial()) {
    _init();
  }

  Future<void> _init() async {
    try {
      final loggedIn = await AuthService.isUserLoggedIn();
      final autoLogin =
          loggedIn && await AuthService.loginWithSavedCredentials();

      emit(state.copyWith(
        isLoggedIn: autoLogin,
        isLoading: false,
      ),);
    } catch (e) {
      emit(state.copyWith(
        isLoggedIn: false,
        isLoading: false,
        error: 'Failed to auto-login',
      ),);
    }
  }

  void loginSuccess() {
    emit(state.copyWith(
      isLoggedIn: true,
      isLoading: false,
    ),);
  }

  void logout() {
    AuthService.logout();
    emit(state.copyWith(
      isLoggedIn: false,
      isLoading: false,
    ),);
  }
}
