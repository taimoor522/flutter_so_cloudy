import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:so_cloudy/data/model/weather_model.dart';
import 'package:so_cloudy/presentaion/constants/colors.dart';

class DateAndLocation extends StatelessWidget {
  Location location;

  DateAndLocation({Key? key, required this.location}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          DateFormat(" dd,MMMM yyyy").format(DateTime.now()),
          style: GoogleFonts.abel(
              textStyle: const TextStyle(
            color: kGrey,
            fontSize: 20,
          )),
        ),
        const SizedBox(height: 5),
        Row(
          children: [
            const Icon(
              Icons.location_on,
              color: kWhite,
            ),
            const SizedBox(width: 5),
            RichText(
              text: TextSpan(
                text: '${location.city}, ',
                style: GoogleFonts.abel(
                  textStyle: const TextStyle(
                    color: kWhite,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: location.country,
                    style: GoogleFonts.abel(
                      textStyle: const TextStyle(
                        color: kGrey,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
