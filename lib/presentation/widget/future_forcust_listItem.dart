import 'package:flutter/material.dart';
import 'package:minimal_weather_app/presentation/model/weather_model.dart';
import 'package:intl/intl.dart';

class ForcustFutureListItem extends StatelessWidget {
  final Forecastday? forecastday;

  const ForcustFutureListItem({super.key, this.forecastday});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8),
      padding: EdgeInsets.all(8),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white24,
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(

          children: [
            Image(
              image: NetworkImage(
                  "https:${forecastday?.day?.condition?.icon ?? ""}"),
            ),
            SizedBox(width: 10,),
            Text(
              DateFormat.MMMMd().format(
                DateTime.parse(forecastday?.date ?? ""),
              ),
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(width: 30,),
            Text(
              forecastday?.day?.condition?.text.toString() ?? "",
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(width: 50,),
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Text(
                "^${forecastday?.day?.maxtempC?.round()}/${forecastday?.day?.mintempC?.round()}",
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            )
          ],
        ),
      ),
    );
  }
}
