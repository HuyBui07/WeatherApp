import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../utils/text_scale.dart';

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: const BoxDecoration(
        color: AppColors.primary,
        boxShadow: [
          BoxShadow(
            color: Color(0x1A000000),
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Text(
        'Weather Dashboard',
        style: const TextStyle(
          color: Colors.white, 
          fontSize: 40,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
        textScaler: TextScaler.linear(ScaleSize.sizeScaleFactor(context)),
      ),
    );
  }
}
