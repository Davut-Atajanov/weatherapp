import 'package:flutter/material.dart';

class WeatherDetailsModal extends StatefulWidget {
  const WeatherDetailsModal({super.key, required this.weatherData});

  final Map<String, dynamic> weatherData;

  @override
  _WeatherDetailsModalState createState() => _WeatherDetailsModalState();
}

class _WeatherDetailsModalState extends State<WeatherDetailsModal> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: const Column(
        children: [
          Text('Weather Details'),
        ],
      ),
    );
  }
}
