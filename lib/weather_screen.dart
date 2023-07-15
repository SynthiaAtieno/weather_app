import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:weather_app/key.dart';
import 'hourly_forecast_item.dart';
import 'additional_info_item.dart';
import 'package:http/http.dart' as http;

class WeatherAppScreen extends StatefulWidget {
  const WeatherAppScreen({super.key});

  @override
  State<WeatherAppScreen> createState() => _WeatherAppScreenState();
}

class _WeatherAppScreenState extends State<WeatherAppScreen> {
  Future getCurrentWeather() async {
    try {
      String cityName = "Kenya";
      final result = await http.get(
        Uri.parse(
            "https://api.openweathermap.org/data/2.5/forecast?q=$cityName,&APPID=$apiKey"),
      );

      final data = jsonDecode(result.body);

      if (int.parse(data['cod']) != 200) {
        throw 'Unexpected error occurred';
      }
      return data;
      //data['list'][0]['main']['temp'];
    } catch (e) {
      throw e.toString();
    }
  }

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
      body: FutureBuilder(
        future: getCurrentWeather(),
        builder: (context, AsyncSnapshot snapshot) {
          print(snapshot);
          print(snapshot.runtimeType);
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator.adaptive());
          }
          if (snapshot.hasError) {
            return Center(
              child: Text(
                snapshot.error.toString(),
                style: const TextStyle(color: Colors.red),
              ),
            );
          }

          return Padding(
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
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(children: [
                            Text(
                              "200 K",
                              style: const TextStyle(fontSize: 32),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Icon(
                              Icons.cloud,
                              size: 60,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Text(
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
                    HourlyForecast(
                      iconData: Icons.cloud,
                      time: "16.98",
                      value: "56.0",
                    ),
                  ]),
                ),
                const SizedBox(height: 20),
                const Text(
                  "Additional Information",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    AdditionalInfoItem(
                      icon: Icons.water_drop,
                      label: "Humidity",
                      valuetxt: 91,
                    ),
                    AdditionalInfoItem(
                      icon: Icons.water_drop,
                      label: "Wind Speed",
                      valuetxt: 7.127,
                    ),
                    AdditionalInfoItem(
                      icon: Icons.water_drop,
                      label: "Pressure",
                      valuetxt: 1000,
                    )
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
