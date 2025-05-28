import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lab1/cubit/cubits/login_cubits/login_cubit.dart';
import 'package:lab1/cubit/states/login_states/login_state.dart';
import 'package:lab1/presentation/widgets/custom_button.dart';
import 'package:lab1/services/connection_service.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final ValueNotifier<bool> _rememberMe = ValueNotifier(true);

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (_) => LoginCubit(ConnectivityService())..checkAutoLogin(),
        child: BlocListener<LoginCubit, LoginState>(
          listener: (context, state) {
            if (state is LoginFailure) {
              showDialog<bool>(
                context: context,
                builder: (_) => AlertDialog(
                  title: const Text('Error'),
                  content: Text(state.message),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('OK'),
                    ),
                  ],
                ),
              );
            }
            if (state is LoginSuccess) {
              Navigator.pushReplacementNamed(context, '/home');
            }
          },
          child: BlocBuilder<LoginCubit, LoginState>(
            builder: (context, state) {
              final isLoading = state is LoginLoading;
              return DecoratedBox(
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
                            _buildTextField(
                              controller: _usernameController,
                              labelText: 'Username/Email',
                              icon: Icons.person,
                            ),
                            _buildTextField(
                              controller: _passwordController,
                              labelText: 'Password',
                              icon: Icons.lock,
                              obscureText: true,
                            ),
                            ValueListenableBuilder<bool>(
                              valueListenable: _rememberMe,
                              builder: (_, value, __) => Row(
                                children: [
                                  Checkbox(
                                    value: value,
                                    onChanged: (val) =>
                                        _rememberMe.value = val ?? true,
                                  ),
                                  const Text(
                                    'Remember me',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                            if (isLoading)
                              const Center(
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                              )
                            else ...[
                              CustomButton(
                                text: 'Log in',
                                onPressed: () {
                                  context.read<LoginCubit>().login(
                                        _usernameController.text.trim(),
                                        _passwordController.text.trim(),
                                        _rememberMe.value,
                                      );
                                },
                              ),
                              const SizedBox(height: 20),
                              CustomButton(
                                text: 'Sign up',
                                backgroundColor: Colors.blue,
                                onPressed: () =>
                                    Navigator.pushNamed(context, '/register'),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String labelText,
    required IconData icon,
    bool obscureText = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          labelText: labelText,
          prefixIcon: Icon(icon),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
        ),
      ),
    );
  }
}
