import 'package:flutter/material.dart';

import 'package:lab1/screens/home_screen.dart';
import 'package:lab1/screens/login_screen.dart';
import 'package:lab1/screens/profile_screen.dart';
import 'package:lab1/screens/register_screen.dart';
import 'package:lab1/screens/settings_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFF2665B6),
        scaffoldBackgroundColor: const Color(0xFFF5F5F5),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF2665B6),
          primary: const Color(0xFF2665B6),
          secondary: const Color(0xFFC1E1FF),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF2665B6),
          foregroundColor: Colors.white,
          elevation: 0,
        ),
      ),
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        '/profile': (context) => const ProfileScreen(),
        '/home': (context) => const HomeScreen(),
        '/settings': (context) => const SettingsScreen(),
      },
    );
  }
}
