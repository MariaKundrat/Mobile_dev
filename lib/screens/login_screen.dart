import 'package:flutter/material.dart';
import 'package:lab1/widgets/custom_button.dart';
import 'package:lab1/widgets/custom_text_field.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DecoratedBox(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF1E3C72), Color(0xFF2A5298)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      'Jeheart',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: Colors.lightBlue,
                      ),
                    ),
                    const SizedBox(height: 20),
                    const CustomTextField(
                      labelText: 'Username',
                      prefixIcon: Icons.person,
                    ),
                    const CustomTextField(
                      labelText: 'Password',
                      prefixIcon: Icons.lock,
                      obscureText: true,
                    ),
                    const SizedBox(height: 20),
                    CustomButton(
                      text: 'Log in',
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, '/home');
                      },
                    ),
                    const SizedBox(height: 10),
                    CustomButton(
                      text: 'Sign up',
                      backgroundColor: Colors.blue,
                      onPressed: () {
                        Navigator.pushNamed(context, '/register');
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
