import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lab1/cubit/cubits/settings_cubit.dart';
import 'package:lab1/cubit/states/settings_state.dart';
import 'package:lab1/presentation/widgets/custom_button.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SettingsCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Settings'),
        ),
        body: BlocBuilder<SettingsCubit, SettingsState>(
          builder: (context, state) {
            final cubit = context.read<SettingsCubit>();

            return ListView(
              padding: const EdgeInsets.all(16),
              children: [
                SwitchListTile(
                  title: const Text('Notifications'),
                  subtitle: const Text('Receive temperature alerts'),
                  value: state.notificationsEnabled,
                  onChanged: cubit.toggleNotifications,
                ),
                SwitchListTile(
                  title: const Text('Dark Mode'),
                  subtitle: const Text('Switch between light and dark themes'),
                  value: state.darkModeEnabled,
                  onChanged: cubit.toggleDarkMode,
                ),
                const SizedBox(height: 24),
                CustomButton(
                  text: 'Save Settings',
                  onPressed: () {
                    cubit.saveSettings();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Settings saved')),
                    );
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
