class WeatherModel {
  String city;
  String country;
  double latitude;
  double longitude;
  double temperature;
  String condition;
  String icon;

  WeatherModel({
    required this.city,
    required this.country,
    required this.latitude,
    required this.longitude,
    required this.temperature,
    required this.condition,
    required this.icon,
  });
}