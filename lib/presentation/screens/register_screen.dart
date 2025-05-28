import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lab1/cubit/cubits/register_cubits/register_cubit.dart';
import 'package:lab1/cubit/states/register_states/register_state.dart';
import 'package:lab1/presentation/widgets/custom_button.dart';
import 'package:lab1/presentation/widgets/custom_text_field.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => RegisterCubit(),
      child: Scaffold(
        backgroundColor: const Color(0xFF2A5298),
        appBar: AppBar(title: const Text('Create Account')),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: SingleChildScrollView(
              child: BlocConsumer<RegisterCubit, RegisterState>(
                listener: (context, state) {
                  if (state.errorMessage != null) {
                    showDialog<void>(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Error'),
                        content: Text(state.errorMessage!),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('OK'),
                          ),
                        ],
                      ),
                    );
                  } else if (!state.isSubmitting &&
                      state.errorMessage == null &&
                      state.isFormValid) {
                    Navigator.pushReplacementNamed(context, '/home');
                  }
                },
                builder: (context, state) {
                  final cubit = context.read<RegisterCubit>();

                  return Form(
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
                          onChanged: cubit.fullNameChanged,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Full Name is required';
                            }
                            if (value.contains(RegExp(r'[0-9]'))) {
                              return 'Name cannot contain numbers';
                            }
                            return null;
                          },
                        ),
                        CustomTextField(
                          labelText: 'Email',
                          prefixIcon: Icons.email,
                          labelStyle: const TextStyle(color: Colors.white),
                          iconColor: Colors.white,
                          textColor: Colors.white,
                          onChanged: cubit.emailChanged,
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
                        ),
                        CustomTextField(
                          labelText: 'Password',
                          prefixIcon: Icons.lock,
                          obscureText: true,
                          labelStyle: const TextStyle(color: Colors.white),
                          iconColor: Colors.white,
                          textColor: Colors.white,
                          onChanged: cubit.passwordChanged,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Password is required';
                            }
                            if (value.length < 6) {
                              return 'Password must be at least 6 characters';
                            }
                            return null;
                          },
                        ),
                        CustomTextField(
                          labelText: 'Confirm Password',
                          prefixIcon: Icons.lock,
                          obscureText: true,
                          labelStyle: const TextStyle(color: Colors.white),
                          iconColor: Colors.white,
                          textColor: Colors.white,
                          onChanged: cubit.confirmPasswordChanged,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please confirm your password';
                            }
                            if (value != state.password) {
                              return 'Passwords do not match';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 30),
                        if (state.isSubmitting)
                          const Center(
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          )
                        else
                          CustomButton(
                            text: 'Register',
                            onPressed: state.isFormValid ? cubit.submit : null,
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
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
