import 'package:flutter/material.dart';
import 'package:lab1/presentation/widgets/custom_button.dart';
import 'package:lab1/presentation/widgets/custom_text_field.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool _isFormValid = false;

  void _validateForm() {
    setState(() {
      _isFormValid = _formKey.currentState?.validate() ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2A5298),
      appBar: AppBar(title: const Text('Create Account')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 20),
                  const Text(
                    'Create Jeheart Account',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 30),
                  CustomTextField(
                    labelText: 'Full Name',
                    prefixIcon: Icons.person,
                    labelStyle: const TextStyle(color: Colors.white),
                    iconColor: Colors.white,
                    textColor: Colors.white,
                    controller: _fullNameController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Full Name is required';
                      }
                      return null;
                    },
                    onChanged: (_) => _validateForm(),
                  ),
                  CustomTextField(
                    labelText: 'Email',
                    prefixIcon: Icons.email,
                    labelStyle: const TextStyle(color: Colors.white),
                    iconColor: Colors.white,
                    textColor: Colors.white,
                    controller: _emailController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Email is required';
                      }
                      if (!RegExp(
                        r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                      ).hasMatch(value)) {
                        return 'Enter a valid email';
                      }
                      return null;
                    },
                    onChanged: (_) => _validateForm(),
                  ),
                  CustomTextField(
                    labelText: 'Password',
                    prefixIcon: Icons.lock,
                    obscureText: true,
                    labelStyle: const TextStyle(color: Colors.white),
                    iconColor: Colors.white,
                    textColor: Colors.white,
                    controller: _passwordController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Password is required';
                      }
                      if (value.length < 6) {
                        return 'Password must be at least 7 characters';
                      }
                      return null;
                    },
                    onChanged: (_) => _validateForm(),
                  ),
                  CustomTextField(
                    labelText: 'Confirm Password',
                    prefixIcon: Icons.lock,
                    obscureText: true,
                    labelStyle: const TextStyle(color: Colors.white),
                    iconColor: Colors.white,
                    textColor: Colors.white,
                    controller: _confirmPasswordController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please confirm your password';
                      }
                      if (value != _passwordController.text) {
                        return 'Passwords do not match';
                      }
                      return null;
                    },
                    onChanged: (_) => _validateForm(),
                  ),
                  const SizedBox(height: 30),
                  CustomButton(
                    text: 'Register',
                    onPressed:
                        _isFormValid
                            ? () {
                              if (_formKey.currentState!.validate()) {
                                Navigator.pushReplacementNamed(
                                  context,
                                  '/home',
                                );
                              }
                            }
                            : () {},
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Already have an account?',
                        style: TextStyle(color: Colors.white),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          'Sign In',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
