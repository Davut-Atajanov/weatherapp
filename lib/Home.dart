import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:weatherapp/context_provider/navigation_provider.dart';
import 'package:weatherapp/custom_widgets/Bottom_Navbar.dart';
import 'package:weatherapp/select_city.dart';
import './custom_widgets/modals/Error_Modal.dart';
import 'custom_widgets/weather_widget.dart';
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
  var currentPositon = 0;

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

  void _fetchWeatherData(String? lat, String? lng) async {
    setState(() {
      locationDataJson = {};
    });
    final Response response;
    if (lat == null && lng == null) {
      response = await http.get(Uri.parse(
        'http://api.weatherapi.com/v1/current.json?key=${widget.apiKey}&q=${currentLocation['latitude']},${currentLocation['longitude']}',
      ));
    } else {
      response = await http.get(Uri.parse(
        'http://api.weatherapi.com/v1/current.json?key=${widget.apiKey}&q=$lat,$lng',
      ));
    }
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

  void _fetchForeCastData(String? lat, String? lng) async {
    setState(() {
      foreCastDataJson = {};
    });
    final Response response;
    if (lat == null && lng == null) {
      response = await http.get(Uri.parse(
        'http://api.weatherapi.com/v1/forecast.json?key=${widget.apiKey}&q=${currentLocation['latitude']},${currentLocation['longitude']}&days=3',
      ));
    } else {
      response = await http.get(Uri.parse(
        'http://api.weatherapi.com/v1/forecast.json?key=${widget.apiKey}&q=$lat,$lng}&days=3',
      ));
    }

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

  // void changeLocation() async {
  //   setState(() {
  //     currentLocation = {
  //       'latitude': 56.1304,
  //       'longitude': -106.3468,
  //     };
  //   });
  //   _fetchWeatherData();
  //   _fetchForeCastData();
  // }

  void selectCurrentLocation() async {
    final position = await Geolocator.getCurrentPosition();
    setState(() {
      currentLocation = {
        'latitude': position.latitude,
        'longitude': position.longitude,
      };
    });
    _fetchWeatherData(null, null);
    _fetchForeCastData(null, null);
  }

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  void _initializeData() async {
    await _requestPermission();
    if (permissionStatus == 'availed') {
      _fetchWeatherData(null, null);
      _fetchForeCastData(null, null);
    }
  }

  @override
  Widget build(BuildContext context) {
    final navigationProvider = Provider.of<NavigationProvider>(context);
    var currentIndex = navigationProvider.currentIndex;
    return Scaffold(
      bottomNavigationBar: BottomNav(),
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: locationDataJson.isEmpty
                  ? MainAxisAlignment.center
                  : MainAxisAlignment.start,
              children: [
                if (locationDataJson.isEmpty) const CircularProgressIndicator(),
                if (locationDataJson.isNotEmpty && currentIndex == 0)
                  Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        WeatherWidget(locationDataJson: locationDataJson),
                      ]),
                if (foreCastDataJson.isNotEmpty && currentIndex == 1)
                  Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ForecastWidget(foreCastDataJson: foreCastDataJson),
                      ]),
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
                child: const ErrorModal(errorMessage: 'An error occurred'),
              ),
            ),
          Positioned(
              top: 30,
              right: 0,
              child: Container(
                  width: 100,
                  height: 110,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Column(
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const SelectCity()),
                              ).then((result) {
                                if (result != null) {
                                  Map<String, dynamic> coordinates =
                                      result as Map<String, dynamic>;
                                  String lat = coordinates["lat"] ?? "";
                                  String lng = coordinates["lng"] ?? "";
                                  setState(() {
                                    _fetchWeatherData(lat, lng);
                                    _fetchForeCastData(lat, lng);
                                  });
                                }
                              });
                            },
                            child: const Icon(
                              Icons.location_on,
                              color: Colors.amber,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          ElevatedButton(
                            onPressed: selectCurrentLocation,
                            child: const Icon(
                              Icons.my_location,
                              color: Colors.amber,
                            ),
                          ),
                        ],
                      ),
                    ],
                  )))
        ],
      ),
    );
  }
}
