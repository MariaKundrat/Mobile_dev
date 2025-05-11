import 'package:flutter/material.dart';
import 'package:lab1/domain/entities/user.dart';
import 'package:lab1/presentation/widgets/custom_button.dart';
import 'package:lab1/presentation/widgets/profile_info_item.dart';
import 'package:lab1/presentation/widgets/topwave_clipper.dart';
import 'package:lab1/services/auth_service.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  ProfileScreenState createState() => ProfileScreenState();
}

class ProfileScreenState extends State<ProfileScreen> {
  User? _user;
  bool _isLoading = true;
  bool _isEditing = false;

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _loadUserData() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final user = await AuthService.getCurrentUser();
      if (!mounted) return;
      setState(() {
        _user = user;
        if (user != null) {
          _nameController.text = user.name;
          _emailController.text = user.email;
        }
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error loading user data: $e')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _updateUserData() async {
    final currentUser = _user;
    if (currentUser == null) return;

    setState(() {
      _isLoading = true;
    });

    try {
      final updatedUser = User(
        email: _emailController.text.trim(),
        name: _nameController.text.trim(),
        password: currentUser.password,
      );

      await AuthService.updateUser(updatedUser);
      if (!mounted) return;

      setState(() {
        _user = updatedUser;
        _isEditing = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profile updated successfully')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error updating profile: $e')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Widget _buildUserInfo() {
    final currentUser = _user;

    if (currentUser == null) {
      return const Text(
        'No user data available',
        style: TextStyle(color: Colors.white),
      );
    }

    if (_isEditing) {
      return Column(
        children: [
          TextField(
            controller: _nameController,
            decoration: const InputDecoration(
              labelText: 'Name',
              labelStyle: TextStyle(color: Colors.white),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white54),
              ),
            ),
            style: const TextStyle(color: Colors.white),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _emailController,
            decoration: const InputDecoration(
              labelText: 'Email',
              labelStyle: TextStyle(color: Colors.white),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white54),
              ),
            ),
            style: const TextStyle(color: Colors.white),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _isEditing = false;
                    _nameController.text = currentUser.name;
                    _emailController.text = currentUser.email;
                  });
                },
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: _updateUserData,
                child: const Text('Save'),
              ),
            ],
          ),
        ],
      );
    } else {
      return Column(
        children: [
          Text(
            currentUser.name,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Text(
            currentUser.email,
            style: const TextStyle(fontSize: 16, color: Colors.white70),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _isEditing = true;
              });
            },
            child: const Text('Edit Profile'),
          ),
        ],
      );
    }
  }

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
          if (!_isLoading)
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
          if (!_isLoading)
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
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : Center(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(16),
                      child: Card(
                        color: Colors.transparent,
                        elevation: 0,
                        child: Padding(
                          padding: const EdgeInsets.all(20),
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
                              _buildUserInfo(),
                              const SizedBox(height: 30),
                              if (!_isEditing) ...[
                                const ProfileInfoItem(
                                  icon: Icons.account_balance,
                                  title: 'Account',
                                  subtitle: 'Personal details',
                                ),
                                const Divider(color: Colors.white54),
                                const ProfileInfoItem(
                                  icon: Icons.settings,
                                  title: 'Settings',
                                  subtitle: 'App settings, notifications',
                                ),
                                const Divider(color: Colors.white54),
                                const ProfileInfoItem(
                                  icon: Icons.help,
                                  title: 'Help Center',
                                  subtitle: 'FAQ, contact support',
                                ),
                              ],
                              const SizedBox(height: 40),
                              if (!_isEditing)
                                CustomButton(
                                  text: 'Log Out',
                                  backgroundColor: Colors.lightGreen,
                                  onPressed: () async {
                                    final shouldLogout = await showDialog<bool>(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: const Text('Confirm Logout'),
                                          content: const Text(
                                            'Are you sure you want to log '
                                            'out?',
                                          ),
                                          actions: [
                                            TextButton(
                                              onPressed: () {
                                                Navigator.of(context)
                                                    .pop(false);
                                              },
                                              child: const Text('Cancel'),
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pop(true);
                                              },
                                              child: const Text('Logout'),
                                            ),
                                          ],
                                        );
                                      },
                                    );

                                    if (shouldLogout == true) {
                                      await AuthService.logout();
                                      if (!mounted) return;
                                      Navigator.pushReplacementNamed(
                                        // ignore: use_build_context_synchronously
                                        context, '/login',
                                      );
                                    }
                                  },
                                ),
                            ],
                          ),
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
