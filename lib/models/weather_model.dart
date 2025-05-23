class WeatherModel {
  final String cityName;
  final double temperature;
  final String condition;
  final String icon;
  final double windSpeed;
  final int humidity;
  final String lastUpdated;

  WeatherModel({
    required this.cityName,
    required this.temperature,
    required this.condition,
    required this.icon,
    required this.windSpeed,
    required this.humidity,
    required this.lastUpdated,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json, String cityName) {
    return WeatherModel(
      cityName: cityName,
      temperature: json['temp_c'].toDouble(),
      condition: json['condition']['text'],
      icon: json['condition']['icon'],
      windSpeed: json['wind_kph'].toDouble(),
      humidity: json['humidity'],
      lastUpdated: json['last_updated'],
    );
  }

  factory WeatherModel.fromJsonForecast(
      Map<String, dynamic> json, String cityName) {
    return WeatherModel(
      cityName: cityName,
      temperature: json['day']['avgtemp_c'].toDouble(),
      condition: json['day']['condition']['text'],
      icon: json['day']['condition']['icon'],
      windSpeed: json['day']['maxwind_kph'].toDouble(),
      humidity: json['day']['avghumidity'],
      lastUpdated: json['date'],
    );
  }

  @override
  String toString() {
    return 'WeatherModel(cityName: $cityName, temperature: $temperature°C, condition: $condition, windSpeed: $windSpeed km/h, humidity: $humidity%, lastUpdated: $lastUpdated)';
  }
}
