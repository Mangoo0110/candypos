import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';

class DButtonTheme {
  DButtonTheme._(); // Private constructor

  // Light ButtonThemeData
  static ButtonThemeData lightButtonTheme = ButtonThemeData(
    buttonColor: AppColors.light().buttonTextColor,
    textTheme: ButtonTextTheme.primary,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    alignedDropdown: false,
    minWidth: 88,
    height: 36,
    disabledColor: Colors.grey,
    highlightColor: Colors.transparent,
    splashColor: Colors.transparent,
    focusColor: Colors.transparent,
    hoverColor: Colors.transparent,
  );

  // Dark ButtonThemeData
  static ButtonThemeData darkButtonTheme = ButtonThemeData(
    buttonColor: AppColors.dark().buttonTextColor,
    textTheme: ButtonTextTheme.primary,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    alignedDropdown: false,
    minWidth: 88,
    height: 36,
    disabledColor: Colors.grey,
    highlightColor: Colors.transparent,
    splashColor: Colors.transparent,
    focusColor: Colors.transparent,
    hoverColor: Colors.transparent,
  );
}