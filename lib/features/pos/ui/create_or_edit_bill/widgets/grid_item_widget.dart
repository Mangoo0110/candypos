// import 'dart:typed_data';

// import 'package:easypos/core/common/widgets/image_related/show_rect_image.dart';
// import 'package:easypos/core/common/widgets/text_widgets.dart';
// import 'package:easypos/features/billing/data/models/sale_item_model.dart';
// import 'package:easypos/features/inventory/item/data/models/item_model.dart';
// import 'package:easypos/ui/billing/billing_dashboard/controllers/billing_data_fetch_controller.dart';
// import 'package:easypos/ui/inventory/dashboard/controllers/inventory_data_controller.dart';
// import 'package:easypos/core/utils/app_colors.dart';
// import 'package:easypos/core/utils/app_textstyles.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// import '../../../../features/billing/data/models/bill_model.dart';

// class GridItemWidget extends StatefulWidget {
//   final ItemModel item;
//   const GridItemWidget({super.key, required this.item});

//   @override
//   State<GridItemWidget> createState() => _GridItemWidgetState();
// }

// class _GridItemWidgetState extends State<GridItemWidget> {

//   BillModel? currentBill;

//   @override
//   Widget build(BuildContext context) {
//     currentBill = context.read<BillingDataFetchProvider>().currentBill;

//     return LayoutBuilder(
//       builder: (context, constraints) {
//         if(currentBill == null) {
//           return Container();
//         }
//         ItemModel thisItem = widget.item;
//         Uint8List? thisProductImage = context.watch<InventoryDataController>().idMappedInventoryImages[thisItem.itemImageId];
        
//         return Container(
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(8),
//             boxShadow: const [
//               BoxShadow(color: Color(0x1F000000), blurRadius: 5)
//             ]
//             //border: Border.all(color: Colors.black)
//           ),
//           child: Material(
//             color: Colors.transparent,
//             child: InkWell(
//               onTap: () {
                
//               },
//               child: Column(
//                 mainAxisSize: MainAxisSize.max,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Column(
//                     children: [
//                       Padding(
//                         padding: const EdgeInsets.all(2.0),
//                         child: ShowRectImage(
//                           image: thisProductImage, 
//                           height: constraints.maxWidth / (constraints.maxWidth / 175).ceil() * (.6), 
//                           width: constraints.maxWidth,
//                           borderRadius: 8,
//                           ),
//                       ),
              
//                       Padding(
//                         padding: const EdgeInsets.only(top: 2.0),
//                         child: TextWidgets().buttonText(buttonText: thisItem.itemName, textColor: AppColors().appTextColor(context: context))
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         );
//       }
//     );
//   }

//   Widget _priceQuantity({required double selectedQuantity, required double price}) {
//     return LayoutBuilder(
//       builder: (context, constraints) {
//         return Column(
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 TextWidgets().buttonText(buttonText: 'Price: ', textColor: Colors.grey),
//                 TextWidgets().buttonText(buttonText: price.toString(), textColor: Colors.black),
//               ],
//             ),
//             Flexible(
//               child: Padding(
//                 padding: const EdgeInsets.only(top: 2.0),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     TextWidgets().buttonText(buttonText: 'Qty: ', textColor: Colors.grey),
//                     Flexible(child: TextWidgets().buttonText(buttonText: selectedQuantity.toString(), textColor: Colors.black)),
//                   ],
//                 ),
//               ),
//             )
//           ],
//         );            
//       },
//     );
//   }
// }