// import 'dart:collection';
// import 'dart:typed_data';

// import 'package:easypos/common/widgets/money.dart';
// import 'package:easypos/common/widgets/text_widgets.dart';
// import 'package:easypos/models/h1_bill_model.dart';
// import 'package:easypos/models/h2_billed_item.dart';
// import 'package:easypos/models/h7_billed_modifier.dart';
// import 'package:easypos/models/h13_item_model.dart';
// import 'package:easypos/pages/store/controller/store_data_controller.dart';
// import 'package:easypos/pages/store/screens/billing/controller/billing_data_controller.dart';
// import 'package:easypos/pages/store/screens/inventory/controller/inventory_data_controller.dart';
// import 'package:easypos/utils/app_colors.dart';
// import 'package:easypos/utils/app_sizes.dart';
// import 'package:easypos/utils/dekhao.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// class EditBilledItemWidget extends StatefulWidget {
//   final BilledItem billedItem;
//   final Function (BilledItem billedItem) onDone;
//   const EditBilledItemWidget({super.key, required this.billedItem, required this.onDone});

//   @override
//   State<EditBilledItemWidget> createState() => _EditBilledItemWidgetState();
// }

// class _EditBilledItemWidgetState extends State<EditBilledItemWidget> {
//   final _formKey = GlobalKey<FormState>();
//   late BilledItem billedItem;
//   HashMap<String, BilledModifierModel> billedModifierList = HashMap<String, BilledModifierModel>();
//   ItemModel? actualProduct;

//   final TextEditingController _quantityInputcontroller = TextEditingController();
//   Uint8List? productImage;

//   BillModel? currentBill;

//   @override
//   void initState() {
//     // TODO: implement initState
//     billedItem = widget.billedItem;

//     for(final billedModifier in billedItem.modifierList) {
//       billedModifierList[billedModifier.modifierGroupId] = billedModifier;
//     }

//     actualProduct = context.read<InventoryDataController>().fetchItemById(itemId: billedItem.itemId);
//     _quantityInputcontroller.text = billedItem.quantity.toString();
//     super.initState();
//   }

//   @override
//   void dispose() {
//     // TODO: implement dispose
//     //widget.onDone(double.tryParse(controller.text) ?? 0);
//     _quantityInputcontroller.dispose();
//     super.dispose();
//   }
//   @override
//   Widget build(BuildContext context) {
//     productImage = context.read<StoreDataController>().imageIfExist(imageId: widget.billedItem.itemImageId);
//     currentBill = context.watch<BillingDataController>().currentBill;
//     if(productImage == null) {
//       dekhao("image is null");
//     }
//     return LayoutBuilder(
//       builder: (context, constraints) {
//         return Scaffold(
//           body: Column(
//             children: [
//               _billedItemsOfSameProduct(),

//             ],
//           ),
//         );
//       },
//     );
//   }

//   Widget _billedItemsOfSameProduct() {
//     Map<int, BilledItem> billedItemsOfSameProduct = currentBill!.searchItem(itemId: billedItem.itemId);

//     if(billedItemsOfSameProduct.isEmpty) {
//       return Container();
//     }
//     return SingleChildScrollView(
//       scrollDirection: Axis.horizontal,
//       child: Row(
//         children: billedItemsOfSameProduct.entries.map((mapEntry) {
//           return Padding(
//             padding: const EdgeInsets.all(2.0),
//             child: Container(
//               decoration: BoxDecoration(
//                 border: Border.all(color: AppColors().appTextColor(context: context)),
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.all(6.0),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     TextWidgets().highLightText(text: mapEntry.value.itemName, textColor: AppColors().appTextColor(context: context)),
//                     Padding(
//                       padding: const EdgeInsets.only(top: 4.0),
//                       child: TextWidgets().highLightText(text: "(${mapEntry.value.billedVariant == null ? '' : mapEntry.value.billedVariant!.variantName})", textColor: AppColors().appTextColor(context: context)),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.only(top: 8.0),
//                       child: TextWidgets().highLightText(text: Money().moneyText(moneyValue: mapEntry.value.totalPrice), textColor: AppColors().appTextColor(context: context)),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           );
//         }).toList(),
//       ),
//     );
//   }

