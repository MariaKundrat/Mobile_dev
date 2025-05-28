import 'package:equatable/equatable.dart';

class SettingsState extends Equatable {
  final bool notificationsEnabled;
  final bool darkModeEnabled;

  const SettingsState({
    this.notificationsEnabled = true,
    this.darkModeEnabled = false,
  });

  SettingsState copyWith({
    bool? notificationsEnabled,
    bool? darkModeEnabled,
  }) {
    return SettingsState(
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
      darkModeEnabled: darkModeEnabled ?? this.darkModeEnabled,
    );
  }

  @override
  List<Object> get props => [notificationsEnabled, darkModeEnabled];
}
