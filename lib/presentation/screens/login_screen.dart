import 'package:flutter/material.dart';
import 'package:lab1/logic/login_logic.dart';
import 'package:lab1/presentation/widgets/custom_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _rememberMe = true;

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
    final savedUsername = await LoginLogic.getSavedUsername();
    if (savedUsername != null) {
      setState(() => _usernameController.text = savedUsername);
    }
  }

  Future<void> _checkAutoLogin() async {
    if (await LoginLogic.isLoggedIn()) {
      final success = await LoginLogic.loginWithSavedCredentials();
      if (success && mounted) Navigator.pushReplacementNamed(context, '/home');
    }
  }

  void _login() async {
    final username = _usernameController.text.trim();
    final password = _passwordController.text.trim();

    if (username.isEmpty || password.isEmpty) {
      _showErrorDialog('Please enter both username and password');
      return;
    }

    final savedUsername = await LoginLogic.getSavedUsername();
    if (savedUsername == null) {
      await LoginLogic.saveCredentials(username, password);
      await LoginLogic.setLoggedIn(true);
      if (mounted) Navigator.pushReplacementNamed(context, '/home');
    } else {
      final isValid = await LoginLogic.validateCredentials(username, password);
      if (isValid) {
        await LoginLogic.setLoggedIn(true);
        if (mounted) Navigator.pushReplacementNamed(context, '/home');
      } else {
        _showErrorDialog('Invalid username or password');
      }
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
                      labelText: 'Username',
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
                    CustomButton(text: 'Log in', onPressed: _login),
                    CustomButton(
                      text: 'Sign up',
                      backgroundColor: Colors.blue,
                      onPressed: () =>
                          Navigator.pushNamed(context, '/register'),
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
