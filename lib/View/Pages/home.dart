import 'dart:convert';
import 'dart:html';

import 'package:flutter/material.dart';
import 'package:project_1/Model/extension.dart';
import 'package:project_1/Model/forecast.dart';
import 'package:project_1/Model/weatherModel.dart';
import 'package:http/http.dart' as http;
import 'package:project_1/Model/location.dart';

class Home extends StatefulWidget {
  final List<Location> locations;
  const Home(this.locations);

  @override
  _HomeState createState() => _HomeState(this.locations);
}

class _HomeState extends State<Home> {
  final List<Location> locations;
  final Location location;
  late WeatherModel _weathermodel;

  _HomeState(List<Location> locations)
      : this.locations = locations,
        this.location = locations[0];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[100],
        body: ListView(children: <Widget>[
          currentWeatherViews(this.locations, this.location, this.context),
          forecastViewsHourly(this.location),
          forecastViewsDaily(this.location),
        ]));
  }
}

Widget currentWeatherViews(
    List<Location> locations, Location location, BuildContext context) {
  WeatherModel _weathermodel;

  return FutureBuilder(
    builder: (context, snapshot) {
      if (snapshot.hasData) {
        _weathermodel = snapshot.data;
        if (_weathermodel == null) {
          return Text("Error Getting Weather");
        } else {
          return Column(children: [
            createAppBar(locations, location, context),
            weatherBox(_weathermodel),
            weatherDetailsBox(_weathermodel),
          ]);
        }
      } else {
        return Center(child: CircularProgressIndicator());
      }
    },
    future: getCurrentWeather(location),
  );
}

Widget forecastViewsHourly(Location location) {
  Forecast _forecast;

  return FutureBuilder(
    builder: (context, snapshot) {
      if (snapshot.hasData) {
        _forecast = snapshot.data;
        if (_forecast == null) {
          return Text("Error Getting Weather");
        } else {
          return hourlyBoxes(_forecast);
        }
      } else {
        return Center(child: CircularProgressIndicator());
      }
    },
    future: getForecast(location),
  );
}

Widget forecastViewsDaily(Location location) {
  Forecast _forecast;

  return FutureBuilder(
    builder: (context, snapshot) {
      if (snapshot.hasData) {
        _forecast = snapshot.data;
        if (_forecast == null) {
          return Text("Error Getting Weather");
        } else {
          return dailyBoxes(_forecast);
        }
      } else {
        return Center(child: CircularProgressIndicator());
      }
    },
    future: getForecast(location),
  );
}

Widget weatherBox(WeatherModel _weathermodel) {
  return Container(
    padding: const EdgeInsets.all(15.0),
    margin: const EdgeInsets.all(15.0),
    height: 160.0,
    decoration:
        BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20))),
    child: Row(
      children: [
        Expanded(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
              // TODO: add icon
              Container(
                  margin: const EdgeInsets.all(5.0),
                  child: Text(
                    "${_weathermodel.description.capitalizeFirstOfEach}",
                    style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 16,
                        color: Colors.white),
                  )),
              Container(
                  margin: const EdgeInsets.all(5.0),
                  child: Text(
                    "H:${_weathermodel.high.toInt}℃ L:${_weathermodel.low.toInt}℃",
                    style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 13,
                        color: Colors.white),
                  )),
            ])),
        Column(children: [
          Container(
              child: Text(
            "${_weathermodel.temp.toInt}℃",
            textAlign: TextAlign.left,
            style: TextStyle(
                fontSize: 60, fontWeight: FontWeight.bold, color: Colors.white),
          )),
          Container(
              child: Text(
            "Feels like ${_weathermodel.feelsLike.toInt}℃",
            textAlign: TextAlign.left,
            style: TextStyle(
                fontSize: 13, fontWeight: FontWeight.bold, color: Colors.white),
          )),
        ])
      ],
    ),
  );
}

Future getCurrentWeather() async {
  WeatherModel weathermodel;
  String location = 'Kuala Lumpur';
  String apiKey = 'eedffe980ac9dfa9c47dc3c855b96081';
  var url =
      'https://api.openweathermap.org/data/2.5/weather?q=$location&appid=$apiKey&units=metric';

  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    weathermodel = WeatherModel.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load weather data');
  }
  return weathermodel;
}

Future getForecast(Location location) async {
  Forecast forecast;
  String lat = location.lat;
  String lon = location.lon;
  String apiKey = 'eedffe980ac9dfa9c47dc3c855b96081';
  var url =
      'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=$apiKey';

  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    forecast = Forecast.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load weather data');
  }
  return forecast;
}
