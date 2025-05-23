import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/weather_model.dart';

class WeatherService {
  static const String _baseUrl = 'https://api.weatherapi.com/v1';
  static const String _apiKey = '1c6ff98ad3734dadb2031601252205';

  Map<String, dynamic>? _cachedData;
  String? _lastSearchedCity;

  Future<Map<String, dynamic>> getWeathers(String city, {int page = 0}) async {
    if (_cachedData != null && _lastSearchedCity == city) {
      return _paginateData(_cachedData!, page);
    }

    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/forecast.json?key=$_apiKey&q=$city&days=14'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final currentWeather = WeatherModel.fromJson(data['current'], data['location']['name']);
        final forecastList = await Future.wait(
          (data['forecast']['forecastday'] as List)
              .map((day) => Future(() => WeatherModel.fromJsonForecast(day, data['location']['name'])))
              .toList()
        );

        _cachedData = {
          'current': currentWeather,
          'forecast': forecastList,
        };
        _lastSearchedCity = city;

        return _paginateData(_cachedData!, page);
      } else {
        throw Exception('Failed to load weather data');
      }
    } catch (e) {
      throw Exception('Error fetching weather data: $e');
    }
  }

  Map<String, dynamic> _paginateData(Map<String, dynamic> data, int page) {
    final forecastList = data['forecast'] as List<WeatherModel>;
    
    final int startIndex = page * 5 + 1;
    final int endIndex = (startIndex + 5) > forecastList.length 
        ? forecastList.length 
        : startIndex + 5;
    
    final paginatedForecast = forecastList.sublist(startIndex, endIndex);

    return {
      'current': data['current'],
      'forecast': paginatedForecast,
      'hasMore': endIndex < forecastList.length,
      'totalDays': forecastList.length,
    };
  }

  void clearCache() {
    _cachedData = null;
    _lastSearchedCity = null;
  }
} 