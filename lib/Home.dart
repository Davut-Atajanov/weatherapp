
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var currentLocation = {};
  var permissionStatus = '';
  var locationDataJson = {};



void _requestPermission() async {
  final permission = await Geolocator.requestPermission();
  if(permission == LocationPermission.deniedForever) {
    setState(() {
      permissionStatus = 'deniedForever';
    });
  } else if(permission == LocationPermission.denied) {
    setState(() {
      permissionStatus = 'denied';
    });
  } else if(permission == LocationPermission.whileInUse) {
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
  }
}

void initState() {
  super.initState();
  _requestPermission();
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 70,
              alignment: Alignment.topCenter,
              child: Text("Weather Guru", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.amber)),
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                border: BorderDirectional(bottom: BorderSide(color: Colors.amber, width: 2))
              )
            ),
            if(permissionStatus == 'denied')
              // ElevatedButton(onPressed: () => _requestPermission, child: Text('Allow location access')),
              Text('Location access denied'),

            if(permissionStatus == 'deniedForever')
              Text('Location access denied forever'),
              // ElevatedButton(onPressed: () => _requestPermission, child: Text('Allow location access')),
            if(permissionStatus == 'availed')
              Text('Permission availed'),
            Text('Current location: $currentLocation'),
          ],
        ),
      )
    );
  }
}