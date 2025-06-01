import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lab1/cubit/home/home_cubit.dart';
import 'package:lab1/cubit/home/home_state.dart';
import 'package:lab1/presentation/screens/message_view_screen.dart';
import 'package:lab1/presentation/screens/qr_scanner_screen.dart';
import 'package:lab1/presentation/widgets/custom_button.dart';
import 'package:lab1/presentation/widgets/temperature_card.dart';
import 'package:lab1/services/connection_service.dart';
import 'package:lab1/services/mqtt_service.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeCubit(
        mqttService: MqttService(),
        connectivityService: ConnectivityService(),
      ),
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          final cubit = context.read<HomeCubit>();

          return Scaffold(
            backgroundColor: const Color(0xFFFFE6E6),
            appBar: AppBar(
              title: const Text('Jeheart'),
              actions: [
                IconButton(
                  icon: const Icon(Icons.settings),
                  onPressed: () => Navigator.pushNamed(context, '/settings'),
                ),
                IconButton(
                  icon: const Icon(Icons.person),
                  onPressed: () => Navigator.pushNamed(context, '/profile'),
                ),
              ],
            ),
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    TemperatureCard(
                      temperature: state.temperature.toStringAsFixed(1),
                      location: 'Home',
                      unit: state.isCelsius ? '°C' : '°F',
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
                            onPressed: cubit.scanTemperature,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: CustomButton(
                            text: state.isCelsius ? 'To Fahren' : 'To Celsius',
                            backgroundColor: Colors.pink,
                            onPressed: cubit.toggleUnit,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    Row(
                      children: [
                        Expanded(
                          child: CustomButton(
                            text: 'Open Camera',
                            backgroundColor: Colors.green,
                            onPressed: () {
                              Navigator.push<void>(
                                context,
                                MaterialPageRoute<void>(
                                  builder: (_) => const QRScannerScreen(),
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: CustomButton(
                            text: 'View Last Message',
                            backgroundColor: Colors.orange,
                            onPressed: () {
                              Navigator.push<void>(
                                context,
                                MaterialPageRoute<void>(
                                  builder: (_) => const MessageViewScreen(),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    Icon(
                      Icons.favorite,
                      size: 120,
                      color: Colors.red
                          .withAlpha((state.brightness * 255).toInt()),
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
                          value: state.brightness,
                          min: 0.2,
                          divisions: 100,
                          label: (state.brightness * 100).toInt().toString(),
                          onChanged: cubit.changeBrightness,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
