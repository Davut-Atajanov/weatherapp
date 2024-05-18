import 'package:flutter/material.dart';
import 'package:weatherapp/data_access/weather_conditions.dart';

class WeatherWidget extends StatefulWidget {
  const WeatherWidget({super.key, required this.locationDataJson});
  final Map<dynamic, dynamic> locationDataJson;

  @override
  _WeatherWidgetState createState() => _WeatherWidgetState();
}

class _WeatherWidgetState extends State<WeatherWidget> {
  var currentDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 20, right: 20),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.9,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                currentDate.toString().substring(0, 10),
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 125, 125, 125),
                  letterSpacing: 2,
                ),
              ),
              Text(
                widget.locationDataJson['location']['region'],
                style: const TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 4, 4, 12)),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.zero,
                child: Image.asset(
                  getWeatherImageUrl(
                      widget.locationDataJson['current']['condition']['code']),
                  height: MediaQuery.of(context).size.height * 0.3,
                  fit: BoxFit.fitHeight,
                ),
              ),
              Text(
                '${widget.locationDataJson['current']['temp_c']}°C',
                style: const TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 4, 4, 12),
                ),
              ),
              Text(
                widget.locationDataJson['current']['condition']['text'],
                style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 123, 122, 121),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String getWeatherImageUrl(int code) {
    for (var category in weatherCategories) {
      if (category['codes'].contains(code)) {
        return category['image_url'];
      }
    }
    return 'assets/images/default.png';
  }
}
