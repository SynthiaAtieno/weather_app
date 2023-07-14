import 'package:flutter/material.dart';

void main() {
  runApp(const WeatherApp());
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(useMaterial3: true).copyWith(
          appBarTheme: const AppBarTheme(backgroundColor: Colors.black38),
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.black)),
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Weather App",
            style: TextStyle(color: Colors.amber),
          ),
          centerTitle: true,
        ),
      ),
    );
  }
}
