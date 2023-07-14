import 'dart:ui';

import 'package:flutter/material.dart';
import 'hourly_forecast_item.dart';
import 'additional_info_item.dart';

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
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.refresh,
              color: Colors.white,
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: double.infinity,
              child: Card(
                elevation: 16,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                    child: const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(children: [
                        Text(
                          "300.6°F",
                          style: TextStyle(fontSize: 32),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Icon(
                          Icons.cloud,
                          size: 60,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Rain",
                          style: TextStyle(fontSize: 16),
                        ),
                      ]),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "Weather Forecast",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            const SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(children: [
                HourlyForecast(),
                HourlyForecast(),
                HourlyForecast(),
                HourlyForecast(),
                HourlyForecast(),
                HourlyForecast(),
                HourlyForecast(),
                HourlyForecast(),
                HourlyForecast(),
              ]),
            ),
            const SizedBox(height: 20),
            const Text(
              "Additional Information",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const Row(
              children: [
                AdditionalInfoItem(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}