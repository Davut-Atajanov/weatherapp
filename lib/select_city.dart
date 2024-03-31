import 'package:flutter/material.dart';
import 'package:weatherapp/data_access/cities.dart';

class SelectCity extends StatefulWidget {
  const SelectCity({super.key});

  @override
  State<SelectCity> createState() => _SelectCityState();
}

class _SelectCityState extends State<SelectCity> {
  final Map<String, dynamic> myCities = cities;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.9),
      appBar: AppBar(
        title: const Text(
          "Select a City",
          style: TextStyle(color: Colors.amber),
        ),
        centerTitle: true,
        backgroundColor: Colors.black.withOpacity(0.5),
      ),
      body: Center(
        child: Container(
          width: 150,
          height: 600,
          color: Colors.black.withOpacity(0.5),
          child: ListView.builder(
            itemExtent: 50,
            itemBuilder: (_, index) {
              String cityName = myCities.keys.elementAt(index);
              return InkWell(
                onTap: () {
                  Navigator.pop(context, {
                    "lat": myCities.values.elementAt(index)['lat'],
                    "lng": myCities.values.elementAt(index)['lng']
                  });
                },
                child: Center(
                  child: Text(
                    cityName,
                    style: const TextStyle(color: Colors.amber),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
