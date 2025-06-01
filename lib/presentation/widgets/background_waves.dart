import 'package:flutter/material.dart';
import 'package:lab1/presentation/widgets/topwave_clipper.dart';

class BackgroundWaves extends StatelessWidget {
  const BackgroundWaves({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
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
                height: 300, color: const Color.fromRGBO(255, 255, 255, 0.2),),
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: ClipPath(
            clipper: BottomWaveClipper(),
            child: Container(
                height: 250, color: const Color.fromRGBO(255, 255, 255, 0.15),),
          ),
        ),
      ],
    );
  }
}
