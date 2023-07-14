import 'package:flutter/material.dart';

class WeatherAppScreen extends StatelessWidget {
  const WeatherAppScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: const Text(
          "Weather App",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        actions: [
          GestureDetector(
            child: const Icon(
              Icons.refresh,
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }
}
