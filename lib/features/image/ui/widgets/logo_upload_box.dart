// import 'dart:math';


// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// import '../../../../core/utils/constants/app_colors.dart';
// import '../../../../core/utils/func/dekhao.dart';
// import '../../../../core/utils/image/image_loader_func.dart';
// import '../../../image/ui/providers/image_write_provider.dart';

// class ImageShowUpload extends StatefulWidget {
//   final double? radius;
//   final String? imageUrl;
//   const ImageShowUpload({super.key, required this.radius, this.imageUrl});

//   @override
//   State<ImageShowUpload> createState() => _ImageShowUploadState();
// }

// class _ImageShowUploadState extends State<ImageShowUpload> {

//   @override
//   void initState() {
//     // TODO: implement initState
//     context.read<ImageWriteProvider>().init(existingImageUrl: widget.imageUrl);
//     super.initState();
//   }
  
//   @override
//   Widget build(BuildContext context) {
//     return LayoutBuilder(
//       builder: (context, constraints) {
//         return Container(
//           height: constraints.maxHeight,
//           width: constraints.maxWidth,

//           child: Stack(
//             alignment: Alignment.topLeft,
//             children: [
//               ClipOval(
//                 child: Container(
//                   height: widget.radius ?? min(140, constraints.maxWidth ),
//                   width: widget.radius ?? min(140, constraints.maxWidth),
//                   decoration: BoxDecoration(
//                     color: AppColors.context(context).textColor,
//                     borderRadius: BorderRadius.circular(8000000)
//                   ),
//                   child: context.watch<ImageWriteProvider>().image == null 
//                     ? Icon(
//                         Icons.image, 
//                         color: AppColors.context(context).textColor.withOpacity(.7), 
//                         size: min(140, constraints.maxWidth / 2) - 6,
//                       )
//                     : Image.memory(context.watch<ImageWriteProvider>().image!, fit: BoxFit.cover,),
//                 ),
//               ),
//               Positioned(
//                 bottom: 8,
//                 left: min(140, constraints.maxWidth) - 40,
//                 child: InkWell(
//                   onTap: () async{
//                     await pickImage().then((value) {
//                       dekhao("value fetched");
//                       if(value != null && context.mounted) {
//                         context.read<ImageWriteProvider>().changeImage(value);
//                       }
//                     });
//                   },
//                   child: CircleAvatar(
//                     backgroundColor: AppColors.context(context).backgroundColor,
//                     child: Padding(
//                       padding: const EdgeInsets.all(4.0),
//                       child: CircleAvatar(
//                         backgroundColor: AppColors.context(context).accentColor,
//                         child:  Padding(
//                           padding: const EdgeInsets.all(2.0),
//                           child: Icon(
//                             Icons.camera_alt,
//                             color: AppColors.context(context).backgroundColor,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               )
//             ],
//           ),
//         );
//       },
//     );
//   }

// }