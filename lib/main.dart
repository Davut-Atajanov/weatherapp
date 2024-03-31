import 'package:flutter/material.dart';
import 'package:weatherapp/select_city.dart';
import './Home.dart';
import './custom_widgets/modals/Error_Modal.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case '/':
            return MaterialPageRoute(
                builder: (_) => const MyHomePage(title: 'Flutter Demo Home Page'));
          case '/error':
            final errorMessage = settings.arguments as String;
            return MaterialPageRoute(
                builder: (_) => ErrorModal(errorMessage: errorMessage));
          case '/select-city':
            return MaterialPageRoute(builder:
            (_) => const SelectCity());
          default:
            return null;
        }
      },
      initialRoute: '/',
    );
  }
}
