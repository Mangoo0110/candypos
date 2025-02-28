import 'package:flutter/material.dart';
import '../../constants/app_colors.dart'; // Assuming you have this file for color constants

class DDividerTheme {
  DDividerTheme._(); // Private constructor

  // Light DividerThemeData
  static DividerThemeData lightDividerTheme = DividerThemeData(
    color: AppColors.light().dividerColor, // Assuming you have this color defined
    thickness: 1.0, // Define the thickness of the divider
    indent: 16.0, // Define the starting indent of the divider
    endIndent: 16.0, // Define the ending indent of the divider
  );

  // Dark DividerThemeData
  static DividerThemeData darkDividerTheme = DividerThemeData(
    color: AppColors.dark().dividerColor, // Assuming you have this color defined
    thickness: 1.0, // Define the thickness of the divider
    indent: 16.0, // Define the starting indent of the divider
    endIndent: 16.0, // Define the ending indent of the divider
  );
}
