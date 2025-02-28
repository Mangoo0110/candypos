// import 'dart:math';


// import '../../../image/ui/widgets/upload_image.dart';
// import '../providers/register_provider.dart';

// class InputImageWidget extends StatefulWidget {
//   const InputImageWidget({super.key});

//   @override
//   State<InputImageWidget> createState() => _InputImageWidgetState();
// }

// class _InputImageWidgetState extends State<InputImageWidget> {
  
//   @override
//   Widget build(BuildContext context) {
//     final storeImage = context.watch<RegisterProvider>().storeImage;

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
//               child: storeImage == null 
//                 ? Icon(
//                     Icons.image, 
//                     color: Theme.of(context).brightness == Brightness.dark ? AppColors.dark().textColor.withOpacity(.8) : AppColors.light().textColor.withOpacity(.8), 
//                     size: min(130, constraints.maxWidth / 2) - 6,
//                   )
//                 : Image.memory(storeImage, fit: BoxFit.cover,)
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
//                       context.read<RegisterProvider>().setImage(pickedImage);
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