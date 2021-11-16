// To parse this JSON data, do
//
//     final weatherModel = weatherModelFromMap(jsonString);

import 'dart:convert';

WeatherModel weatherModelFromMap(String str) =>
    WeatherModel.fromJson(json.decode(str));

class WeatherModel {
  WeatherModel({
    required this.location,
    required this.current,
    required this.hourly,
  });

  late final Location location;
  late final Current current;
  late final List<Current> hourly;

  factory WeatherModel.fromJson(Map<String, dynamic> json) => WeatherModel(
        location: Location(city: json['city'], country: json['country']),
        current: Current.fromJson(json["current"]),
        hourly:
            List<Current>.from(json["hourly"].map((x) => Current.fromJson(x))),
      );
}

class Location {
  String city;
  String country;

  Location({required this.city, required this.country});
}

class Current {
  Current({
    required this.dt,
    required this.temp,
    required this.pressure,
    required this.humidity,
    required this.uvi,
    required this.windSpeed,
    required this.windDeg,
    required this.weather,
  });

  final DateTime dt;
  final double temp;
  final int pressure;
  final int humidity;
  final double uvi;
  final double windSpeed;
  final int windDeg;
  final List<Weather> weather;

  factory Current.fromJson(Map<String, dynamic> json) => Current(
        dt: DateTime.fromMillisecondsSinceEpoch(json["dt"] * 1000),
        temp: json["temp"].toDouble(),
        pressure: json["pressure"],
        humidity: json["humidity"],
        uvi: json["uvi"].toDouble(),
        windSpeed: json["wind_speed"].toDouble(),
        windDeg: json["wind_deg"],
        weather:
            List<Weather>.from(json["weather"].map((x) => Weather.fromJson(x))),
      );
}

class Weather {
  Weather({
    required this.main,
    // required this.description,
    required this.icon,
  });

  final String main;
  // final String description;
  String icon;

  factory Weather.fromJson(Map<String, dynamic> json) => Weather(
        main: json["main"],
        // description: json["description"],
        icon: json["icon"],
      );
}
