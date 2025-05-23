import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../utils/responsive.dart';

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
    final scaleFactor = MediaQuery.of(context).devicePixelRatio;
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(Responsive.getPadding(context) * scaleFactor),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(10 * scaleFactor),
      ),
      child: Responsive.isMobile(context)
          ? _buildMobileLayout(scaleFactor)
          : _buildDesktopLayout(scaleFactor),
    );
  }

  Widget _buildMobileLayout(double scaleFactor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$cityName ($date)',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24 * scaleFactor,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 16 * scaleFactor),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Temperature: ${temperature.toString()}°C',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18 * scaleFactor,
                  ),
                ),
                SizedBox(height: 8 * scaleFactor),
                Text(
                  'Wind: ${windSpeed.toString()} M/S',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18 * scaleFactor,
                  ),
                ),
                SizedBox(height: 8 * scaleFactor),
                Text(
                  'Humidity: ${humidity.toString()}%',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18 * scaleFactor,
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Image.network(icon, scale: 1/scaleFactor),
                SizedBox(height: 8 * scaleFactor),
                Text(
                  condition,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18 * scaleFactor,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDesktopLayout(double scaleFactor) {
    final fontSize = 28.0 * scaleFactor;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '$cityName ($date)',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: fontSize,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16 * scaleFactor),
              Text(
                'Temperature: ${temperature.toString()}°C',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: fontSize - (6 * scaleFactor),
                ),
              ),
              SizedBox(height: 12 * scaleFactor),
              Text(
                'Wind: ${windSpeed.toString()} M/S',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: fontSize - (6 * scaleFactor),
                ),
              ),
              SizedBox(height: 12 * scaleFactor),
              Text(
                'Humidity: ${humidity.toString()}%',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: fontSize - (6 * scaleFactor),
                ),
              ),
            ],
          ),
        ),
        Column(
          children: [
            Image.network(icon, scale: 1/scaleFactor),
            SizedBox(height: 8 * scaleFactor),
            Text(
              condition,
              style: TextStyle(
                color: Colors.white,
                fontSize: fontSize - (6 * scaleFactor),
              ),
            ),
          ],
        ),
        SizedBox(width: 40 * scaleFactor),
      ],
    );
  }
}
