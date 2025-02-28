
// import 'package:candypos/core/utils/constants/app_colors.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:flutter_animate/flutter_animate.dart';

// import '../widgets/keybuttons_widget.dart';
// import '../widgets/keypad_item_suggestion_widget.dart';
// import '../widgets/keypad_text_widget.dart';


// class KeypadTab extends StatefulWidget {
//   const KeypadTab({super.key});

//   @override
//   State<KeypadTab> createState() => _KeypadTabState();
// }

// class _KeypadTabState extends State<KeypadTab> {

//   @override
//   void initState() {
//     // TODO: implement initState    
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {

    

//     return LayoutBuilder(
//       builder: (context, constraints) {
        
//         double textfieldheight = constraints.maxHeight / 2.5;
//         double textfieldWidth = constraints.maxWidth;
//         return Column(
//           //crossAxisAlignment: CrossAxisAlignment.end,
//           mainAxisAlignment: MainAxisAlignment.end,
//           children: [
//             Column(
//               children: [
//                 Container(
//                   height: textfieldheight * .45,
//                   width: textfieldWidth,
//                   decoration: BoxDecoration(
//                     color: AppColors.context(context).backgroundColor
//                   ),
//                   child: const KeypadItemSuggestionWidget(),
//                 ).animate(),

//                 Container(
//                   height: textfieldheight * .55,
//                   width: textfieldWidth,
//                   decoration: BoxDecoration(
//                     color: AppColors.context(context).backgroundColor
//                   ),
//                   child: const KeypadTextWidget()
//                 ).animate(),
              
//               ],
//             ),
//             Container(
//               height: constraints.maxHeight - textfieldheight,
//               width: constraints.maxWidth,
//               color: AppColors.context(context).backgroundColor,
//               child: const KeybuttonsWidget())
//           ],
//         ).animate().fadeIn(duration: const Duration(milliseconds: 200), curve: Curves.easeIn);
//       },
//     );
//   }

  
  
// }