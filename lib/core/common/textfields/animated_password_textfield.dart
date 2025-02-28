
// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';

// import '../enums/widget_enums.dart';

// class AnimatedPasswordTextFormField extends StatefulWidget {
//   const AnimatedPasswordTextFormField({
//     super.key,
//     this.interval = const Interval(0.0, 1.0),
//     required this.animatedWidth,
//     this.loadingController,
//     this.inertiaController,
//     this.inertiaDirection,
//     this.enabled = true,
//     this.labelText,
//     this.keyboardType,
//     this.textInputAction,
//     this.controller,
//     this.focusNode,
//     this.validator,
//     this.onFieldSubmitted,
//     this.onSaved,
//     this.autofillHints,
//     required this.initialIsoCode,
//   }) : assert(
//           (inertiaController == null && inertiaDirection == null) ||
//               (inertiaController != null && inertiaDirection != null),
//         );

//   final Interval? interval;
//   final AnimationController? loadingController;
//   final AnimationController? inertiaController;
//   final double animatedWidth;
//   final bool enabled;
//   final String? labelText;
//   final TextInputType? keyboardType;
//   final TextInputAction? textInputAction;
//   final TextEditingController? controller;
//   final FocusNode? focusNode;
//   final FormFieldValidator<String>? validator;
//   final ValueChanged<String>? onFieldSubmitted;
//   final FormFieldSetter<String>? onSaved;
//   final TextFieldInertiaDirection? inertiaDirection;
//   final Iterable<String>? autofillHints;
//   final String? initialIsoCode;

//   @override
//   State<AnimatedPasswordTextFormField> createState() =>
//       _AnimatedPasswordTextFormFieldState();
// }

// class _AnimatedPasswordTextFormFieldState
//     extends State<AnimatedPasswordTextFormField> {
//   var _obscureText = true;

//   @override
//   Widget build(BuildContext context) {
//     return AnimatedTextFormField(
//       interval: widget.interval,
//       loadingController: widget.loadingController,
//       inertiaController: widget.inertiaController,
//       width: widget.animatedWidth,
//       enabled: widget.enabled,
//       autofillHints: widget.autofillHints,
//       labelText: widget.labelText,
//       prefixIcon: const Icon(Icons.lock, size: 20),
//       suffixIcon: GestureDetector(
//         onTap: () => setState(() => _obscureText = !_obscureText),
//         dragStartBehavior: DragStartBehavior.down,
//         child: AnimatedCrossFade(
//           duration: const Duration(milliseconds: 250),
//           firstCurve: Curves.easeInOutSine,
//           secondCurve: Curves.easeInOutSine,
//           alignment: Alignment.center,
//           layoutBuilder: (Widget topChild, _, Widget bottomChild, __) {
//             return Stack(
//               alignment: Alignment.center,
//               children: <Widget>[bottomChild, topChild],
//             );
//           },
//           firstChild: const Icon(
//             Icons.visibility,
//             size: 25.0,
//             semanticLabel: 'show password',
//           ),
//           secondChild: const Icon(
//             Icons.visibility_off,
//             size: 25.0,
//             semanticLabel: 'hide password',
//           ),
//           crossFadeState: _obscureText
//               ? CrossFadeState.showFirst
//               : CrossFadeState.showSecond,
//         ),
//       ),
//       obscureText: _obscureText,
//       keyboardType: widget.keyboardType,
//       textInputAction: widget.textInputAction,
//       controller: widget.controller,
//       focusNode: widget.focusNode,
//       validator: widget.validator,
//       onFieldSubmitted: widget.onFieldSubmitted,
//       onSaved: widget.onSaved,
//       inertiaDirection: widget.inertiaDirection,
//       initialIsoCode: widget.initialIsoCode,
//     );
//   }
// }