import 'dart:convert';
import 'dart:html';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
  return Stack(children: [
    Container(
      padding: const EdgeInsets.all(15.0),
      margin: const EdgeInsets.all(15.0),
      height: 160.0,
      decoration: BoxDecoration(
          color: Colors.indigoAccent,
          borderRadius: BorderRadius.all(Radius.circular(20))),
    ),
    ClipPath(
      clipper: Clipper(),
      child: Container(
        padding: const EdgeInsets.all(15.0),
        margin: const EdgeInsets.all(15.0),
        height: 160.0,
        decoration: BoxDecoration(
            color: Colors.indigoAccent[400],
            borderRadius: BorderRadius.all(Radius.circular(20))),
      ),
    ),
    Container(
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
                getWeatherIcon(_weathermodel.icon),
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
                  fontSize: 60,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            )),
            Container(
                child: Text(
              "Feels like ${_weathermodel.feelsLike.toInt}℃",
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            )),
          ])
        ],
      ),
    )
  ]);
}

Widget weatherDetailsBox(WeatherModel _weathermodel) {
  return Container(
    padding:
        const EdgeInsets.only(left: 15.0, top: 25.0, bottom: 25.0, right: 15.0),
    margin:
        const EdgeInsets.only(left: 15.0, top: 5.0, bottom: 15.0, right: 15.0),
    decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(20)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3),
          )
        ]),
    child: Row(children: [
      Expanded(
          child: Column(
        children: [
          Container(
              child: Text(
            "Wind",
            textAlign: TextAlign.left,
            style: TextStyle(
                fontWeight: FontWeight.w600, fontSize: 12, color: Colors.grey),
          )),
          Container(
              child: Text(
            "${_weathermodel.wind}KM/H",
            textAlign: TextAlign.left,
            style: TextStyle(
                fontWeight: FontWeight.w700, fontSize: 15, color: Colors.black),
          ))
        ],
      )),
      Expanded(
          child: Column(
        children: [
          Container(
              child: Text(
            "Humidity",
            textAlign: TextAlign.left,
            style: TextStyle(
                fontWeight: FontWeight.w600, fontSize: 12, color: Colors.grey),
          )),
          Container(
              child: Text(
            "${_weathermodel.humidity.toInt()}%",
            textAlign: TextAlign.left,
            style: TextStyle(
                fontWeight: FontWeight.w700, fontSize: 15, color: Colors.black),
          ))
        ],
      )),
      Expanded(
          child: Column(
        children: [
          Container(
              child: Text(
            "Pressure",
            textAlign: TextAlign.left,
            style: TextStyle(
                fontWeight: FontWeight.w600, fontSize: 12, color: Colors.grey),
          )),
          Container(
              child: Text(
            "${_weathermodel.pressure} hPa",
            textAlign: TextAlign.left,
            style: TextStyle(
                fontWeight: FontWeight.w700, fontSize: 15, color: Colors.black),
          ))
        ],
      )),
    ]),
  );
}

Widget hourlyBoxes(Forecast _forecast) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 0.0),
    height: 150.0,
    child: ListView.builder(
      padding: const EdgeInsets.only(left: 8, top: 0, bottom: 0, right: 8),
      scrollDirection: Axis.horizontal,
      itemCount: _forecast.hourly.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
            padding: const EdgeInsets.only(
                left: 10.0, top: 15.0, bottom: 15.0, right: 10.0),
            margin: const EdgeInsets.all(5),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(18)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 2,
                    blurRadius: 2,
                    offset: Offset(0, 1),
                  )
                ]),
            child: Column(children: [
              Text(
                "${_forecast.hourly[index].temp}℃",
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 17,
                    color: Colors.black),
              ),
              getWeatherIcon(_forecast.hourly[index].icon),
              Text(
                "${getTimeFromTimestamp(_forecast.hourly[index].dt as int)}",
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                    color: Colors.grey),
              ),
            ]));
      },
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

Image getWeatherIcon(String _icon) {
  String path = 'assets/icons/';
  String imageExtension = ".png";
  return Image.asset(
    path + _icon + imageExtension,
    width: 70,
    height: 70,
  );
}

Image getWeatherIconSmall(String _icon) {
  String path = 'assets/icons/';
  String imageExtension = ".png";
  return Image.asset(
    path + _icon + imageExtension,
    width: 40,
    height: 40,
  );
}

class Clipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(0, size.height - 20);

    path.quadraticBezierTo((size.width / 6) * 1, (size.height / 2) + 15,
        (size.width / 3) * 1, size.height - 30);
    path.quadraticBezierTo((size.width / 2) * 1, (size.height + 0),
        (size.width / 3) * 2, (size.height / 4) * 3);
    path.quadraticBezierTo((size.width / 6) * 5, (size.height / 2) - 20,
        (size.width), size.height - 60);

    path.lineTo(size.width, size.height - 60);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

String getTimeFromTimestamp(int timestamp) {
  var date = new DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
  var formatter = new DateFormat('h:mm a');
  return formatter.format(date);
}

String getDateFromTimestamp(int timestamp) {
  var date = new DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
  var formatter = new DateFormat('h:mm a');
  return formatter.format(date);
}
