import 'package:flutter/material.dart';
import 'package:minimal_weather_app/presentation/model/weather_model.dart';
import 'package:intl/intl.dart';

class HourlyWeatherListItem extends StatelessWidget {
  final Hour? hour;

  const HourlyWeatherListItem({super.key, this.hour});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8),
      padding: EdgeInsets.all(8),
      width: 120,
      decoration: BoxDecoration(
        color: Colors.white24,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "${hour?.tempC?.round().toString() ?? ""}º",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Container(
            height: 50,
            decoration: BoxDecoration(),
            child: Image(
                image: NetworkImage("https:${hour?.condition?.icon ?? ""}")),
          ),
          Text(
            DateFormat.j().format(
              DateTime.parse(
                hour?.time ?? "",
              ),
            ),
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
