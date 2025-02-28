// import 'dart:math';
// import 'dart:typed_data';

// import 'package:candypos/core/utils/constants/app_colors.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
// import 'package:flutter/widgets.dart';
// import 'package:flutter_animate/flutter_animate.dart';
// import 'package:provider/provider.dart';

// import '../../../../../core/common/textfields/no_border_textfield.dart';
// import '../../../../inventory/item&variant/domain/entities/item.dart';
// import '../../../domain/entities/sale_item.dart';
// import '../controllers/keypad_typed_data_controller.dart';


// class KeypadItemSuggestionWidget extends StatefulWidget {
//   const KeypadItemSuggestionWidget({super.key});

//   @override
//   State<KeypadItemSuggestionWidget> createState() => _KeypadItemSuggestionWidgetState();
// }

// class _KeypadItemSuggestionWidgetState extends State<KeypadItemSuggestionWidget> {
//   List<SaleItem> suggestions = [];

//   double typedPrice = 0;

//   final TextEditingController _controller = TextEditingController();

//   void suggestItemVariantByPrice() {

//     typedPrice = context.watch<KeypadBillingController>().saleItem!.price;

//     if(!context.read<KeypadBillingController>().userChoosed) {
//       suggestions = context.read<KeypadBillingController>().suggestItemVariantByPrice();
//     }
    
//   }

//   @override
//   Widget build(BuildContext context) {
//     suggestItemVariantByPrice();
//     return LayoutBuilder(
//       builder: (context, constraints) {
//         return Container(
//           height: constraints.maxHeight,
//           width: constraints.maxWidth,
//           decoration: BoxDecoration(
//             color: AppColors.context(context).backgroundColor,
//             borderRadius: BorderRadius.circular(4),
//             border: Border.all(color: AppColors.context(context).contentBoxGreyColor)
//           ),
//           child: 
//             context.read<KeypadBillingController>().saleItem!.price <= 0.0 ?
//             Center(
//               child: Text( 'Type price and available suggestions will appear', style: Theme.of(context).textTheme.bodyMedium, maxLines: 3),
//             )
//             :
//             // context.watch<KeypadBillingController>().userChoosed ?
//             // Hero(
//             //   tag: "${context.read<KeypadBillingController>().saleItem!.itemId}${context.read<KeypadBillingController>().saleItem!.itemName}",
//             //   child: Padding(
//             //     padding: const EdgeInsets.all(8.0),
//             //     child: _choosenItem().animate().fadeIn( duration: const Duration(milliseconds: 300)),
//             //   ),
//             // )
//             //:
//             //suggestions.isEmpty ?
//             Text( 'No suggestions!! \nIf you had variable price items, they would have appeared.', style: Theme.of(context).textTheme.bodyMedium, maxLines: 3)
//             //:
//             // ListView.builder(
//             //   scrollDirection: Axis.horizontal,
//             //   itemCount: suggestions.length,
//             //   itemBuilder: (context, index) {
//             //     return Hero(
//             //       tag: "${suggestions[index].itemId}${suggestions[index].itemName}",
//             //       child: SizedBox(
//             //         height: constraints.maxHeight , 
//             //         width: min(constraints.maxWidth * .55, 200), 
//             //         child: Padding(
//             //           padding: const EdgeInsets.all(2.0),
//             //           child: _itemSuggestionView(billedItem: suggestions[index]),
//             //         )).animate().fadeIn(delay: Duration(milliseconds: 200 * index), duration: const Duration(milliseconds: 200)),
//             //     );
//             //   }
//             // )
//         );
//       },
//     );
//   }

//   // Widget _choosenItem() {

//   //   Item? item = context.read<InventoryDataController>().fetchItemById(itemId: context.read<KeypadBillingController>().saleItem!.itemId);
//   //   Uint8List? thisProductImage = context.read<InventoryDataController>().imageIfExist(imageId: item != null ? item.itemImageId : context.read<KeypadBillingController>().saleItem!.imageId);

//   //   return LayoutBuilder(
//   //     builder: (context, constraints) {

//   //       return Container(
//   //         height: constraints.maxHeight,
//   //         width: constraints.maxWidth,
//   //         decoration: BoxDecoration(
//   //           color: Colors.white,
//   //           borderRadius: BorderRadius.circular(8),
//   //           boxShadow: const [
//   //             BoxShadow(color: Color(0x2F000000), blurRadius: 5)
//   //           ]
//   //           //border: Border.all(color: Colors.black)
//   //         ),
//   //         child: Material(
//   //           color: Colors.transparent,
//   //           child: InkWell(
//   //             borderRadius: BorderRadius.circular(8),
//   //             onTap: () {
//   //               context.read<KeypadBillingController>().removeChoosenItem();
//   //             },
//   //             child: SingleChildScrollView(
//   //               scrollDirection: Axis.horizontal,
//   //               child: Row(
//   //                 children: [
//   //                   SizedBox(
//   //                     height: constraints.maxHeight,
//   //                     width: constraints.maxWidth * .7,
//   //                     child: _itemDescriptionRow(item: item, itemImage: thisProductImage, billedItem: context.read<KeypadBillingController>().saleItem!)
//   //                     ),
//   //                   SizedBox(
//   //                     height: constraints.maxHeight, 
//   //                     width: constraints.maxWidth * .3, 
//   //                     child: Wrap(
//   //                       crossAxisAlignment: WrapCrossAlignment.center,
//   //                       spacing: 4,
//   //                       runSpacing: 1,
//   //                       runAlignment: WrapAlignment.center,
//   //                       children: 'Tap to remove'.split(" ").map((e) => TextWidgets().buttonItalicText(buttonText: e, textColor: AppColors().appTextColorGrey(context: context))).toList(),
//   //                     )
//   //                   ),
//   //                 ],
//   //               ),
//   //             ),
//   //           ),
//   //         ),
//   //       );
//   //     }
//   //   );
//   // }

