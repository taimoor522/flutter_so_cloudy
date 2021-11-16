import 'dart:async';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:connectivity/connectivity.dart';
import 'package:meta/meta.dart';
import 'package:so_cloudy/data/model/weather_model.dart';
import 'package:so_cloudy/data/data%20provider/position_provider.dart';
import 'package:so_cloudy/data/repository/weather_repository.dart';
import 'package:so_cloudy/exceptions/invalid_city_exception.dart';

part 'weather_bloc_state.dart';

class WeatherCubit extends Cubit<WeatherState> {
  final WeatherRepository weatherRepository;
  late StreamSubscription _internetStreamSub;
  WeatherCubit({required this.weatherRepository})
      : super(WeatherLoadingState()) {
    _internetStreamSub =
        Connectivity().onConnectivityChanged.listen((connectivityResult) {
      if (connectivityResult == ConnectivityResult.none) {
        emit(DisconnectedState());
      } else {
        getWeather(loadingAnimation: false);
      }
    });
  }

  Future<void> getWeather({bool loadingAnimation = true}) async {
    try {
      if (loadingAnimation) {
        emit(WeatherLoadingState());
      }

      final position = await PositionProvider.get();
      WeatherModel weather = await weatherRepository.getWeather(
          position.latitude, position.longitude);
      emit(WeatherLoadedState(weather: weather, isCity: false));
    } on SocketException {
      emit(WeatherLoadedState(
          weather: weatherRepository.getCachedWeather, isCity: false));
      emit(DisconnectedState());
    }
  }

  Future<void> getWeatherThroughCity(String cityName,
      {bool loadingAnimation = true}) async {
    try {
      if (loadingAnimation) {
        emit(WeatherLoadingState());
      }
      WeatherModel weather =
          await weatherRepository.getWeatherThroughCity(cityName);
      emit(WeatherLoadedState(weather: weather, isCity: true));
    } on InValidCityException {
      emit(InvalidCityState());
      emit(WeatherLoadedState(
          weather: weatherRepository.getCachedWeather, isCity: true));
    } on SocketException {
      emit(DisconnectedState());
      emit(WeatherLoadedState(
          weather: weatherRepository.getCachedWeather, isCity: true));
    }
  }

  @override
  Future<void> close() {
    _internetStreamSub.cancel();
    return super.close();
  }
}
