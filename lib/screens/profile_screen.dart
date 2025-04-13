import 'package:flutter/material.dart';
import 'package:lab1/services/auth_service.dart';
import 'package:lab1/widgets/custom_button.dart';
import 'package:lab1/widgets/topwave_clipper.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Profile'),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF009FFD), Color(0xFF2A2A72)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: ClipPath(
              clipper: TopWaveClipper(),
              child: Container(
                height: 300,
                color: const Color.fromRGBO(255, 255, 255, 0.2),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: ClipPath(
              clipper: BottomWaveClipper(),
              child: Container(
                height: 250,
                color: const Color.fromRGBO(255, 255, 255, 0.15),
              ),
            ),
          ),
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: GlassContainer(
                  padding: const EdgeInsets.all(20),
                  borderRadius: 20,
                  child: Column(
                    children: [
                      const CircleAvatar(
                        radius: 60,
                        backgroundColor: Color(0xFFC1E1FF),
                        child: Icon(
                          Icons.person,
                          size: 60,
                          color: Color(0xFF2665B6),
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Maryk',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const Text(
                        'maryk@gmail.com',
                        style: TextStyle(fontSize: 16, color: Colors.white70),
                      ),
                      const SizedBox(height: 30),
                      const _ProfileInfoItem(
                        icon: Icons.account_balance,
                        title: 'Account',
                        subtitle: 'Personal details',
                      ),
                      const Divider(color: Colors.white54),
                      const _ProfileInfoItem(
                        icon: Icons.settings,
                        title: 'Settings',
                        subtitle: 'App settings, notifications',
                      ),
                      const Divider(color: Colors.white54),
                      const _ProfileInfoItem(
                        icon: Icons.insights,
                        title: 'Statistics',
                        subtitle: 'Spending analysis, crashers',
                      ),
                      const Divider(color: Colors.white54),
                      const _ProfileInfoItem(
                        icon: Icons.help,
                        title: 'Help Center',
                        subtitle: 'FAQ, contact support',
                      ),
                      const SizedBox(height: 40),
                      CustomButton(
                        text: 'Log Out',
                        backgroundColor: Colors.lightGreen,
                        onPressed: () {
                          AuthService.logout();
                          Navigator.pushReplacementNamed(context, '/login');
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ProfileInfoItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const _ProfileInfoItem({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: const Color.fromRGBO(255, 255, 255, 0.3),
        child: Icon(icon, color: Colors.white),
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      subtitle: Text(subtitle, style: const TextStyle(color: Colors.white70)),
      trailing: const Icon(
        Icons.arrow_forward_ios,
        size: 16,
        color: Colors.white70,
      ),
      onTap: () {},
    );
  }
}
