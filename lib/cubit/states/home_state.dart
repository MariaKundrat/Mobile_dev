import 'package:equatable/equatable.dart';

class HomeState extends Equatable {
  final double temperature;
  final bool isCelsius;
  final double brightness;
  final bool isConnected;

  const HomeState({
    required this.temperature,
    required this.isCelsius,
    required this.brightness,
    required this.isConnected,
  });

  HomeState copyWith({
    double? temperature,
    bool? isCelsius,
    double? brightness,
    bool? isConnected,
  }) {
    return HomeState(
      temperature: temperature ?? this.temperature,
      isCelsius: isCelsius ?? this.isCelsius,
      brightness: brightness ?? this.brightness,
      isConnected: isConnected ?? this.isConnected,
    );
  }

  @override
  List<Object> get props => [temperature, isCelsius, brightness, isConnected];
}
