import 'package:flutter/material.dart';

class TemperatureCard extends StatelessWidget {
  final String temperature;
  final String location;
  final String unit;
  final Color? backgroundColor;
  final IconData? iconData;

  const TemperatureCard({
    required this.temperature,
    required this.location,
    this.unit = '°C',
    this.backgroundColor,
    this.iconData,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: backgroundColor ?? Colors.lightBlue,
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(
          colors: [
            (backgroundColor ?? Colors.lightBlue).withOpacity(0.7),
            (backgroundColor ?? Colors.lightBlue),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                location,
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 16,
                ),
              ),
              if (iconData != null)
                Icon(
                  iconData,
                  color: Colors.white.withOpacity(0.7),
                  size: 30,
                ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                temperature,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                unit,
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 28,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
