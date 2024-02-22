import 'package:flutter/material.dart';
import 'package:minimal_weather_app/presentation/screen/home_screen.dart';

class WeatherApps extends StatelessWidget {
  const WeatherApps({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScrren(),
    );
  }
}
