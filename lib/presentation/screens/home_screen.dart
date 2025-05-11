import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:lab1/presentation/widgets/custom_button.dart';
import 'package:lab1/presentation/widgets/temperature_card.dart';
import 'package:lab1/services/connection_service.dart';
import 'package:lab1/services/mqtt_service.dart';

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
  double _brightness = 0.5;

  // void _scanTemperature() {
  //   setState(() {
  //     _currentTemperature = 36.0 + (DateTime.now().millisecond % 5) / 1.0;
  //   });
  // }

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

  late final MqttService _mqttService;

  @override
  void initState() {
    super.initState();
    _mqttService = MqttService();
    final connection = ConnectionService();

    connection.onConnectionChange.listen((statusList) {
      if (statusList.contains(ConnectivityResult.none) && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Lost Internet Connection')),
        );
      }
    });

    _mqttService.connect((data) {
      setState(() {
        _currentTemperature = double.tryParse(data) ?? _currentTemperature;
      });
    });
  }

  @override
  void dispose() {
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
                      // onPressed: _scanTemperature,
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Температура надходить з MQTT'),
                          ),
                        );
                      },
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
              const SizedBox(
                height: 30,
              ),
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
