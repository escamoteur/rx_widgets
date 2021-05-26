import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:rx_widget_demo/service/json/weather_in_cities.dart';
import 'package:rx_widget_demo/service/weather_entry.dart';

class WeatherService {
  static final url = 'https://api.openweathermap.org/data/2.5/box/'
      'city?bbox=12,32,15,37,10&appid=27ac337102cc4931c24ba0b50aca6bbd';
  static final uri = Uri.parse(url);

  WeatherService(this.client);

  final http.Client client;

  Future<List<WeatherEntry>> getWeatherEntriesForCity(String? filter) async {
    final response = await client.get(uri);
    print(response.statusCode);
    if (response.statusCode == 200) {
      return WeatherInCities.fromJson(
              json.decode(response.body) as Map<String, dynamic>)
          .cities
          .where((weatherInCity) =>
              filter == null ||
              filter.isEmpty ||
              weatherInCity.name.toUpperCase().startsWith(filter.toUpperCase()))
          .map((weatherInCity) => WeatherEntry.from(weatherInCity))
          .toList();
    } else {
      throw Exception(response.body);
    }
  }
}
