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
    final scaleFactor = MediaQuery.of(context).devicePixelRatio;
    return Container(
      width: (Responsive.isMobile(context) ? 280 : 300) * scaleFactor,
      padding: EdgeInsets.all(Responsive.getPadding(context) * scaleFactor),
      margin: EdgeInsets.only(
        right: Responsive.getPadding(context) * scaleFactor,
        bottom: Responsive.isMobile(context) ? 16 * scaleFactor : 0,
      ),
      decoration: BoxDecoration(
        color: AppColors.gray,
        borderRadius: BorderRadius.circular(10 * scaleFactor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$cityName ($date)',
            style: TextStyle(
              color: Colors.white,
              fontSize: (Responsive.isMobile(context) ? 20 : 26) * scaleFactor,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16 * scaleFactor),
          Image.network(icon, scale: 1/scaleFactor),
          SizedBox(height: 10 * scaleFactor),
          Text(
            condition,
            style: TextStyle(
              color: Colors.white,
              fontSize: (Responsive.isMobile(context) ? 16 : 20) * scaleFactor,
            ),
          ),
          SizedBox(height: 16 * scaleFactor),
          Text(
            'Temperature: ${temperature.toString()}°C',
            style: TextStyle(
              color: Colors.white,
              fontSize: (Responsive.isMobile(context) ? 16 : 20) * scaleFactor,
            ),
          ),
          SizedBox(height: 12 * scaleFactor),
          Text(
            'Wind: ${windSpeed.toString()} M/S',
            style: TextStyle(
              color: Colors.white,
              fontSize: (Responsive.isMobile(context) ? 16 : 20) * scaleFactor,
            ),
          ),
          SizedBox(height: 12 * scaleFactor),
          Text(
            'Humidity: ${humidity.toString()}%',
            style: TextStyle(
              color: Colors.white,
              fontSize: (Responsive.isMobile(context) ? 16 : 20) * scaleFactor,
            ),
          ),
        ],
      ),
    );
  }
}
