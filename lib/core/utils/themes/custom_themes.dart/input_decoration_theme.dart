import 'text_theme.dart';
import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';

class DInputDecorationTheme {
  DInputDecorationTheme._(); // Private constructor

  // Light InputDecorationTheme
  static InputDecorationTheme lightTheme = InputDecorationTheme(
    //filled: true,
    //contentPadding: const EdgeInsets.only(left: 4, right: 4),
    fillColor: AppColors.light().fillColor,
    focusColor: AppColors.light().textColor,
    hoverColor: AppColors.light().textColor,
    outlineBorder: BorderSide(color: AppColors.light().textColor),
    hintStyle: TextStyle(color: AppColors.light().hintColor), 
    labelStyle: TextStyle(color: AppColors.light().labelColor),
    border: UnderlineInputBorder(
      borderRadius: BorderRadius.circular(0), 
      borderSide: BorderSide(color: AppColors.light().borderColor), 
    ),
    focusedBorder: UnderlineInputBorder(
      borderRadius: BorderRadius.circular(0), 
      borderSide: BorderSide(color: AppColors.light().focusedBorderColor, width: 2), 
    ),
    enabledBorder: UnderlineInputBorder(
      borderRadius: BorderRadius.circular(0), 
      borderSide: BorderSide(color: AppColors.light().enabledBorderColor),
    )
  );

  // Dark InputDecorationTheme 
  static InputDecorationTheme darkTheme = InputDecorationTheme(
    //filled: true,
    //contentPadding: const EdgeInsets.only(left: 4, right: 4),
    fillColor: AppColors.dark().fillColor, 
    focusColor: AppColors.dark().textColor,
    hoverColor: AppColors.dark().textColor,
    hintStyle: TextStyle(color: AppColors.dark().hintColor), 
    labelStyle: TextStyle(color: AppColors.dark().labelColor),
    outlineBorder: BorderSide(color: AppColors.dark().textColor),
    border: UnderlineInputBorder(
      borderRadius: BorderRadius.circular(0), 
      borderSide: BorderSide(color: AppColors.dark().borderColor), 
    ),
    focusedBorder: UnderlineInputBorder(
      borderRadius: BorderRadius.circular(0), 
      borderSide: BorderSide(color: AppColors.dark().focusedBorderColor, width: 2), 
    ),
    enabledBorder: UnderlineInputBorder(
      borderRadius: BorderRadius.circular(0), 
      borderSide: BorderSide(color: AppColors.dark().enabledBorderColor, width: 1), 
    ),
  );
}
