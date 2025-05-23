import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../utils/text_scale.dart';

class FutureWeather extends StatelessWidget {
  final String cityName;
  final String date;
  final double temperature;
  final double windSpeed;
  final double humidity;
  final String condition;
  final String icon;

  const FutureWeather({
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
      width: 300 * ScaleSize.sizeScaleFactor(context),
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(right: 16, bottom: 16),
      decoration: BoxDecoration(
        color: AppColors.gray,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$cityName ($date)',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            textScaler: TextScaler.linear(ScaleSize.sizeScaleFactor(context)),
          ),
          SizedBox(height: 16 * ScaleSize.sizeScaleFactor(context)),
          Image.network(icon,
              width: 100 * ScaleSize.sizeScaleFactor(context),
              height: 100 * ScaleSize.sizeScaleFactor(context)),
          SizedBox(height: 10 * ScaleSize.sizeScaleFactor(context)),
          Text(
            condition,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
            textScaler: TextScaler.linear(ScaleSize.sizeScaleFactor(context)),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 16 * ScaleSize.sizeScaleFactor(context)),
          Text(
            'Temperature: ${temperature.toString()}°C',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
            textScaler: TextScaler.linear(ScaleSize.sizeScaleFactor(context)),
          ),
          SizedBox(height: 12 * ScaleSize.sizeScaleFactor(context)),
          Text(
            'Wind: ${windSpeed.toString()} M/S',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
            textScaler: TextScaler.linear(ScaleSize.sizeScaleFactor(context)),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 12 * ScaleSize.sizeScaleFactor(context)),
          Text(
            'Humidity: ${humidity.toString()}%',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
            textScaler: TextScaler.linear(ScaleSize.sizeScaleFactor(context)),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
