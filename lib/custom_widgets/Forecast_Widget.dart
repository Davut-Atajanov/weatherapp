import 'package:flutter/material.dart';

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
      alignment: Alignment.center,
      width: MediaQuery.of(context).size.width * 0.9,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.black.withOpacity(0.5),
      ),
      child: ListView(
        shrinkWrap: true,
        physics: const ScrollPhysics(),
        children: widget.foreCastDataJson['forecast']["forecastday"]
            .map<Widget>((day) {
          return Column(
            children: [
              Text(
                day['date'],
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.amber,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Image.network(
                        day['day']['condition']['icon'],
                      ),
                      Text(
                        day['day']['condition']['text'],
                        style: const TextStyle(
                          fontSize: 15,
                          color: Colors.amber,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        '${day['day']['maxtemp_c']}°C',
                        style: const TextStyle(
                          fontSize: 15,
                          color: Colors.amber,
                        ),
                      ),
                      Text(
                        '${day['day']['mintemp_c']}°C',
                        style: const TextStyle(
                          fontSize: 15,
                          color: Colors.amber,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        day['day']['condition']['text'],
                        style: const TextStyle(
                          fontSize: 15,
                          color: Colors.amber,
                        ),
                      ),
                      Text(
                        'Wind: ${day['day']['maxwind_kph']} km/h',
                        style: const TextStyle(
                          fontSize: 15,
                          color: Colors.amber,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ],
          );
        }).toList(),
      ),
    );
  }
}
