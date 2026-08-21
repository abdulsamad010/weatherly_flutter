import 'package:flutter/material.dart';

import '../services/api_service.dart';
import 'weather_model.dart';

class WeatherProvider extends ChangeNotifier {
  WeatherModel? weather;

  bool isLoading = false;

  String errorMessage = '';

  Future<void> searchWeather(String city) async {
    if (city.trim().isEmpty) {
      errorMessage = 'Please enter a city name';
      weather = null;
      notifyListeners();
      return;
    }

    isLoading = true;
    errorMessage = '';
    notifyListeners();

    try {
      final cityData = await ApiService.searchCity(city);

      final latitude = cityData['latitude'];
      final longitude = cityData['longitude'];

      final weatherData = await ApiService.getWeather(
        latitude,
        longitude,
      );

      final current = weatherData['current'];

      final code = current['weather_code'];

      String condition = 'Unknown';
      String icon = '🌍';

      if (code == 0) {
        condition = 'Clear Sky';
        icon = '☀️';
      } else if (code == 1 || code == 2) {
        condition = 'Partly Cloudy';
        icon = '🌤️';
      } else if (code == 3) {
        condition = 'Cloudy';
        icon = '☁️';
      } else if (code == 45 || code == 48) {
        condition = 'Foggy';
        icon = '🌫️';
      } else if (code >= 51 && code <= 57) {
        condition = 'Drizzle';
        icon = '🌦️';
      } else if (code >= 61 && code <= 67) {
        condition = 'Rainy';
        icon = '🌧️';
      } else if (code >= 71 && code <= 77) {
        condition = 'Snowy';
        icon = '❄️';
      } else if (code >= 80 && code <= 82) {
        condition = 'Rain Showers';
        icon = '🌦️';
      } else if (code >= 95) {
        condition = 'Thunderstorm';
        icon = '⛈️';
      }

      weather = WeatherModel(
        city: cityData['name'],
        country: cityData['country'],
        temperature: current['temperature_2m'],
        condition: condition,
        icon: icon,
      );
    } catch (e) {
      weather = null;
      errorMessage = 'Unable to find weather for this city';
    }

    isLoading = false;
    notifyListeners();
  }
}