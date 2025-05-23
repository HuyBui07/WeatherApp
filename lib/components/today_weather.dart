import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../utils/text_scale.dart';

class TodayWeather extends StatelessWidget {
  final String cityName;
  final String date;
  final double temperature;
  final double windSpeed;
  final double humidity;
  final String condition;
  final String icon;

  const TodayWeather({
    super.key,
    required this.cityName,
    required this.date,
    required this.temperature,
    required this.windSpeed,
    required this.humidity,
    required this.condition,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(32 * ScaleSize.sizeScaleFactor(context)),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$cityName ($date)',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                  textScaler: TextScaler.linear(ScaleSize.sizeScaleFactor(context)),
                ),
                SizedBox(height: 16 * ScaleSize.sizeScaleFactor(context)),
                Text(
                  'Temperature: ${temperature.toString()}°C',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                  textScaler: TextScaler.linear(ScaleSize.sizeScaleFactor(context)),
                ),
                SizedBox(height: 12 * ScaleSize.sizeScaleFactor(context)),
                Text(
                  'Wind: ${windSpeed.toString()} M/S',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                  textScaler: TextScaler.linear(ScaleSize.sizeScaleFactor(context)),
                ),
                SizedBox(height: 12 * ScaleSize.sizeScaleFactor(context)),
                Text(
                  'Humidity: ${humidity.toString()}%',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                  textScaler: TextScaler.linear(ScaleSize.sizeScaleFactor(context)),
                ),
              ],
            ),
          ),
          Column(
            children: [
              Image.network(icon),
              SizedBox(height: 8 * ScaleSize.sizeScaleFactor(context)),
              Text(
                condition,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
                    textScaler: TextScaler.linear(ScaleSize.sizeScaleFactor(context)),
              ),
            ],
          ),
          SizedBox(width: 40 * ScaleSize.sizeScaleFactor(context)),
        ],
      ),
    );
  }
}
