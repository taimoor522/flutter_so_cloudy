part of 'weather_bloc_cubit.dart';

@immutable
abstract class WeatherState {}

class WeatherLoadingState extends WeatherState {}

class WeatherLoadedState extends WeatherState {
  final WeatherModel weather;
  final isCity;

  WeatherLoadedState({required this.weather, required this.isCity});
}

class DisconnectedState extends WeatherState {}

class InvalidCityState extends WeatherState {}
