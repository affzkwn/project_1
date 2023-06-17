import 'package:flutter/material.dart';
import 'package:project_1/Model/location.dart';
import 'package:project_1/View/Pages/home.dart';
import 'package:project_1/View/Pages/splash.dart';
import 'package:project_1/Model/location.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  List<Location> locations = [
    new Location(
        city: "calgary",
        country: "canada",
        lat: "51.0407154",
        lon: "-114.1513999")
  ];

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Home(locations),
    );
  }
}
