import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:so_cloudy/presentaion/constants/colors.dart';
import 'package:so_cloudy/presentaion/constants/numbers.dart';

class WeatherAdditionalInfo extends StatelessWidget {
  final int pressure;
  final double windSpeed;
  final int windDirection;
  final int humidity;
  final double uv;

  const WeatherAdditionalInfo(
      {Key? key,
      required this.pressure,
      required this.windSpeed,
      required this.windDirection,
      required this.humidity,
      required this.uv})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(
          children: [
            const Image(
              width: kAdditionalInfoIconSize,
              image: AssetImage("assets/images/windSpeed.png"),
            ),
            Text(
              '$windSpeed m/s',
              style: GoogleFonts.abel(
                  textStyle: const TextStyle(
                color: kGrey,
                fontWeight: FontWeight.bold,
                fontSize: kAdditionalInfoTextSize,
              )),
            ),
          ],
        ),
        Column(
          children: [
            const Image(
              width: kAdditionalInfoIconSize,
              image: AssetImage("assets/images/windDirection.png"),
            ),
            Text(
              "$windDirection",
              style: GoogleFonts.abel(
                  textStyle: const TextStyle(
                color: kGrey,
                fontWeight: FontWeight.bold,
                fontSize: kAdditionalInfoTextSize,
              )),
            ),
          ],
        ),
        Column(
          children: [
            const Image(
              width: kAdditionalInfoIconSize,
              image: AssetImage("assets/images/humidity.png"),
            ),
            Text(
              '$humidity %',
              style: GoogleFonts.abel(
                  textStyle: const TextStyle(
                color: kGrey,
                fontWeight: FontWeight.bold,
                fontSize: kAdditionalInfoTextSize,
              )),
            ),
          ],
        ),
        Column(
          children: [
            const Image(
              width: kAdditionalInfoIconSize,
              image: AssetImage("assets/images/pressure.png"),
            ),
            Text(
              "$pressure",
              style: GoogleFonts.abel(
                  textStyle: const TextStyle(
                color: kGrey,
                fontWeight: FontWeight.bold,
                fontSize: kAdditionalInfoTextSize,
              )),
            ),
          ],
        ),
        Column(
          children: [
            const Image(
              width: kAdditionalInfoIconSize,
              image: AssetImage("assets/images/uv.png"),
            ),
            Text(
              "$uv",
              style: GoogleFonts.abel(
                  textStyle: const TextStyle(
                color: kGrey,
                fontWeight: FontWeight.bold,
                fontSize: kAdditionalInfoTextSize,
              )),
            ),
          ],
        ),
      ],
    );
  }
}
