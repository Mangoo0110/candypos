
// import '../../../../../core/utils/constants/app_colors.dart';
// import '../../../../../core/utils/constants/app_sizes.dart';
// import 'package:flutter/material.dart';

// class UpdateItemImageWidget extends StatefulWidget {

//   const UpdateItemImageWidget({super.key});

//   @override
//   State<UpdateItemImageWidget> createState() => _UpdateItemImageWidgetState();
// }

// class _UpdateItemImageWidgetState extends State<UpdateItemImageWidget> {

  
//   @override
//   Widget build(BuildContext context) {
//     final double imageBoxH = 130, textH = 50;
//     final double boxH = imageBoxH + textH, boxW = 180; 
//     return 
//       LayoutBuilder(
//         builder: (context, constraints) {
//           return Container(
//             // width: boxW,
//             // height: boxH,
//             decoration: BoxDecoration(
//               color: AppColors.context(context).contentBoxGreyColor,
//             ),
//             child: Padding(
//               padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   Container(
//                     width: boxW,
//                     height: imageBoxH,
//                     decoration: BoxDecoration(
//                       border: Border.all(color: Colors.grey),
//                       borderRadius: AppSizes.verySmallBorderRadius,
//                     ),
//                     child: Icon(Icons.image, size: 50, color: Colors.grey),
//                   ),
//                   Material(
//                     color: Colors.transparent,
//                     child: InkWell(
//                       splashColor: AppColors.context(context).textColor,
//                       borderRadius: AppSizes.verySmallBorderRadius,
//                       onTap: () {
                        
//                       },
//                       child: SizedBox(
//                         height: textH,
//                         width: boxW,
//                         child: Center(
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             children: [
//                               Icon(Icons.upload, color: AppColors.context(context).accentColor),
//                               SizedBox(width: 10,),
//                               Text('Upload', style: Theme.of(context).textTheme.labelLarge?.copyWith(color: AppColors.context(context).accentColor),),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           );
//         }
//       );
//   }
// }