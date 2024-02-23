import 'package:flutter/material.dart';
import 'package:minimal_weather_app/presentation/model/weather_model.dart';
import 'package:minimal_weather_app/presentation/service/api_service.dart';
import 'package:minimal_weather_app/presentation/widget/todays_weather.dart';

import '../widget/future_forcust_listItem.dart';
import '../widget/hourly_weather_listItem.dart';

class HomeScrren extends StatefulWidget {
  const HomeScrren({super.key});

  @override
  State<HomeScrren> createState() => _HomeScrrenState();
}

class _HomeScrrenState extends State<HomeScrren> {
  ApiService apiService = ApiService();

  final TextEditingController _textEditingController = TextEditingController();

  String searchText = "auto:ip";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.purple,
        elevation: 0,
        title: const Text('Flutter Weather Apps'),
        actions: [
          IconButton(
              onPressed: () async {
                String text = await _showTextInput(context);

                setState(() {
                  searchText = text;
                });
              },
              icon: Icon(Icons.search)),
          IconButton(
              onPressed: () {
                searchText = "auto:ip";
                setState(() {});
              },
              icon: Icon(Icons.my_location)),
        ],
      ),
      body: SafeArea(
        child: FutureBuilder(
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
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      "Weather by Hours",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 150,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: weatherModel
                            ?.forecast?.forecastday?[0].hour?.length,
                        itemBuilder: (context, index) {
                          Hour? hour = weatherModel
                              ?.forecast?.forecastday![0].hour?[index];
                          return HourlyWeatherListItem(
                            hour: hour,
                          );
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      "Next 7 Days Weather",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: weatherModel?.forecast?.forecastday?.length,
                        itemBuilder: (context, index) {
                          Forecastday? forcastDay =
                              weatherModel?.forecast?.forecastday?[index];
                          return ForcustFutureListItem(
                            forecastday: forcastDay,
                          );
                        },
                      ),
                    )
                  ],
                ),
              );
            }
            if (snapshot.hasError) {
              return const Center(
                child: Text("error"),
              );
            }
            return const Center(child: CircularProgressIndicator());
          },
          future: apiService.getWeatherData(searchText),
        ),
      ),
    );
  }

  _showTextInput(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Search Location"),
          content: TextField(
            controller: _textEditingController,
            decoration: InputDecoration(
              hintText: 'search by city name',
            ),
          ),
          actions: [
            ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Cancel')),
            ElevatedButton(
                onPressed: () {
                  if (_textEditingController.text.isEmpty) {
                    return;
                  }

                  Navigator.pop(context, _textEditingController.text);
                  _textEditingController.clear();
                },
                child: Text('ok')),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }
}
