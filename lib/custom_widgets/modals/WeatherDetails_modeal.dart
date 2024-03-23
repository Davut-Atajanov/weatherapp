import 'package:flutter/material.dart';

class WeatherDetailsModal extends StatefulWidget {
  const WeatherDetailsModal({Key? key, required this.weatherData})
      : super(key: key);

  final Map<String, dynamic> weatherData;

  @override
  _WeatherDetailsModalState createState() => _WeatherDetailsModalState();
}

class _WeatherDetailsModalState extends State<WeatherDetailsModal> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text('Weather Details'),
        ],
      ),
    );
  }
}
