import 'dart:io';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: _CounterScreen(),
    );
  }
}

class ImageFromFile extends StatelessWidget {
  final File imageFile;
  const ImageFromFile(this.imageFile, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Image.file(imageFile)));
  }
}

class _CounterScreen extends StatefulWidget {
  @override
  _CounterScreenState createState() => _CounterScreenState();
}

class _CounterScreenState extends State<_CounterScreen> {
  int _counter = 0;
  Color _textColor = Colors.black;
  final TextEditingController _controller = TextEditingController();

  void _handleInput() {
    final String input = _controller.text.trim();

    if (input == 'Maryk') {
      setState(() {
        _counter = 0;
        _textColor = Colors.red;
      });
    } else {
      final int? number = int.tryParse(input);
      setState(() {
        if (number != null) {
          _counter += number;
          _textColor = Colors.green;
        } else {
          _textColor = Colors.black;
        }
      });
    }
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Counter for your money'),
        backgroundColor: const Color(0xFF2665B6),
      ),
      backgroundColor: const Color(0xFFC1E1FF),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  'assets/capybara.jpg',
                  width: 300,
                  height: 300,
                  fit: BoxFit.cover,
                ),
              ),
              Text(
                '$_counter',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: _textColor,
                  fontSize: 45,
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _controller,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Count your cents',
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _handleInput,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 50,
                    vertical: 15,
                  ),
                  textStyle: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                child: const Text('+'),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: CircleAvatar(
                      backgroundColor: Colors.blue,
                      maxRadius: 30,
                    ),
                  ),
                  // const SizedBox(width: 20),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: CircleAvatar(
                      backgroundColor: Colors.blue,
                      maxRadius: 30,
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        maxRadius: 20,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Container(
                      width: 20,
                      height: 40,
                      decoration: const BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(90),
                          topLeft: Radius.circular(90),
                        ),
                      ),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                          width: 15,
                          height: 35,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(1000),
                              topLeft: Radius.circular(1000),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Container(
                      width: 10,
                      height: 5,
                      decoration: const BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(90),
                          topLeft: Radius.circular(90),
                        ),
                      ),
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
