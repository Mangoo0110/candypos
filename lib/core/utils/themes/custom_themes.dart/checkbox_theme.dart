import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';

class DCheckboxTheme {
  DCheckboxTheme._(); // Private constructor

  // Light CheckboxThemeData
  static CheckboxThemeData lightCheckboxTheme = CheckboxThemeData(
    fillColor: MaterialStateProperty.all(AppColors.light().buttonTextColor),
    checkColor: MaterialStateProperty.all(AppColors.light().textColor),
    splashRadius: 20,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(4),
    ),
  );

  // Dark CheckboxThemeData
  static CheckboxThemeData darkCheckboxTheme = CheckboxThemeData(
    fillColor: MaterialStateProperty.all(AppColors.dark().buttonTextColor),
    checkColor: MaterialStateProperty.all(AppColors.dark().textColor),
    splashRadius: 20,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(4),
    ),
  );
}