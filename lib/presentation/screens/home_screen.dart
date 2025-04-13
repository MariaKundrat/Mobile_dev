import 'package:flutter/material.dart';
import 'package:lab1/presentation/widgets/custom_button.dart';
import 'package:lab1/presentation/widgets/temperature_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() {
    return HomeScreenState();
  }
}

class HomeScreenState extends State<HomeScreen> {
  double _currentTemperature = 36.6;
  bool _isCelsius = true;

  void _scanTemperature() {
    setState(() {
      _currentTemperature = 36.0 + (DateTime.now().millisecond % 5) / 1.0;
    });
  }

  void _toggleTemperatureUnit() {
    setState(() {
      if (_isCelsius) {
        _currentTemperature = (_currentTemperature * 9 / 5) + 32;
      } else {
        _currentTemperature = (_currentTemperature - 32) * 5 / 9;
      }
      _isCelsius = !_isCelsius;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFE6E6),
      appBar: AppBar(
        title: const Text('Jeheart'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.pushNamed(context, '/settings');
            },
          ),
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              Navigator.pushNamed(context, '/profile');
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              TemperatureCard(
                temperature: _currentTemperature.toStringAsFixed(1),
                location: 'Home',
                unit: _isCelsius ? '°C' : '°F',
                backgroundColor: const Color(0xFFFF6B6B),
                iconData: Icons.favorite,
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: CustomButton(
                      text: 'Scan Temp',
                      backgroundColor: const Color(0xFF2665B6),
                      onPressed: _scanTemperature,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: CustomButton(
                      text: _isCelsius ? 'To Fahren' : 'To Celsius',
                      backgroundColor: Colors.pink,
                      onPressed: _toggleTemperatureUnit,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
