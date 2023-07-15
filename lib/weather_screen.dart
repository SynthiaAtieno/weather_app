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
  Future<Map<String, dynamic>> getCurrentWeather() async {
    try {
      String cityName = "Uganda";
      final result = await http.get(
        Uri.parse(
            "https://api.openweathermap.org/data/2.5/forecast?q=$cityName,&APPID=$apiKey"),
      );

      final data = jsonDecode(result.body);

      if (data['cod'] != "200") {
        throw 'Unexpected error occurred';
      }
      return data;
    } catch (e) {
      //String errorMessage = 'An error occurred: $e';
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
          // print(snapshot);
          // print(snapshot.runtimeType);
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

          final data = snapshot.data!;
          final currentWeatherData = data['list'][0];
          final temperature = currentWeatherData['main']['temp'];
          final currntSky = currentWeatherData['weather'][0]['main'];
          final pressure = currentWeatherData['main']['pressure'];
          final humidity = currentWeatherData['main']['humidity'];
          final windspeed = currentWeatherData['wind']['speed'];
          return SingleChildScrollView(
            child: Padding(
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
                                "$temperature K",
                                style: const TextStyle(fontSize: 32),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Icon(
                                currntSky == "Clouds" || currntSky == "Rain"
                                    ? Icons.cloud
                                    : Icons.sunny,
                                size: 60,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                currntSky,
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
                    "Hourly Forecast",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  // SingleChildScrollView(
                  //   scrollDirection: Axis.horizontal,
                  //   child: Row(children: [
                  //     HourlyForecast(
                  //       iconData: Icons.cloud,
                  //       time: "$currentWeatherData",
                  //       value: "56.0",
                  //     ),
                  //   ]),
                  // ),
                  SizedBox(
                    height: 120,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 5,
                        itemBuilder: ((context, index) {
                          final hourlyData = data['list'][index + 1];
                          final temperature = hourlyData['main']['temp'];
                          final time = hourlyData['dt'];
                          return HourlyForecast(
                              iconData: hourlyData['weather'][0]['main'] ==
                                          'Clouds' ||
                                      hourlyData['weather'][0]['main'] == 'Rain'
                                  ? Icons.cloud
                                  : Icons.sunny,
                              time: '$time',
                              value: '$temperature');
                        })),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Additional Information",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      AdditionalInfoItem(
                        icon: Icons.water_drop,
                        label: "Humidity",
                        valuetxt: "$humidity",
                      ),
                      AdditionalInfoItem(
                        icon: Icons.water_drop,
                        label: "Wind Speed",
                        valuetxt: "$windspeed",
                      ),
                      AdditionalInfoItem(
                        icon: Icons.water_drop,
                        label: "Pressure",
                        valuetxt: "$pressure",
                      )
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
