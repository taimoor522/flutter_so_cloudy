import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:so_cloudy/presentaion/constants/strings.dart';

class WeatherProvider {
  Future<dynamic> getWeather(double latitude, double longitude) async {
    final url = Uri.parse(
        "https://api.openweathermap.org/data/2.5/onecall?lat=$latitude&lon=$longitude&appid=$apiKey&units=$unit");
    var response = await http.get(url);
    return jsonDecode(response.body);
  }
}
