import 'package:flutter/material.dart';

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
}
