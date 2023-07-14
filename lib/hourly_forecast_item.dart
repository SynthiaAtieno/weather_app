import 'package:flutter/material.dart';

class HourlyForecast extends StatelessWidget {
  final String time;
  final String value;
  final IconData iconData;
  const HourlyForecast({ required this.iconData, required this.time, required this.value,super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 16,
      child: Container(
        width: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child:  Padding(
          padding: const EdgeInsets.all(6.0),
          child: Column(
            children: [
              Text(
               time,
                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              Icon(
                iconData,
                size: 44,
              ),
              Text(
                value,
                style: const TextStyle(fontWeight: FontWeight.normal),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
