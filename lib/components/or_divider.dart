import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class OrDivider extends StatelessWidget {
  const OrDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Expanded(child: Divider(color: AppColors.gray)),
        SizedBox(width: 16),
        Text('OR', style: TextStyle(color: AppColors.gray),),
        SizedBox(width: 16),
        Expanded(child: Divider(color: AppColors.gray)),
      ],
    );
  }
}
