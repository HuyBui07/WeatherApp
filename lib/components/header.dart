import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 100,
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
      child: const Text(
        'Weather Dashboard',
        style: TextStyle(
          color: Colors.white, 
          fontSize: 40,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
