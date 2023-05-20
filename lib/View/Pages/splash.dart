/* import 'dart:async';
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:project_1/Model/weatherModel.dart';
import 'package:project_1/View/Pages/bottomnavBar.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});
  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await loadJson();
    });
    super.initState();
  }

  List data = [];
  List<WeatherModel> weatherList = [];

  loadJson() async {
    String myData = await rootBundle.loadString('assets/myJson/file.json');

    setState(() {
      data = json.decode(myData);
      weatherList = data.map((e) => WeatherModel.fromJson(e)).toList();
      weatherList = weatherList;
    });
    Timer(
        Duration(seconds: 2),
        (() => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: ((context) => NavBar(
                      weatherModel: weatherList,
                    ))))));
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
          child: Center(
              child: Text(
            'Weather',
            style: TextStyle(color: Colors.white, fontSize: 50),
          )),
        ),
      ),
    );
  }
}
 */