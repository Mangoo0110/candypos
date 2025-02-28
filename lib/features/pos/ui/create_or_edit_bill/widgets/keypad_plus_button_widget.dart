// import 'dart:math';

// import 'package:candypos/core/utils/constants/app_colors.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../../../../../core/common/functions/money.dart';
// import '../../../../../core/utils/func/dekhao.dart';
// import '../../pages/billing_dashboard/controllers/billing_data_fetch_controller.dart';
// import '../controllers/keypad_typed_data_controller.dart';

// class KeypadPlusButtonWidget extends StatefulWidget {
//   const KeypadPlusButtonWidget({super.key});

//   @override
//   State<KeypadPlusButtonWidget> createState() => _KeypadPlusButtonWidgetState();
// }

// class _KeypadPlusButtonWidgetState extends State<KeypadPlusButtonWidget> {

//   double itemTotalPricePreview = 0;

//   addProduct() {
//     final billedItem = context.read<KeypadBillingController>().saleItem;
//     if(billedItem != null && billedItem.quantity > 0) {
//       //context.read<BillingDataFetchProvider>().addItemToCurrentBill(billedItem: billedItem);
      
//     }
//     context.read<KeypadBillingController>().clearItemSale();
    
//   }

//   getPricePrediction() {
//     itemTotalPricePreview = context.watch<KeypadBillingController>().saleItem!.totalPrice;
//   }
  
//   @override
//   Widget build(BuildContext context) {
//     getPricePrediction();
//     dekhao("itemTotalPricePreview $itemTotalPricePreview");
//     return LayoutBuilder(
//       builder: (context, constraints) {
//         return SizedBox(
//           height: constraints.maxHeight,
//           width: constraints.maxWidth,
//           child: Padding(
//             padding: const EdgeInsets.all(1.5),
//             child: Container(
//               decoration: BoxDecoration(
//                 color: AppColors.context(context).backgroundColor,
//                 //borderRadius: BorderRadius.circular(8),
//               ),
//               child: Material(
//                 color: Colors.transparent,
//                 child: InkWell(
//                   enableFeedback: true,
//                   splashColor: AppColors.context(context).accentColor,
//                   onTap: () {
//                     addProduct();
//                     //context.read<BillingDataController>().addBillingProduct(product: product, addingUnit: addingUnit, billigMethod: billigMethod)
//                   },
//                   borderRadius: BorderRadius.circular(0),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       Text(
//                         '+', style: TextStyle(
//                           color: AppColors.context(context).accentColor,//Colors.black, 
//                           fontSize: min(constraints.maxHeight, constraints.maxWidth) / 3 , overflow: TextOverflow.ellipsis, fontWeight: FontWeight.bold),
//                       ),
//                       Text(
//                         '${Money().moneySymbol(context: context)} $itemTotalPricePreview', style: TextStyle(color: AppColors.context(context).textGreyColor, fontSize: constraints.maxHeight / 15 , overflow: TextOverflow.ellipsis, fontWeight: FontWeight.w600),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }

// }