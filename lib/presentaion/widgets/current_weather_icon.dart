import 'package:flutter/material.dart';

class CurrentWeatherIcon extends StatelessWidget {
  final String iconCode;

  const CurrentWeatherIcon({Key? key, required this.iconCode})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        width: double.infinity,
        child: Image(
          image: AssetImage("assets/images/mainIcon/$iconCode.png"),
        ),
      ),
    );
  }
}