//   Widget _variants() {
//     return Wrap(
//       spacing: 4,
//       runSpacing: 2,
//       children: actualProduct!.variantMap.entries.map((mapEntry) {
//         return Container(
//           decoration: BoxDecoration(
//             color: selectedBilledVariant != null && selectedBilledVariant!.variantId == mapEntry.value.variantId ?
//                    AppColors().appMoneyColor(context: context) 
//                    : 
//                    AppColors().appBackgroundColor(context: context),
//             border: Border.all(color: AppColors().appTextColor(context: context)),
//           ),
//           child: Padding(
//             padding: const EdgeInsets.all(6.0),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 TextWidgets().highLightText(text: mapEntry.value.variantName, textColor: AppColors().appTextColor(context: context)),
//                 Padding(
//                   padding: const EdgeInsets.only(top: 8.0),
//                   child: TextWidgets().highLightText(text: Money().moneyText(moneyValue: mapEntry.value.price), textColor: AppColors().appTextColor(context: context)),
//                 ),
//               ],
//             ),
//           ),
//         );
//       }).toList(),
//     );
//   }

//   Widget _modifiers() {
//     return Column(
//       children: actualProduct!.modifierGroupMap.entries.map((modifierGroup) {
//         List<String> selectedModifiers = [];
//         for(final billedModifier in billedItem.modifierList.where((element) => element.modifierGroupId == modifierGroup.value.modifierGroupId)) {
//           selectedModifiers.add(billedModifier.modifierName);
//         }
//         return Wrap(
//           spacing: 4,
//           runSpacing: 2,
//           children: modifierGroup.value.nameMappedPrice.entries.map((mapEntry) {
//             return Container(
//               decoration: BoxDecoration(
//                 color: selectedModifiers.indexWhere((element) => element == mapEntry.key) >= 0 ?
//                        AppColors().appMoneyColor(context: context) 
//                        : 
//                        AppColors().appBackgroundColor(context: context),
//                 border: Border.all(color: AppColors().appTextColor(context: context)),
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.all(6.0),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     TextWidgets().highLightText(text: mapEntry.key, textColor: AppColors().appTextColor(context: context)),
//                     Padding(
//                       padding: const EdgeInsets.only(top: 8.0),
//                       child: TextWidgets().highLightText(text: Money().moneyText(moneyValue: mapEntry.value), textColor: AppColors().appTextColor(context: context)),
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           }).toList(),
//         );
//       }).toList(),
//     );
//   }

//   Widget _removeProductFromBill({required BoxConstraints constraints}) {
//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.white,
//         border: Border.all(color: Colors.red.shade100),
//         borderRadius: BorderRadius.circular(8),
//         boxShadow: const[
//           BoxShadow(color: Color(0x1F000000), blurRadius: 8)
//         ]
//       ),
//       child: Material(
//         color: Colors.transparent,
//         child: InkWell(
//           borderRadius: BorderRadius.circular(8),
//           splashColor: Colors.red.shade400,
//           onTap: () async{
//           },
//           child: Padding(
//             padding: const EdgeInsets.symmetric(vertical: 14),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 4),
//                   child: Icon(
//                     Icons.delete,
//                     color: Colors.red,
//                     size: AppSizes().header,
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 4),
//                   child: Text(
//                     'Remove from billing',
//                     style: TextStyle(
//                       color: Colors.black,
//                       fontSize: AppSizes().normalText,
//                       overflow: TextOverflow.ellipsis,
//                       fontWeight: FontWeight.bold
//                     ),
//                   ),
//                 ),
                
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }