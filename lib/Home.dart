import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import './custom_widgets/modals/Error_Modal.dart';
import 'custom_widgets/Weather_Widget.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'custom_widgets/Forecast_Widget.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  final String apiKey = 'ecfc87ba86934be4a2201227242303';

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var currentLocation = {};
  var permissionStatus = '';
  var locationDataJson = {};
  var foreCastDataJson = {};

  Future<bool> _requestPermission() async {
    final permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.deniedForever) {
      setState(() {
        permissionStatus = 'deniedForever';
      });
      return false;
    } else if (permission == LocationPermission.denied) {
      setState(() {
        permissionStatus = 'denied';
      });
      return false;
    } else if (permission == LocationPermission.whileInUse) {
      setState(() {
        permissionStatus = 'availed';
      });
      final position = await Geolocator.getCurrentPosition();
      setState(() {
        currentLocation = {
          'latitude': position.latitude,
          'longitude': position.longitude,
        };
      });
      return true;
    }
    return false;
  }

  void _fetchWeatherData() async {
    final response = await http.get(Uri.parse(
      'http://api.weatherapi.com/v1/current.json?key=${widget.apiKey}&q=${currentLocation['latitude']},${currentLocation['longitude']}',
    ));
    print('Response status code: ${response.statusCode}');
    if (response.statusCode == 200) {
      setState(() {
        locationDataJson = jsonDecode(response.body);
      });
      var locationName = locationDataJson['location']['region'];
    } else {
      print('Error response: ${response.body}');
      Navigator.of(context).pushNamed('/error', arguments: 'An error occurred');
    }
  }

  void _fetchForeCastData() async {
    final response = await http.get(Uri.parse(
      'http://api.weatherapi.com/v1/forecast.json?key=${widget.apiKey}&q=${currentLocation['latitude']},${currentLocation['longitude']}&days=3',
    ));
    print('Response status code: ${response.statusCode}');
    if (response.statusCode == 200) {
      var foreCastData = jsonDecode(response.body);
      setState(() {
        foreCastDataJson = foreCastData;
      });
      foreCastDataJson['forecast']["forecastday"].forEach((element) {
        print(element);
      });
    } else {
      print('Error response: ${response.body}');
      Navigator.of(context).pushNamed('/error', arguments: 'An error occurred');
    }
  }

  void changeLocation() async {
    setState(() {
      currentLocation = {
        'latitude': 56.1304,
        'longitude': -106.3468,
      };
    });
    _fetchWeatherData();
    _fetchForeCastData();
  }

  void initState() {
    super.initState();
    _initializeData();
  }

  void _initializeData() async {
    await _requestPermission();
    if (permissionStatus == 'availed') {
      _fetchWeatherData();
      _fetchForeCastData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.9),
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 70,
                  alignment: Alignment.topCenter,
                  padding: EdgeInsets.all(20),
                  child: Text(
                    "Weather Guru",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.amber,
                    ),
                  ),
                  decoration: BoxDecoration(
                    border: BorderDirectional(
                      bottom: BorderSide(color: Colors.amber, width: 2),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                if (locationDataJson.isNotEmpty)
                  Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Current Weather",
                            style:
                                TextStyle(color: Colors.amber, fontSize: 30)),
                        WeatherWidget(locationDataJson: locationDataJson),
                      ]),
                SizedBox(height: 20),
                if (foreCastDataJson.isNotEmpty)
                  Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Forecast",
                            style:
                                TextStyle(color: Colors.amber, fontSize: 30)),
                        ForecastWidget(foreCastDataJson: foreCastDataJson),
                      ]),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: changeLocation,
                  child: Text('Change Location'),
                ),
              ],
            ),
          ),
          if (permissionStatus == 'deniedForever' ||
              permissionStatus == 'denied')
            Positioned(
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                color: Colors.black.withOpacity(0.5),
                alignment: Alignment.center,
                child: ErrorModal(errorMessage: 'An error occurred'),
              ),
            ),
        ],
      ),
    );
  }
}
