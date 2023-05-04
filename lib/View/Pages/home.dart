import 'package:flutter/material.dart';
import 'package:project_1/Model/weatherModel.dart';
import 'package:project_1/Utils/staticfile.dart';
import 'package:project_1/View/Pages/bottomnavBar.dart';
import 'package:project_1/Model/weatherModel.dart';
import 'package:project_1/services/weather_api_client.dart';

class Home extends StatefulWidget {
  List<WeatherModel> weatherModel = [];
  Home({required this.weatherModel});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  weatherApiClient client = weatherApiClient();
  @override
  void initState() {
    super.initState();
    client.getCurrentWeather('Georgia');
  }

  find_myLocation_index() {
    for (var i = 0; i < widget.weatherModel.length; i++) {
      if (widget.weatherModel[i].name == StaticFile.myLocation) {
        setState(() {
          StaticFile.myLocationIndex = i;
        });
        break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double myHeight = MediaQuery.of(context).size.height;
    double myWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xff060720),
        body: Container(
            height: myHeight,
            width: myWidth,
            child: Column(
              children: [
                SizedBox(
                  height: myHeight * 0.03,
                ),
                Text(
                  widget.weatherModel[StaticFile.myLocationIndex].name
                      .toString(),
                  style: TextStyle(fontSize: 40, color: Colors.white),
                ),
                SizedBox(
                  height: myHeight * 0.01,
                ),
                Text(
                  '4 May 2023'.toString(),
                  style: TextStyle(
                      fontSize: 20, color: Colors.white.withOpacity(0.5)),
                ),
                SizedBox(
                  height: myHeight * 0.05,
                ),
                Container(
                  height: myHeight * 0.05,
                  width: myWidth * 0.6,
                  decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(children: [
                    Expanded(
                        flex: 2,
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              gradient: LinearGradient(colors: [
                                Color.fromARGB(255, 21, 85, 169),
                                Color.fromARGB(255, 44, 162, 246),
                              ])),
                          child: Center(
                            child: Text(
                              'Forecast',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                          ),
                        )),
                    Expanded(
                        flex: 2,
                        child: Container(
                          child: Center(
                            child: Text(
                              'Air Quality',
                              style: TextStyle(
                                  color: Colors.white.withOpacity(0.5),
                                  fontSize: 18),
                            ),
                          ),
                        ))
                  ]),
                ),
                SizedBox(
                  height: myHeight * 0.08,
                ),
                Image.asset(
                  widget.weatherModel[StaticFile.myLocationIndex]
                      .weeklyWeather[0].mainImg
                      .toString(),
                  height: myHeight * 0.3,
                  width: myWidth * 0.8,
                ),
                SizedBox(
                  height: myHeight * 0.05,
                ),
                Container(
                  height: myHeight * 0.06,
                  child: Row(children: [
                    Expanded(
                      flex: 2,
                      child: Column(children: [
                        Text(
                          'Temp',
                          style: TextStyle(
                              color: Colors.white.withOpacity(0.5),
                              fontSize: 20),
                        ),
                        Text(
                          widget.weatherModel[StaticFile.myLocationIndex]
                              .weeklyWeather![0]!.mainTemp
                              .toString(),
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ]),
                    ),
                    Expanded(
                      flex: 2,
                      child: Column(children: [
                        Text(
                          'Wind',
                          style: TextStyle(
                              color: Colors.white.withOpacity(0.5),
                              fontSize: 20),
                        ),
                        Text(
                          widget.weatherModel[StaticFile.myLocationIndex]
                              .weeklyWeather![0]!.mainWind
                              .toString(),
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ]),
                    ),
                    Expanded(
                      flex: 2,
                      child: Column(children: [
                        Text(
                          'Humidity',
                          style: TextStyle(
                              color: Colors.white.withOpacity(0.5),
                              fontSize: 20),
                        ),
                        Text(
                          widget.weatherModel[StaticFile.myLocationIndex]
                              .weeklyWeather![0]!.mainHumidity
                              .toString(),
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ]),
                    ),
                  ]),
                ),
                SizedBox(
                  height: myHeight * 0.04,
                )
              ],
            )),
      ),
    );
  }
}
