import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lab1/cubit/cubits/auth_cubits/auth_cubit.dart';
import 'package:lab1/presentation/screens/home_screen.dart';
import 'package:lab1/presentation/screens/login_screen.dart';
import 'package:lab1/presentation/screens/message_view_screen.dart';
import 'package:lab1/presentation/screens/profile_screen.dart';
import 'package:lab1/presentation/screens/qr_scanner_screen.dart';
import 'package:lab1/presentation/screens/register_screen.dart';
import 'package:lab1/presentation/screens/settings_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AuthCubit(),
      child: MaterialApp(
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
        home: const EntryPoint(),
        routes: {
          '/login': (context) => LoginScreen(),
          '/register': (context) => const RegisterScreen(),
          '/profile': (context) => const ProfileScreen(),
          '/home': (context) => const HomeScreen(),
          '/settings': (context) => const SettingsScreen(),
          '/scan': (context) => const QRScannerScreen(),
          '/message': (context) => const MessageViewScreen(),
        },
      ),
    );
  }
}

class EntryPoint extends StatelessWidget {
  const EntryPoint({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        if (state.isLoading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        return state.isLoggedIn ? const HomeScreen() : LoginScreen();
      },
    );
  }
}
