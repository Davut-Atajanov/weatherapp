import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weatherapp/context_provider/navigation_provider.dart';

class BottomNav extends StatelessWidget {
  const BottomNav({super.key});

  @override
  Widget build(BuildContext context) {
    final navigationProvider = Provider.of<NavigationProvider>(context);
    var currentIndex = navigationProvider.currentIndex;
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
            onPressed: () {
              navigationProvider.setIndex(0);
            },
            icon: currentIndex == 0
                ? const Icon(Icons.home, color: Colors.blue)
                : const Icon(Icons.home, color: Colors.black),
          ),
          IconButton(
            onPressed: () {
              navigationProvider.setIndex(1);
            },
            icon: currentIndex == 1
                ? const Icon(Icons.thunderstorm_sharp, color: Colors.blue)
                : const Icon(Icons.thunderstorm_sharp, color: Colors.black),
          ),
          IconButton(
            onPressed: () {
              navigationProvider.setIndex(2);
            },
            icon: currentIndex == 2
                ? const Icon(Icons.settings, color: Colors.blue)
                : const Icon(Icons.settings, color: Colors.black),
          ),
        ],
      ),
    );
  }
}
