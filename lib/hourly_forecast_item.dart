import 'package:flutter/material.dart';

class HourlyForecast extends StatelessWidget {
  const HourlyForecast({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 16,
      child: Container(
        width: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child: const Padding(
          padding: EdgeInsets.all(6.0),
          child: Column(
            children: [
              Text(
                "15:40",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              Icon(
                Icons.cloud,
                size: 44,
              ),
              Text(
                "300.12",
                style: TextStyle(fontWeight: FontWeight.normal),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
