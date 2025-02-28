import 'dart:ui';

import 'package:flutter/material.dart';

import '../../utils/constants/app_colors.dart';

class FrostedGlassBox extends StatelessWidget {
  final double? height;
  final double? width;
  final double? borderRadiusVal;
  final Widget child;
  const FrostedGlassBox({super.key, this.height, this.width, required this.child, this.borderRadiusVal});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          height: 300,
          width: width,
          color: Colors.transparent,
          child: Stack(
            children: [
              
              // blur effect
              BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: 4.0,
                  sigmaY: 4.0,
                ),
                child: Container(
                  height: 300,
                  width: 300,
                ),
              ),
          
              // gradiant effect
              Container(
                height: 300,
                width: width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(borderRadiusVal ?? 4),
                  border: Border.all(color: AppColors.context(context).contentBoxColor.withOpacity(.13)),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      AppColors.context(context).contentBoxColor.withOpacity(.02),
                      AppColors.context(context).contentBoxColor.withOpacity(.05),
                    ]
                  )
                ),
              ),
          
              // child
              child
            ],
          ),
        );
      },
    );
  }
}