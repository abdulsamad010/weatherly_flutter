import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String geocodingUrl =
      'https://geocoding-api.open-meteo.com/v1/search';

  static const String weatherUrl =
      'https://api.open-meteo.com/v1/forecast';

  static Future<Map<String, dynamic>> searchCity(String city) async {
    final uri = Uri.parse(geocodingUrl).replace(
      queryParameters: {
        'name': city,
        'count': '1',
        'language': 'en',
        'format': 'json',
      },
    );

    final response = await http.get(uri);

    if (response.statusCode != 200) {
      throw Exception('Unable to search city');
    }

    final data = jsonDecode(response.body);

    if (data['results'] == null || data['results'].isEmpty) {
      throw Exception('City not found');
    }

    return data['results'][0];
  }

  static Future<Map<String, dynamic>> getWeather(
      double latitude,
      double longitude,
      ) async {
    final uri = Uri.parse(weatherUrl).replace(
      queryParameters: {
        'latitude': latitude.toString(),
        'longitude': longitude.toString(),
        'current': 'temperature_2m,weather_code',
        'timezone': 'auto',
      },
    );

    final response = await http.get(uri);

    if (response.statusCode != 200) {
      throw Exception('Unable to fetch weather data');
    }

    final data = jsonDecode(response.body);

    if (data['current'] == null) {
      throw Exception('Weather data not available');
    }

    return data;
  }
}