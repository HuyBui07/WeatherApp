import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../utils/responsive.dart';

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
      width: Responsive.isMobile(context) ? 280 : 300,
      padding: EdgeInsets.all(Responsive.getPadding(context)),
      margin: EdgeInsets.only(
        right: Responsive.getPadding(context),
        bottom: Responsive.isMobile(context) ? 8 : 0,
      ),
      decoration: BoxDecoration(
        color: AppColors.gray,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$cityName ($date)',
            style: TextStyle(
              color: Colors.white,
              fontSize: Responsive.isMobile(context) ? 18 : 22,
              fontWeight: FontWeight.bold,
            ),
            textScaler: TextScaler.linear(Responsive.sizeScaleFactor(context)),
          ),
          SizedBox(height: 8 * Responsive.sizeScaleFactor(context)),
          Image.network(icon),
          SizedBox(height: 4 * Responsive.sizeScaleFactor(context)),
          Text(
            condition,
            style: TextStyle(
              color: Colors.white,
              fontSize: Responsive.isMobile(context) ? 16 : 18,
            ),
            textScaler: TextScaler.linear(Responsive.sizeScaleFactor(context)),
          ),
          SizedBox(height: 8 * Responsive.sizeScaleFactor(context)),
          Text(
            'Temperature: ${temperature.toString()}°C',
            style: TextStyle(
              color: Colors.white,
              fontSize: Responsive.isMobile(context) ? 16 : 18,
            ),
            textScaler: TextScaler.linear(Responsive.sizeScaleFactor(context)),
          ),
          SizedBox(height: 6 * Responsive.sizeScaleFactor(context)),
          Text(
            'Wind: ${windSpeed.toString()} M/S',
            style: TextStyle(
              color: Colors.white,
              fontSize: Responsive.isMobile(context) ? 16 : 18,
            ),
            textScaler: TextScaler.linear(Responsive.sizeScaleFactor(context)),
          ),
          SizedBox(height: 6 * Responsive.sizeScaleFactor(context)),
          Text(
            'Humidity: ${humidity.toString()}%',
            style: TextStyle(
              color: Colors.white,
              fontSize: Responsive.isMobile(context) ? 16 : 18,
            ),
            textScaler: TextScaler.linear(Responsive.sizeScaleFactor(context)),
          ),
        ],
      ),
    );
  }
}
