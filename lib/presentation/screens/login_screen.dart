import 'package:flutter/material.dart';
import 'package:lab1/presentation/widgets/custom_button.dart';
import 'package:lab1/services/auth_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _rememberMe = true;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _checkAutoLogin();
    _loadSavedUsername();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _loadSavedUsername() async {
    final savedUsername = await AuthService.getUsername();
    if (savedUsername != null) {
      setState(() => _usernameController.text = savedUsername);
    }
  }

  Future<void> _checkAutoLogin() async {
    if (await AuthService.isUserLoggedIn()) {
      setState(() => _isLoading = true);
      final success = await AuthService.loginWithSavedCredentials();
      setState(() => _isLoading = false);
      if (success && mounted) {
        Navigator.pushReplacementNamed(context, '/home');
      }
    }
  }

  Future<void> _login() async {
    final username = _usernameController.text.trim();
    final password = _passwordController.text.trim();

    if (username.isEmpty || password.isEmpty) {
      _showErrorDialog('Please enter both username and password');
      return;
    }

    setState(() => _isLoading = true);

    try {
      final savedUsername = await AuthService.getUsername();

      if (savedUsername == null) {
        await AuthService.saveCredentials(username, password);
        await AuthService.setLoggedIn(_rememberMe);
        if (mounted) {
          Navigator.pushReplacementNamed(context, '/home');
        }
      } else {
        final isValid =
            await AuthService.validateCredentials(username, password);
        if (isValid) {
          await AuthService.setLoggedIn(_rememberMe);
          if (mounted) {
            Navigator.pushReplacementNamed(context, '/home');
          }
        } else {
          _showErrorDialog('Invalid username or password');
        }
      }
    } catch (e) {
      _showErrorDialog('Login error: $e');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _showErrorDialog(String message) {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
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
                    Row(
                      children: [
                        Checkbox(
                          value: _rememberMe,
                          onChanged: (value) =>
                              setState(() => _rememberMe = value ?? true),
                          fillColor: WidgetStateProperty.all(Colors.lightBlue),
                        ),
                        const Text(
                          'Remember me',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                    _isLoading
                        ? const Center(
                            child:
                                CircularProgressIndicator(color: Colors.white),
                          )
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              CustomButton(text: 'Log in', onPressed: _login),
                              CustomButton(
                                text: 'Sign up',
                                backgroundColor: Colors.blue,
                                onPressed: () =>
                                    Navigator.pushNamed(context, '/register'),
                              ),
                            ],
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
