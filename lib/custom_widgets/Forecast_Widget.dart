import 'package:flutter/material.dart';
import 'package:weatherapp/data_access/weather_conditions.dart';

class ForecastWidget extends StatefulWidget {
  const ForecastWidget({super.key, required this.foreCastDataJson});
  final Map<dynamic, dynamic> foreCastDataJson;

  @override
  _ForecastWidgetState createState() => _ForecastWidgetState();
}

class _ForecastWidgetState extends State<ForecastWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 20, right: 20),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.8,
      child: PageView.builder(
        itemCount: widget.foreCastDataJson['forecast']['forecastday'].length,
        itemBuilder: (context, index) {
          var forecastData =
              widget.foreCastDataJson['forecast']['forecastday'][index];
          var date = forecastData['date'];
          var dayConditionCode = forecastData['day']['condition']['code'];
          var dayTemp = forecastData['day']['avgtemp_c'];
          var conditionText = forecastData['day']['condition']['text'];

          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Forecast",
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 18, 18, 18),
                      letterSpacing: 2,
                    ),
                  ),
                  Text(
                    date,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 125, 125, 125),
                      letterSpacing: 2,
                    ),
                  ),
                  // Assuming location data is the same for all forecast days
                  Text(
                    widget.foreCastDataJson['location']['region'],
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
                      getWeatherImageUrl(dayConditionCode),
                      height: MediaQuery.of(context).size.height * 0.3,
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                  Text(
                    '$dayTemp°C',
                    style: const TextStyle(
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 4, 4, 12),
                    ),
                  ),
                  Text(
                    conditionText,
                    style: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 123, 122, 121),
                    ),
                  ),
                ],
              ),
            ],
          );
        },
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
