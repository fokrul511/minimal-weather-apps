import 'package:flutter/material.dart';
import 'package:minimal_weather_app/presentation/model/weather_model.dart';
import 'package:minimal_weather_app/presentation/service/api_service.dart';
import 'package:minimal_weather_app/presentation/widget/todays_weather.dart';

class HomeScrren extends StatefulWidget {
  const HomeScrren({super.key});

  @override
  State<HomeScrren> createState() => _HomeScrrenState();
}

class _HomeScrrenState extends State<HomeScrren> {
  ApiService apiService = ApiService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Weather Apps'),
      ),
      body: SafeArea(
        child: FutureBuilder(
          future: apiService.getWeatherData('Dhaka'),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              WeatherModel? weatherModel = snapshot.data;

              return SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    TodaysWeather(
                      weatherModel: weatherModel,
                    ),

                  ],
                ),
              );
            }
            if (snapshot.hasError) {
              return Center(
                child: Text("error"),
              );
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
