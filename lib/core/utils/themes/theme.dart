import 'custom_themes.dart/divider_theme.dart';
import 'custom_themes.dart/input_decoration_theme.dart';
import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import 'custom_themes.dart/appbar_theme.dart';
import 'custom_themes.dart/bottom_navigation_bar_theme.dart';
import 'custom_themes.dart/bottomappbar_theme.dart';
import 'custom_themes.dart/bottomsheet_theme.dart';
import 'custom_themes.dart/button_theme.dart';
import 'custom_themes.dart/card_theme.dart';
import 'custom_themes.dart/checkbox_theme.dart';
import 'custom_themes.dart/icon_theme.dart';
import 'custom_themes.dart/tabbar_theme.dart';
import 'custom_themes.dart/text_theme.dart';


class AppTheme{
  AppTheme._();

  static ThemeData lightTheme = ThemeData(
    primaryTextTheme: DTextTheme.lightTextTheme,
    primaryColorLight: AppColors.light().backgroundColor,
    primaryColorDark: AppColors.light().textColor,
    useMaterial3: true,
    fontFamily: 'Poppins',
    brightness: Brightness.light,
    colorScheme: ColorScheme.fromSwatch(
        backgroundColor: AppColors.light().backgroundColor,
        cardColor: AppColors.light().backgroundColor,
        brightness: Brightness.light
      ),
    scaffoldBackgroundColor: AppColors.light().backgroundColor,
    inputDecorationTheme: DInputDecorationTheme.lightTheme,
    primaryColor: AppColors.light().primaryColor,
    textTheme: DTextTheme.lightTextTheme,
    iconTheme: DIconTheme.lightIconTheme,
    appBarTheme: DAppBarTheme.lightAppBarTheme,
    buttonTheme: DButtonTheme.lightButtonTheme,
    bottomSheetTheme: DBottomSheetTheme.lightBottomSheetTheme,
    checkboxTheme: DCheckboxTheme.lightCheckboxTheme,
    bottomAppBarTheme: DBottomAppBarTheme.lightBottomAppBarTheme,
    cardTheme: DCardTheme.lightCardTheme,
    bottomNavigationBarTheme: DBottomNavigationBarThemes.lightBottomNavTheme,
    tabBarTheme: DTabBarTheme.lightTabBarTheme,
    indicatorColor: AppColors.light().backgroundColor,
    dividerTheme: DDividerTheme.lightDividerTheme,
  );

  static ThemeData darkTheme = ThemeData(
    primaryTextTheme: DTextTheme.darkTextTheme,
    primaryColorLight: AppColors.dark().textColor,
    primaryColorDark: AppColors.dark().backgroundColor,
    useMaterial3: true,
    fontFamily: 'Poppins',
    brightness: Brightness.dark,
    colorScheme: ColorScheme.fromSwatch(
        backgroundColor: AppColors.dark().backgroundColor,
        cardColor: AppColors.dark().backgroundColor,
        brightness: Brightness.dark
      ),
    scaffoldBackgroundColor: AppColors.dark().backgroundColor,
    primaryColor: AppColors.dark().primaryColor,
    textTheme: DTextTheme.darkTextTheme,
    inputDecorationTheme: DInputDecorationTheme.darkTheme,
    iconTheme: DIconTheme.darkIconTheme,
    appBarTheme: DAppBarTheme.darkAppBarTheme,
    buttonTheme: DButtonTheme.darkButtonTheme,
    bottomSheetTheme: DBottomSheetTheme.darkBottomSheetTheme,
    checkboxTheme: DCheckboxTheme.darkCheckboxTheme,
    bottomAppBarTheme: DBottomAppBarTheme.darkBottomAppBarTheme,
    cardTheme: DCardTheme.darkCardTheme,
    tabBarTheme: DTabBarTheme.darkTabBarTheme,
    bottomNavigationBarTheme: DBottomNavigationBarThemes.darkBottomNavTheme,
    dividerTheme: DDividerTheme.darkDividerTheme,
    //tabBarTheme: ,
    indicatorColor: AppColors.dark().textColor
  );
}