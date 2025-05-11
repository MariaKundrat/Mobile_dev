import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lab1/presentation/widgets/custom_button.dart';
import 'package:lab1/presentation/widgets/temperature_card.dart';
import 'package:lab1/services/connection_service.dart';
import 'package:lab1/services/mqtt_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  double _currentTemperature = 36.6;
  bool _isCelsius = true;
  double _brightness = 0.5;
  late MqttService _mqttService;
  bool _isConnected = false;
  late final ConnectivityService _connectivityService;
  late final StreamSubscription<ConnectionStatus> _subscription;

  @override
  void initState() {
    super.initState();
    _mqttService = MqttService();

    _connectivityService = ConnectivityService();
    _subscription = _connectivityService.statusStream.listen((status) {
      if (status == ConnectionStatus.offline) {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('⚠️ No Internet connection')),
        );
      } else {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('✅ Connected to Internet')),
        );
      }
    });

    _mqttService.onDataReceived = (String data) {
      setState(() {
        _currentTemperature = double.tryParse(data) ?? _currentTemperature;
      });
    };

    _mqttService.connect().then((_) {
      setState(() {
        _isConnected = true;
      });
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

  void _scanTemperature() {
    if (_isConnected) {
      _mqttService.requestTemperature();
    } else {
      debugPrint('⚠️ MQTT not connected yet');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Still connecting to MQTT broker...')),
      );
    }
  }

  @override
  void dispose() {
    _subscription.cancel();
    _connectivityService.dispose();
    _mqttService.disconnect();
    super.dispose();
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
              const SizedBox(height: 30),
              Icon(
                Icons.favorite,
                size: 120,
                color: Colors.red.withAlpha((_brightness * 255).toInt()),
              ),
              const SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Center(
                    child: Text(
                      'Brightness',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueAccent,
                      ),
                    ),
                  ),
                  Slider(
                    value: _brightness,
                    min: 0.2,
                    divisions: 100,
                    label: (_brightness * 100).toInt().toString(),
                    onChanged: (value) {
                      setState(() {
                        _brightness = value;
                      });
                    },
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
