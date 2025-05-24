import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lab1/cubit/states/settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit() : super(const SettingsState());

  void toggleNotifications(bool value) {
    emit(state.copyWith(notificationsEnabled: value));
  }

  void toggleDarkMode(bool value) {
    emit(state.copyWith(darkModeEnabled: value));
  }

  void saveSettings() {}
}
