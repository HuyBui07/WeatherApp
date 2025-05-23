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
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(Responsive.getPadding(context)),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Responsive.isMobile(context)
          ? _buildMobileLayout()
          : _buildDesktopLayout(),
    );
  }

  Widget _buildMobileLayout() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$cityName ($date)',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Temperature: ${temperature.toString()}°C',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Wind: ${windSpeed.toString()} M/S',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Humidity: ${humidity.toString()}%',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Image.network(icon),
                const SizedBox(height: 8),
                Text(
                  condition,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDesktopLayout() {
    const fontSize = 28.0;
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
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: fontSize,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Temperature: ${temperature.toString()}°C',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: fontSize - 6,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Wind: ${windSpeed.toString()} M/S',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: fontSize - 6,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Humidity: ${humidity.toString()}%',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: fontSize - 6,
                ),
              ),
            ],
          ),
        ),
        Column(
          children: [
            Image.network(icon),
            const SizedBox(height: 8),
            Text(
              condition,
              style: const TextStyle(
                color: Colors.white,
                fontSize: fontSize - 6,
              ),
            ),
          ],
        ),
        const SizedBox(width: 40),
      ],
    );
  }
}
