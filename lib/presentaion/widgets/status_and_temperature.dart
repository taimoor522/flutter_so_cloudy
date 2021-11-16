import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:so_cloudy/presentaion/constants/colors.dart';

class StatusAndTemperature extends StatelessWidget {
  final String status;
  final double temperature;

  const StatusAndTemperature(
      {Key? key, required this.status, required this.temperature})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(width: double.infinity),
        Text(
          status,
          style: GoogleFonts.abel(
              textStyle: const TextStyle(
                  color: kWhite, fontSize: 40, fontWeight: FontWeight.bold)),
        ),
        Text(
          '${temperature.toInt()} °C',
          style: GoogleFonts.righteous(
              textStyle: const TextStyle(
                  color: kWhite, fontSize: 60, fontWeight: FontWeight.bold)),
        ),
      ],
    );
  }
}
