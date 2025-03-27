import 'package:flutter/material.dart';
import 'package:lab1/widgets/custom_button.dart';
import 'package:lab1/widgets/custom_text_field.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Account'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 20),
                const Text(
                  'Create a Heart Account',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 30),
                const CustomTextField(
                  labelText: 'Full Name',
                  prefixIcon: Icons.person,
                ),
                const CustomTextField(
                  labelText: 'Email',
                  prefixIcon: Icons.email,
                ),
                const CustomTextField(
                  labelText: 'Password',
                  prefixIcon: Icons.lock,
                  obscureText: true,
                ),
                const CustomTextField(
                  labelText: 'Confirm Password',
                  prefixIcon: Icons.lock,
                  obscureText: true,
                ),
                const SizedBox(height: 30),
                CustomButton(
                  text: 'Register',
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/home');
                  },
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Already have an account?'),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Sign In'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
