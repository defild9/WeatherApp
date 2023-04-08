import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weather_app/model/WeatherData.dart';

class Weather {
  final String city;
  final String apiKey = "f340a26526ceebc1b6ce23e8192a47cd";

  Weather({required this.city});

  Future<WeatherData> fetchWeather() async {
    final url = Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?q=$city&units=metric&appid=$apiKey');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        return WeatherData.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Request failed with status: ${response.statusCode}.');
      }
    } catch (error) {
      throw Exception('Failed to load weather.');
    }
  }
}