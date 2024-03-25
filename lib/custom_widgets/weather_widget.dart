import 'package:flutter/material.dart';

class WeatherWidget extends StatefulWidget {
  const WeatherWidget({super.key, required this.locationDataJson});
  final Map<dynamic, dynamic> locationDataJson;

  @override
  _WeatherWidgetState createState() => _WeatherWidgetState();
}

class _WeatherWidgetState extends State<WeatherWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: MediaQuery.of(context).size.width * 0.9,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.black.withOpacity(0.5),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            children: [
              Image.network(
                widget.locationDataJson['current']['condition']['icon'],
              ),
              Text(
                widget.locationDataJson['current']['condition']['text'],
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
                widget.locationDataJson['location']['region'] +
                    ', ' +
                    widget.locationDataJson['location']['country'],
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.amber,
                ),
              ),
              Text(
                '${widget.locationDataJson['current']['temp_c']}°C',
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
                widget.locationDataJson['current']['condition']['text'],
                style: const TextStyle(
                  fontSize: 15,
                  color: Colors.amber,
                ),
              ),
              Text(
                'Wind: ${widget.locationDataJson['current']['wind_kph']} km/h',
                style: const TextStyle(
                  fontSize: 15,
                  color: Colors.amber,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
