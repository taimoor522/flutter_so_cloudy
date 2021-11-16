import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:so_cloudy/presentaion/constants/colors.dart';
import 'package:so_cloudy/presentaion/constants/numbers.dart';

class HourlyWeatherCard extends StatelessWidget {
  final String iconCode;
  final DateTime time;
  final double temperature;

  const HourlyWeatherCard(
      {Key? key,
      required this.iconCode,
      required this.time,
      required this.temperature})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
          height: 130,
          width: 90,
          margin: const EdgeInsets.all(5),
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: kWhite.withOpacity(0.15),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image(
                width: 50,
                image: AssetImage("assets/images/mainIcon/$iconCode.png"),
              ),
              Text(
                DateFormat("hh : mm a").format(time),
                style: const TextStyle(
                  color: kWhite,
                  fontSize: kHourlyWeatherCardDateTextSize,
                ),
              ),
              Text(
                '${temperature.toInt()} °C',
                style: GoogleFonts.abel(
                  textStyle: const TextStyle(
                      color: kWhite,
                      fontSize: kHourlyWeatherCardTemperatureTextSize,
                      fontWeight: FontWeight.bold),
                ),
              )
            ],
          )),
    );
  }
}
