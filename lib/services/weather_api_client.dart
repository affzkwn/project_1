import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:project_1/Model/weatherModel.dart';

class weatherApiClient {
  Future<WeatherModel>? getCurrentWeather(String? location) async {
    var endpoint = Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?q=$location&appid=eedffe980ac9dfa9c47dc3c855b96081&units=metric');

    var response = await http.get(endpoint);
    var body = jsonDecode(response.body);
    print(WeatherModel.fromJson(body).name);
    return WeatherModel.fromJson(body);
  }
}
