import 'package:flutter/material.dart';
import 'package:flutter_weather_bg_null_safety/flutter_weather_bg.dart';
import 'package:minimal_weather_app/presentation/model/weather_model.dart';
import 'package:intl/intl.dart';

class TodaysWeather extends StatelessWidget {
  final WeatherModel? weatherModel;

  const TodaysWeather({super.key, this.weatherModel});

  WeatherType getWeatherType(Current? current) {
    if (current?.isDay == 1) {
      if (current?.condition?.text == "Clear") {
        return WeatherType.sunny;
      }
    } else {
      if (current?.condition?.text == "Clear") {
        return WeatherType.sunnyNight;
      }
    }
    return WeatherType.thunder;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        WeatherBg(
          weatherType: getWeatherType(weatherModel?.current),
          width: MediaQuery.of(context).size.width,
          height: 320,
        ),
        SizedBox(
          width: double.infinity,
          height: 320,
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white10),
                child: Column(
                  children: [
                    Text(
                      weatherModel?.location?.country ?? "",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      DateFormat.yMMMMEEEEd().format(
                        DateTime.parse(
                            weatherModel?.current?.lastUpdated ?? ""),
                      ),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        color: Colors.white10,
                        shape: BoxShape.circle,
                      ),
                      child: Image(
                        image: NetworkImage(
                            "https:${weatherModel?.current?.condition?.icon ?? ""}"),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              weatherModel?.current?.tempC
                                      ?.round()
                                      .toString() ??
                                  "",
                              style: const TextStyle(
                                fontSize: 70,
                                color: Colors.yellow,
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            const Text(
                              "0",
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.yellow,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          weatherModel?.current?.condition?.text.toString() ??
                              "",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Container(
                margin: const EdgeInsets.all(8),
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: Colors.white10,
                    borderRadius: BorderRadius.circular(30)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            const Text(
                              "Feels Like",
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                            Text(
                              weatherModel?.current?.feelslikeC
                                      ?.round()
                                      .toString() ??
                                  "",
                              style: const TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            const Text(
                              "Wind",
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                            Text(
                              "${weatherModel?.current?.windKph?.round()} km/h",
                              style: const TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            const Text(
                              "humidity",
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                            Text(
                              "${weatherModel?.current?.humidity?.round().toString() ?? ""}%",
                              style: const TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            const Text(
                              "Visibility",
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                            Text(
                              "${weatherModel?.current?.visKm?.round()} km",
                              style: const TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
