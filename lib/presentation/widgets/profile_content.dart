import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lab1/cubit/profile/profile_cubit.dart';
import 'package:lab1/cubit/profile/profile_logic_state.dart';
import 'package:lab1/presentation/widgets/custom_button.dart';
import 'package:lab1/presentation/widgets/profile_info_item.dart';
import 'package:lab1/services/auth_service.dart';

class ProfileContent extends StatelessWidget {
  final ProfileLoaded state;
  const ProfileContent(this.state, {super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ProfileCubit>();

    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Card(
          color: Colors.transparent,
          elevation: 0,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                const CircleAvatar(
                  radius: 60,
                  backgroundColor: Color(0xFFC1E1FF),
                  child: Icon(Icons.person, size: 60, color: Color(0xFF2665B6)),
                ),
                const SizedBox(height: 16),
                if (state.isEditing)
                  _editingFields(context, cubit)
                else
                  _displayFields(context, cubit),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _editingFields(BuildContext context, ProfileCubit cubit) {
    return Column(
      children: [
        _editableField('Name', cubit.nameController),
        _editableField('Email', cubit.emailController),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: () => cubit.toggleEdit(false),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: cubit.updateUserData,
              child: const Text('Save'),
            ),
          ],
        ),
      ],
    );
  }

  Widget _displayFields(BuildContext context, ProfileCubit cubit) {
    return Column(
      children: [
        Text(
          state.user.name,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        Text(
          state.user.email,
          style: const TextStyle(fontSize: 16, color: Colors.white70),
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: () => cubit.toggleEdit(true),
          child: const Text('Edit Profile'),
        ),
        const SizedBox(height: 30),
        const ProfileInfoItem(
          icon: Icons.account_balance,
          title: 'Account',
          subtitle: 'Personal details',
        ),
        const Divider(color: Colors.white54),
        const ProfileInfoItem(
          icon: Icons.settings,
          title: 'Settings',
          subtitle: 'App settings, notifications',
        ),
        const Divider(color: Colors.white54),
        const ProfileInfoItem(
          icon: Icons.help,
          title: 'Help Center',
          subtitle: 'FAQ, contact support',
        ),
        const SizedBox(height: 40),
        CustomButton(
          text: 'Log Out',
          backgroundColor: Colors.lightGreen,
          onPressed: () async {
            final shouldLogout = await showDialog<bool>(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('Confirm Logout'),
                content: const Text('Are you sure you want to log out?'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context, false),
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pop(context, true),
                    child: const Text('Logout'),
                  ),
                ],
              ),
            );
            if (shouldLogout == true) {
              await AuthService.logout();
              if (!context.mounted) return;
              Navigator.pushReplacementNamed(context, '/login');
            }
          },
        ),
      ],
    );
  }

  Widget _editableField(String label, TextEditingController controller) {
    return Column(
      children: [
        TextField(
          controller: controller,
          decoration: InputDecoration(
            labelText: label,
            labelStyle: const TextStyle(color: Colors.white),
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white54),
            ),
          ),
          style: const TextStyle(color: Colors.white),
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}
