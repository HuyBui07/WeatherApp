import 'dart:math';
import 'package:flutter/material.dart';

class ScaleSize {
  static double sizeScaleFactor(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    const double baseWidth = 1920.0;
    const double baseHeight = 1080.0;

    final double widthScale = width / baseWidth;
    final double heightScale = height / baseHeight;

    // Use the smaller scale factor to ensure content fits both dimensions
    return min(widthScale, heightScale);
  }
}