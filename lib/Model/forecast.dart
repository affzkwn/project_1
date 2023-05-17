import 'package:flutter/foundation.dart';
import 'package:project_1/Model/daily.dart';
import 'package:project_1/Model/hourly.dart';

class Forecast {
  final List<Hourly> hourly;
  final List<Daily> daily;

  Forecast({required this.hourly, required this.daily});

  factory Forecast.fromJson(Map<String, dynamic> json) {
    final List<dynamic> hourlyData = json['hourly'];
    final List<dynamic> dailyData = json['daily'];

    List<Hourly> hourly = [];
    List<Daily> daily = [];

    hourlyData.forEach((item) {
      var hour = Hourly.fromJson(item);
      hourly.add(hour);
    });

    dailyData.forEach((item) {
      var day = Daily.fromJson(item);
      daily.add(day);
    });

    return Forecast(hourly: hourly, daily: daily);
  }
}
