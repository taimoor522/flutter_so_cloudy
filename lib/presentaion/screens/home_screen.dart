import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:so_cloudy/bloc/weather_bloc/weather_bloc_cubit.dart';
import 'package:so_cloudy/data/model/weather_model.dart';
import 'package:so_cloudy/presentaion/constants/colors.dart';
import 'package:so_cloudy/presentaion/widgets/current_weather_icon.dart';
import 'package:so_cloudy/presentaion/widgets/data_and_location.dart';
import 'package:so_cloudy/presentaion/widgets/hourly_weather.dart';
import 'package:so_cloudy/presentaion/widgets/status_and_temperature.dart';
import 'package:so_cloudy/presentaion/widgets/weather_additional_info.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController controller = TextEditingController();
  late String cachedCityName;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<WeatherCubit>(context).getWeather();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SafeArea(
            child: BlocConsumer<WeatherCubit, WeatherState>(
              bloc: BlocProvider.of<WeatherCubit>(context),
              builder: (context, weatherState) {
                if (weatherState is WeatherLoadedState) {
                  return _showWeather(
                      weatherState.weather, weatherState.isCity);
                } else if (weatherState is WeatherLoadingState) {
                  return const Center(
                    child: CircularProgressIndicator(
                      backgroundColor: kDarkGrey,
                      color: kGrey,
                    ),
                  );
                }
                return Container();
              },
              buildWhen: (previousState, currentState) {
                if (currentState is DisconnectedState) return false;
                return true;
              },
              listenWhen: (p, c) {
                if (c is DisconnectedState)
                  return true;
                else if (c is InvalidCityState) return true;
                return false;
              },
              listener: (context, weatherState) {
                if (weatherState is DisconnectedState) {
                  const snackBar = SnackBar(
                    dismissDirection: DismissDirection.horizontal,
                    duration: Duration(seconds: 1),
                    content: Text('Disconnected',
                        style: TextStyle(
                          color: kWhite,
                          fontSize: 20,
                        ),
                        textAlign: TextAlign.center),
                    backgroundColor: Colors.red,
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
                if (weatherState is InvalidCityState) {
                  const snackBar = SnackBar(
                    dismissDirection: DismissDirection.horizontal,
                    duration: Duration(seconds: 1),
                    content: Text('Invalid City',
                        style: TextStyle(
                          color: kWhite,
                          fontSize: 20,
                        ),
                        textAlign: TextAlign.center),
                    backgroundColor: Colors.red,
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
              },
            ),
          )),
    );
  }

  Widget _buildInputField(controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: TextField(
        controller: controller,
        style: const TextStyle(color: kWhite),
        cursorColor: kWhite,
        decoration: InputDecoration(
          hintText: 'Enter City',
          hintStyle: const TextStyle(color: kGrey),
          filled: true,
          fillColor: kDarkGrey,
          suffixIcon: IconButton(
              onPressed: () => controller.clear(),
              icon: const Icon(Icons.close, color: kGrey)),
          contentPadding: const EdgeInsets.all(10),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(32.0)),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: kDarkGrey, width: 1.0),
            borderRadius: BorderRadius.all(Radius.circular(32.0)),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: kGrey, width: 1.0),
            borderRadius: BorderRadius.all(Radius.circular(32.0)),
          ),
        ),
        onSubmitted: (cityName) {
          if (cityName.isNotEmpty) {
            cachedCityName = cityName;
            BlocProvider.of<WeatherCubit>(context)
                .getWeatherThroughCity(cityName);
            controller.clear();
          }
        },
      ),
    );
  }

  Widget _showWeather(WeatherModel weather, bool isCity) {
    return LiquidPullToRefresh(
      color: Colors.black,
      backgroundColor: kWhite,
      showChildOpacityTransition: false,
      onRefresh: isCity
          ? () async {
              await BlocProvider.of<WeatherCubit>(context)
                  .getWeatherThroughCity(cachedCityName,
                      loadingAnimation: false);
            }
          : () async {
              await BlocProvider.of<WeatherCubit>(context)
                  .getWeather(loadingAnimation: false);
            },
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Container(
          height: MediaQuery.of(context).size.height - 30,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                "assets/images/background.jpg",
              ),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(child: _buildInputField(controller)),
                  if (isCity)
                    TextButton(
                      style: ButtonStyle(
                          minimumSize:
                              MaterialStateProperty.all<Size>(Size.zero),
                          backgroundColor:
                              MaterialStateProperty.all<Color>(kWhite),
                          padding:
                              MaterialStateProperty.all<EdgeInsetsGeometry>(
                                  const EdgeInsets.symmetric(
                                      vertical: 8, horizontal: 8)),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                      side: const BorderSide(
                                          width: 2, color: kWhite)))),
                      child: const Icon(
                        Icons.location_on,
                        size: 30,
                        color: kDarkGrey,
                      ),
                      onPressed:
                          BlocProvider.of<WeatherCubit>(context).getWeather,
                    )
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: DateAndLocation(
                  location: weather.location,
                ),
              ),
              const SizedBox(height: 10),
              CurrentWeatherIcon(iconCode: weather.current.weather[0].icon),
              const SizedBox(height: 20),
              StatusAndTemperature(
                status: weather.current.weather[0].main,
                temperature: weather.current.temp,
              ),
              const SizedBox(height: 30),
              WeatherAdditionalInfo(
                uv: weather.current.uvi,
                windSpeed: weather.current.windSpeed,
                humidity: weather.current.humidity,
                windDirection: weather.current.windDeg,
                pressure: weather.current.pressure,
              ),
              const SizedBox(height: 20),
              HourlyWeather(hourlyWeatherData: weather.hourly),
              const SizedBox(height: 5),
            ],
          ),
        ),
      ),
    );
  }
}
