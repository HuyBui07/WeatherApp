import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/weather_model.dart';

class WeatherHistoryService {
  // Private constructor
  WeatherHistoryService._();

  // Singleton instance
  static final WeatherHistoryService _instance = WeatherHistoryService._();

  // Factory constructor to return the singleton instance
  factory WeatherHistoryService() => _instance;

  // SharedPreferences instance
  late final SharedPreferences _prefs;
  bool _isInitialized = false;

  // Initialize the service
  Future<void> init() async {
    if (_isInitialized) return;

    try {
      _prefs = await SharedPreferences.getInstance();
      _isInitialized = true;
    } catch (e) {
      throw Exception('Failed to initialize WeatherHistoryService: $e');
    }
  }

  // Check if service is initialized
  void _checkInitialized() {
    if (!_isInitialized) {
      throw Exception('WeatherHistoryService not initialized');
    }
  }

  // Save weather data to history
  Future<void> saveWeatherHistory(
      WeatherModel todayWeather, List<WeatherModel> forecastList) async {
    _checkInitialized();

    final weatherHistory = {
      'current': {
        'cityName': todayWeather.cityName,
        'temp_c': todayWeather.temperature,
        'condition': {
          'text': todayWeather.condition,
          'icon': todayWeather.icon,
        },
        'wind_kph': todayWeather.windSpeed,
        'humidity': todayWeather.humidity,
        'last_updated': todayWeather.lastUpdated,
      },
      'forecast': forecastList
          .map((weather) => {
                'cityName': weather.cityName,
                'temp_c': weather.temperature,
                'condition': {
                  'text': weather.condition,
                  'icon': weather.icon,
                },
                'wind_kph': weather.windSpeed,
                'humidity': weather.humidity,
                'last_updated': weather.lastUpdated,
              })
          .toList(),
    };

    await _prefs.setString('weather_history', jsonEncode(weatherHistory));
  }

  // Get today's weather history
  Future<Map<String, dynamic>?> getWeatherHistory() async {
    _checkInitialized();

    final jsonString = _prefs.getString('weather_history');
    if (jsonString == null) return null;
    return jsonDecode(jsonString);
  }
}
