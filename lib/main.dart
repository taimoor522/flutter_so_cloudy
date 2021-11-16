import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:so_cloudy/presentaion/screens/home_screen.dart';

import 'bloc/weather_bloc/weather_bloc_cubit.dart';
import 'data/repository/weather_repository.dart';

void main() {
  WeatherRepository weatherRepository = WeatherRepository();
  runApp(MyApp(
    weatherRepository: weatherRepository,
  ));
}

class MyApp extends StatelessWidget {
  WeatherRepository weatherRepository;
  MyApp({required this.weatherRepository});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WeatherCubit(weatherRepository: weatherRepository),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
      ),
    );
  }
}
