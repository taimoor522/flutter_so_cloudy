import 'package:flutter/material.dart';
import 'hourly_weather_card.dart';

class HourlyWeather extends StatelessWidget {
  final List<dynamic> hourlyWeatherData;

  HourlyWeather({Key? key, required this.hourlyWeatherData}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: hourlyWeatherData
            .map((hourlyData) => HourlyWeatherCard(
                iconCode: hourlyData.weather[0].icon,
                time: hourlyData.dt,
                temperature: hourlyData.temp))
            .toList(),
      ),
    );
  }
}
