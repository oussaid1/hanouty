import 'package:flutter/material.dart';

class AppConstants {
  static const double radius = (6.0);
  static const double padding = (8.0);
  static const double margin = (8.0);
  static const double borderRadius = (6.0);
  static const double borderWidth = (2.0);
  static const double opacity = (0.2);
  static final Color greenOpacity =
      AppConstants.greenOpacity.withOpacity(opacity);
  static final Color whiteOpacity = Colors.white.withOpacity(opacity);
  static final Color blackOpacity = Colors.black.withOpacity(opacity);
  static final Color hintColor =
      const Color.fromARGB(255, 36, 36, 36).withOpacity(0.6);
  static const Color primaryColor = Color.fromARGB(255, 235, 166, 150);
  // list of colors
  static const List<Color> myGradients = [Color(0xD52A76DA), Color(0xBDD43FCD)];
}
