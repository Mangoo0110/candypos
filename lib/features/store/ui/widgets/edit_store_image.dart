// import 'dart:math';
// import 'dart:typed_data';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// import '../../../../core/utils/constants/app_colors.dart';
// import '../../../image/ui/widgets/upload_image.dart';
// import '../providers/modify_store_provider.dart';

// class EditBranchImageWidget extends StatefulWidget {
//   const EditBranchImageWidget({super.key});

//   @override
//   State<EditBranchImageWidget> createState() => _EditBranchImageWidgetState();
// }

// class _EditBranchImageWidgetState extends State<EditBranchImageWidget> {
  

//   @override
//   Widget build(BuildContext context) {

//     Uint8List? branchImage = null;//context.watch<ModifyBranchProvider>().branchImage;
//     return LayoutBuilder(
//       builder: (context, constraints) {
//         return Row(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Container(
//               height: min(130, constraints.maxWidth / 2),
//               width: min(130, constraints.maxWidth / 2),
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(8)
//               ),
//               child: branchImage  == null 
//                 ? Icon(Icons.image, color: AppColors.context(context).textColor.withOpacity(.8),) 
//                 : Image.memory(branchImage),
//             ),
//             SizedBox(
//               height: 60,
//               width: constraints.maxWidth / 2,
//               child: Padding(
//                 padding: const EdgeInsets.only(right: 4.0),
//                 child: FittedBox(
//                   fit: BoxFit.scaleDown,
//                   child: UploadImage(
//                     onPick: (pickedImage) {
//                       //context.read<ModifyBranchProvider>().setImage(pickedImage);
//                     },
//                   ),
//                 ),
//               ),
//             )
//           ],
//         );
//       },
//     );
//   }

// }