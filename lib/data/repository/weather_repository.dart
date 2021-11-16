import 'dart:async';
import 'dart:convert';
import 'package:so_cloudy/data/data%20provider/location_name_provider.dart';
import 'package:so_cloudy/data/data%20provider/weather_provider.dart';
import 'package:so_cloudy/data/model/weather_model.dart';
import 'package:http/http.dart' as http;
import 'package:so_cloudy/exceptions/invalid_city_exception.dart';
import 'package:so_cloudy/presentaion/constants/strings.dart';

class WeatherRepository {
  late WeatherModel _cachedWeatherData;

  Future<WeatherModel> getWeather(double latitude, double longitude) async {
    var rawWeather = await WeatherProvider().getWeather(latitude, longitude);
    var rawLocationName =
        await LocationNameProvider().getLocationName(latitude, longitude);
    var weather = WeatherModel.fromJson({...rawWeather, ...rawLocationName});
    _updateWeatherModel(weather);
    _cachedWeatherData = weather;
    return weather;
  }

  WeatherModel get getCachedWeather => _cachedWeatherData;

  Future<WeatherModel> getWeatherThroughCity(String cityName) async {
    final url = Uri.parse(
        "https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$apiKey");
    var response = await http.get(url);
    if (response.statusCode == 404) throw InValidCityException();
    var rawWeather = jsonDecode(response.body);
    double lat = rawWeather['coord']['lat'];
    double lon = rawWeather['coord']['lon'];
    return getWeather(lat, lon);
  }

  String _mapIconCode(String iconCode) {
    print("current icon code : $iconCode");

    if (['03d', '03n', '04d', '04n'].contains(iconCode)) {
      return "cloud";
    } else if (['09d', '09n', '10d', '10n'].contains(iconCode)) {
      return "rain";
    } else if (['11d', '11n'].contains(iconCode)) {
      return "thunder";
    } else if (['13d', '13n'].contains(iconCode)) {
      return "snow";
    }
    return iconCode;
  }

  void _updateWeatherModel(WeatherModel weather) {
    weather.current.weather[0].icon =
        _mapIconCode(weather.current.weather[0].icon);
    for (var hourlyWeather in weather.hourly) {
      hourlyWeather.weather[0].icon =
          _mapIconCode(hourlyWeather.weather[0].icon);
    }
    weather.hourly
      ..remove(weather.hourly.first)
      ..removeRange(11, weather.hourly.length - 1);
  }
}
