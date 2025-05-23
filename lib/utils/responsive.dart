import 'package:flutter/material.dart';
import 'dart:math';

class Responsive {
  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 650;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width < 1100 &&
      MediaQuery.of(context).size.width >= 650;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 1100;

  static double getWidth(BuildContext context) {
    if (isDesktop(context)) {
      return MediaQuery.of(context).size.width * 0.25;
    } else if (isTablet(context)) {
      return MediaQuery.of(context).size.width * 0.4;
    } else {
      return MediaQuery.of(context).size.width * 0.9;
    }
  }

  static double getPadding(BuildContext context) {
    if (isDesktop(context)) {
      return 40;
    } else if (isTablet(context)) {
      return 20;
    } else {
      return 16;
    }
  }

  static double sizeScaleFactor(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    double val = (width / 1080) * 0.8;
    return max(min(val, 1), 0.8);
  }
}
