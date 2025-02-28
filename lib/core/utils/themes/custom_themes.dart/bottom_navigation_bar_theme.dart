import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';

class DBottomNavigationBarThemes {
  DBottomNavigationBarThemes._(); // Private constructor

  // Light BottomNavigationBarTheme
  static BottomNavigationBarThemeData lightBottomNavTheme = BottomNavigationBarThemeData(
    backgroundColor: AppColors.light().backgroundColor, // Background color for the bottom navigation bar
    selectedItemColor: AppColors.light().textColor, // Color of the selected item
    unselectedItemColor: AppColors.light().textColor.withOpacity(.5), // Color of unselected items
    selectedIconTheme: IconThemeData(
      color: AppColors.light().accentColor, // Icon color for the selected item
      size: 24, // Icon size for the selected item
    ),
    unselectedIconTheme: IconThemeData(
      color: AppColors.light().contentBoxColor, // Icon color for unselected items
      size: 24, // Icon size for unselected items
    ),
    selectedLabelStyle: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.bold,
      color: AppColors.light().textColor, // Text style for the selected label
    ),
    unselectedLabelStyle: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.normal,
      color: AppColors.light().contentBoxColor, // Text style for unselected labels
    ),
    showSelectedLabels: true, // Whether or not to show labels for selected items
    showUnselectedLabels: true, // Whether or not to show labels for unselected items
    elevation: 8.0, // Elevation of the bottom navigation bar
  );

  // Dark BottomNavigationBarTheme
  static BottomNavigationBarThemeData darkBottomNavTheme = BottomNavigationBarThemeData(
    backgroundColor: Colors.blue, // Background color for the bottom navigation bar
    selectedItemColor: AppColors.dark().textColor, // Color of the selected item
    unselectedItemColor: AppColors.dark().textColor.withOpacity(.5), // Color of unselected items
    selectedIconTheme: IconThemeData(
      color: AppColors.dark().textColor, // Icon color for the selected item
      size: 24, // Icon size for the selected item
    ),
    unselectedIconTheme: IconThemeData(
      color: AppColors.dark().textColor.withOpacity(.5), // Icon color for unselected items
      size: 24, // Icon size for unselected items
    ),
    selectedLabelStyle: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.bold,
      color: AppColors.dark().textColor, // Text style for the selected label
    ),
    unselectedLabelStyle: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.normal,
      color: AppColors.dark().textColor.withOpacity(.5), // Text style for unselected labels
    ),
    showSelectedLabels: true, // Whether or not to show labels for selected items
    showUnselectedLabels: true, // Whether or not to show labels for unselected items
    elevation: 8.0, // Elevation of the bottom navigation bar
  );
}