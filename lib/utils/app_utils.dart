import 'package:flutter/material.dart';

class AppUtils {
  static double calculateDynamicWidth(BuildContext context, double multiplier) {
    double screenWidth = MediaQuery.of(context).size.width;
    return screenWidth * multiplier;
  }

// You can add more utility functions here
  static double calculateDynamicMargin(BuildContext context, double multiplier) {
    double screenHeight = MediaQuery.of(context).size.height;
    return screenHeight * multiplier;
  }
}
