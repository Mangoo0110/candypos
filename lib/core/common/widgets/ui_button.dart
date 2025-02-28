import 'package:flutter/material.dart';

import '../../utils/constants/app_colors.dart';



enum ButtonTapActionState {
  idle,
  active,
  loading,
  success,
  error
}


class UiButton extends StatefulWidget {
  final bool? tappable;
  final Widget child;
  final Widget? activeChild;
  final BorderRadius? borderRadius;
  /// Waits for 350 milliseconds before calling the onTap function
  final VoidCallback onTap;
  const UiButton({super.key, this.tappable = true, required this.child, this.activeChild, required this.borderRadius, required this.onTap});

  @override
  State<UiButton> createState() => _UiButtonState();
}

class _UiButtonState extends State<UiButton> {

  
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Material(
          color: Colors.transparent,
          borderRadius: widget.borderRadius,
          child: widget.tappable == false ?
           widget.child
           : 
           InkWell(
              splashColor: AppColors.context(context).textColor.withOpacity(0.7),
              onTap: () {
                Future.delayed(const Duration(milliseconds: 350)).then((_){
                  widget.onTap();
                });
              },
              borderRadius: widget.borderRadius,
              child: widget.child,
            ),
        );
      },
    );
  }
}