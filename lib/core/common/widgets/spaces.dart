import 'package:flutter/material.dart';

import '../../utils/constants/app_sizes.dart';

class Spaces {
  Widget verticalSpace1() {
    return const SizedBox(height: AppSizes.smallPadding);
  }

  Widget verticalSpace2() {
    return const SizedBox(height: AppSizes.mediumPadding);
  }

  Widget horizontalSpace1() {
    return const SizedBox(width: AppSizes.smallPadding);
  }

  Widget horizontalSpace2() {
    return const SizedBox(width: AppSizes.mediumPadding);
  }
}