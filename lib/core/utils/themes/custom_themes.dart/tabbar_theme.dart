import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';

import '../../constants/app_sizes.dart';

class DTabBarTheme {
  DTabBarTheme._(); // Private constructor

  // Light TabBarTheme
  static TabBarTheme lightTabBarTheme = TabBarTheme(
    indicatorColor: AppColors.light().textColor, // Color of the tab indicator
    labelColor: AppColors.light().textColor, // Color of the selected tab's label
    unselectedLabelColor: AppColors.light().textColor.withOpacity(.6), // Color of the unselected tab's label
    labelStyle: const TextStyle(fontSize: AppSizes.mediumTextSize, fontWeight: FontWeight.bold), // Style of the selected tab's label
    unselectedLabelStyle: const TextStyle(fontSize: AppSizes.mediumTextSize, fontWeight: FontWeight.normal), // Style of the unselected tab's label
    indicatorSize: TabBarIndicatorSize.tab, // Size of the tab indicator (tab or label)
  );

  // Dark TabBarTheme
  static TabBarTheme darkTabBarTheme = TabBarTheme(
    indicatorColor: AppColors.dark().textColor, // Color of the tab indicator
    labelColor: AppColors.dark().textColor, // Color of the selected tab's label
    unselectedLabelColor: AppColors.dark().textColor.withOpacity(.7), // Color of the unselected tab's label
    labelStyle: const TextStyle(fontSize: AppSizes.mediumTextSize, fontWeight: FontWeight.normal), // Style of the selected tab's label
    unselectedLabelStyle: const TextStyle(fontSize: AppSizes.mediumTextSize, fontWeight: FontWeight.normal), // Style of the unselected tab's label
    indicatorSize: TabBarIndicatorSize.label, // Size of the tab indicator (tab or label)
  );
}