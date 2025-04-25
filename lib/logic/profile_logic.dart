import 'package:flutter/material.dart';
import 'package:lab1/domain/entities/user.dart';
import 'package:lab1/logic/login_logic.dart';

class ProfileLogic {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final loginLogic = LoginLogic();

  void initialize(User user) {
    nameController.text = user.name;
    emailController.text = user.email;
    passwordController.text = user.password;
  }

  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  Future<bool> saveChanges(GlobalKey<FormState> formKey) async {
    if (!formKey.currentState!.validate()) return false;

    final updatedUser = User(
      name: nameController.text.trim(),
      email: emailController.text.trim(),
      password: passwordController.text,
    );

    return await loginLogic.updateUserInfo(updatedUser);
  }

  Future<void> deleteAccount() async {
    await loginLogic.deleteUserAccount();
  }
}