//   // Widget _itemSuggestionView({required SaleItem billedItem}) {
//   //   Uint8List? thisProductImage;
//   //   ItemModel? item = context.read<InventoryDataController>().fetchItemById(itemId: billedItem.itemId);
//   //   if(item != null) {
//   //     thisProductImage = context.read<InventoryDataController>().imageIfExist(imageId: item.itemImageId);
//   //   }
    
//   //   return LayoutBuilder(
//   //     builder: (context, constraints) {
//   //       return Container(
//   //         height: constraints.maxHeight,
//   //         width: constraints.maxWidth,
//   //         decoration: BoxDecoration(
//   //           color: Colors.white,
//   //           borderRadius: BorderRadius.circular(8),
//   //           boxShadow: const [
//   //             BoxShadow(color: Color(0x1F000000), blurRadius: 5)
//   //           ]
//   //           //border: Border.all(color: Colors.black)
//   //         ),
//   //         child: Material(
//   //           color: Colors.transparent,
//   //           child: InkWell(
//   //             borderRadius: BorderRadius.circular(8),
//   //             onTap: () {
//   //               context.read<KeypadBillingController>().replaceCustomItemWithChoosenItem(billedItem);
//   //             },
//   //             child: _itemDescriptionRow(item: item, itemImage: thisProductImage, billedItem: billedItem)
//   //           ),
//   //         ),
//   //       );
      
//   //     }
//   //   );
  
//   // }

//   Widget _searchBar() {
//     return LayoutBuilder(
//       builder: (context, constraints) {
//         return Container(
//           height: constraints.maxHeight,
//           width: constraints.maxWidth,
//           decoration: BoxDecoration(
//             color: Colors.transparent,
//             border: Border.all(color: AppColors.context(context).textColor),
//             borderRadius: BorderRadius.circular(4),
//           ),
//           child: SizedBox(
//             width: constraints.maxWidth * .4,
//             child: NoBorderTextfield(
//               maxLines: 1, 
//               prefiexIcon: const Icon(Icons.search),
//               onChanged: (text){
                
//               }, 
//               controller: _controller, 
//               hintText: 'Search', 
//               labelText: '', 
//               validationCheck: (text){
                    
//               }
//             )),
//         ).animate().fadeIn(duration: const Duration(milliseconds: 200), curve: Curves.easeIn);
//       }
//     );
//   }

//   // Widget _itemDescriptionRow({required ItemModel? item, required Uint8List? itemImage, required SaleItem billedItem}) {
//   //   return LayoutBuilder(
//   //     builder: (context, constraints) {
//   //       return Row(
//   //         mainAxisSize: MainAxisSize.min,
//   //         crossAxisAlignment: CrossAxisAlignment.center,
//   //         mainAxisAlignment: MainAxisAlignment.start,
//   //         children: [
//   //           SizedBox(
//   //             height: min(min(constraints.maxHeight, constraints.maxWidth * .4,), 80), 
//   //             width: min(min(constraints.maxHeight, constraints.maxWidth * .4,), 80),
//   //             child: Padding(
//   //               padding: const EdgeInsets.all(2.0),
//   //               child: ShowRoundImage(
//   //                 image: itemImage, 
//   //                 borderRadius: 8,
//   //                 ),
//   //             ),
//   //           ),
                      
//   //           SizedBox(
//   //             height: constraints.maxHeight, 
//   //             width: constraints.maxWidth - min(min(constraints.maxHeight, constraints.maxWidth * .4,), 80), 
//   //             child: Align(
//   //               alignment: Alignment.centerLeft,
//   //               child: Padding(
//   //                 padding: const EdgeInsets.only(left: 4.0),
//   //                 child: TextWidgets().highLightTextSize(
//   //                   text: item != null ? "${item.itemName}(${billedItem.variantName})" : billedItem.itemName, 
//   //                   textColor: AppColors().appTextColor(context: context), fontSize: 12
//   //                 ),
//   //               ),
//   //             )
//   //           ),
//   //         ],
//   //       );
                  
//   //     },
//   //   );
//   // }
// }