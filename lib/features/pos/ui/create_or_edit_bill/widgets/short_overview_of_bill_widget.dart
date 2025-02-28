// import 'package:easypos/core/common/widgets/image_related/show_round_image.dart';
// import 'package:easypos/core/common/widgets/money.dart';
// import 'package:easypos/core/common/widgets/text_widgets.dart';
// import 'package:easypos/features/billing/data/models/bill_model.dart';
// import 'package:easypos/features/billing/data/models/sale_item_model.dart';
// import 'package:easypos/ui/billing/billing_dashboard/controllers/billing_data_fetch_controller.dart';
// import 'package:easypos/ui/inventory/dashboard/controllers/inventory_data_controller.dart';
// import 'package:easypos/core/utils/app_colors.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:flutter_animate/flutter_animate.dart';
// import 'package:provider/provider.dart';

// import '../../../../features/billing/data/models/enums_of_models.dart';

// class ShortOverviewOfBillWidget extends StatefulWidget {
//   const ShortOverviewOfBillWidget({super.key});

//   @override
//   State<ShortOverviewOfBillWidget> createState() => _ShortOverviewOfBillWidgetState();
// }

// class _ShortOverviewOfBillWidgetState extends State<ShortOverviewOfBillWidget> {
//   BillModel? currentBill;

//   BillType selectedBillType = BillType.walkIn;

//   double selectedAmount = 0;

//   @override
//   Widget build(BuildContext context) {
//     currentBill = context.watch<BillingDataFetchProvider>().currentBill;

//     if(currentBill == null) {
//       return const Center(child: CircularProgressIndicator(),);
//     }

//     // final List<BilledItem> billedProductList = currentBill!.billedProductList;

//     // billedProductList.sort((a,b)=> -(a.totalPrice.compareTo(b.totalPrice)));

//     return LayoutBuilder(
//       builder: (context, constraints) {
//         return Column(
//           mainAxisSize: MainAxisSize.min,
//           crossAxisAlignment: CrossAxisAlignment.end,
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 SizedBox(
//                   height: 58,
//                   width: constraints.maxWidth * .6, 
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 2),
//                     child: _total(),
//                   )),
//                 SizedBox(
//                   height: 58,
//                   width: constraints.maxWidth * .4,
//                   child: Padding(
//                    padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 2),
//                    child: _review(),
//                  ))
//               ],
//             ).animate(),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 0),
//               child: _cash(),
//             )
//           ],
//         );
//       },
//     );
//   }

//     Widget _cash() {
//     List<double> amountSuggestion = [currentBill!.dueAmount];

//     List<int> currencies = Money().currencies;

//     for (final int currency in currencies) {

//       double suggestion = (currentBill!.dueAmount + currency) - (currentBill!.dueAmount + currency) % currency;

//       if(!amountSuggestion.contains(suggestion)) {
//         amountSuggestion.add(suggestion);
//       }

//     }

//     return LayoutBuilder(
//       builder: (context, constraints) {
//         if(currentBill!.grandTotal <=0) {
//           return Container();
//         }
//         int cnt = -1;
//         return Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(0.0),
//               child: TextWidgets().highLightText14(text: 'Cash pay:', textColor: AppColors().appTextColorGrey(context: context)),
//             ),
//             SingleChildScrollView(
//               scrollDirection: Axis.horizontal,
//               child: Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: amountSuggestion.map((amount) {
//                   cnt ++;
//                   return Padding(
//                     padding: const EdgeInsets.all(2.0),
//                     child: Container(
//                       height: 45,
//                       decoration: BoxDecoration(
//                         color: (amount == selectedAmount) ? Colors.black.withOpacity(.85) : Colors.white,
//                         borderRadius: BorderRadius.circular(5),
//                         border: Border.all(color: Colors.black)
//                         // boxShadow: const[
//                         //   BoxShadow(color: Color(0x1F000000), blurRadius: 8)
//                         // ]
//                       ),
//                       child: Material(
//                         color: Colors.transparent,
//                         child: InkWell(
//                           onTap: () {
//                             setState(() {
//                               if(selectedAmount == amount)  {
//                                 selectedAmount = 0;
//                                 return;
//                               }
//                               selectedAmount = amount;
//                             });
//                           },
//                           child: Center(
//                             child: Padding(
//                               padding: const EdgeInsets.symmetric(horizontal: 20.0,),
//                               child: TextWidgets().buttonText(buttonText: "${Money().moneySymbol(context: context)}${amount.toString()}", textColor: (amount != selectedAmount) ? Colors.black.withOpacity(.85) : Colors.white),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ).animate().fade().scaleXY(begin: 0, end: 1, curve: Curves.easeInSine, duration: Duration(milliseconds: cnt * 100)),
//                   );
//                 }).toList()
//               ),
//             ),
//           ],
//         );
//       },
//     );
//   }


//   // Widget _hold() {
//   //   return LayoutBuilder(
//   //     builder: (context, constraints) {
//   //       return Container(
//   //         height: constraints.maxHeight,
//   //         width: constraints.maxWidth,
//   //         decoration: BoxDecoration(
//   //           color: AppColors().appBackgroundColor(context: context),
//   //           borderRadius: BorderRadius.circular(4),
//   //           border: Border.all(color: AppColors().appTextColor(context: context))
//   //         ),
//   //         child: Center(
//   //           child: TextWidgets().buttonTextHigh(
//   //             buttonText: 'Save & Hold', 
//   //             textColor: AppColors().appTextColor(context: context)
//   //           ),
//   //         ),
//   //       );
//   //     }
//   //   );
  
//   // }

//   Widget _review() {
//     return LayoutBuilder(
//       builder: (context, constraints) {
//         return Container(
//           //height: constraints.maxHeight,
//           width: constraints.maxWidth,
//           decoration: BoxDecoration(
//             color: currentBill!.saleItemList.isNotEmpty ? AppColors().appActionColor(context: context) : AppColors().buttonGrey(context: context),
//             borderRadius: BorderRadius.circular(4)
//           ),
//           child: Center(
//             child: TextWidgets().buttonTextHigh(
//               buttonText: 'Review order', 
//               textColor:currentBill!.saleItemList.isNotEmpty ?  AppColors().appTextColor(context: context) : AppColors().appTextColorGrey(context: context)
//             ),
//           ),
//         );
//       }
//     );
//   }

//   Widget _total() {
//     return LayoutBuilder(
//       builder: (context, constraints) {
//         return Container(
//           //height: constraints.maxHeight,
//           width: constraints.maxWidth,
//           decoration: BoxDecoration(
//             //color: AppColors().buttonGrey(context: context),
//             borderRadius: BorderRadius.circular(4)
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               TextWidgets().smallNormalText12(
//                 text: 'Total', 
//                 textColor: AppColors().appTextColor(context: context)
//               ),
          
//               TextWidgets().buttonTextHigh(
//                 buttonText: '${Money().moneySymbol(context: context)}${currentBill!.grandTotal.toString()}', 
//                 textColor: AppColors().appTextColor(context: context)
//               ),
              
//             ],
//           ),
//         );
//       }
//     );
//   }

//   // Widget _review() {
//   //   return LayoutBuilder(
//   //     builder: (context, constraints) {
//   //       return Container(
//   //         height: constraints.maxHeight,
//   //         width: constraints.maxWidth,
//   //         decoration: BoxDecoration(
//   //           //color: AppColors().buttonGrey(context: context),
//   //           borderRadius: BorderRadius.circular(4)
//   //         ),
//   //         child: Flexible(
//   //           child: Center(
//   //             child: Flexible(
//   //               child: TextWidgets().buttonTextHigh(
//   //                 buttonText: 'Review order', 
//   //                 textColor: AppColors().appActionColor(context: context)
//   //               ),
//   //             ),
//   //           ),
//   //         ),
//   //       );
//   //     }
//   //   );
//   // }

//   Widget _productStack({required BoxConstraints constraints, required BuildContext context, required List<SaleItem> billedProductList,}) {
//     int cnt = 0;
//     return Stack(
//       children: billedProductList.map((mapEntry){
//         cnt++;
//         if(cnt == 5) {
//           return Positioned(
//             left: (cnt - 1) * 25,
//             top: 28,
//             child: Container(
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(8),
//                 color: AppColors().buttonGrey(context: context),
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 6),
//                 child: Text('+ ${billedProductList.length + 1 - cnt} more', style: const TextStyle(fontSize: 8, color: Colors.black),),
//               ),
//             ),
//           );
//         } else if(cnt > 5) {
//           return Container();
//         }
//         return Positioned(
//           left: (cnt - 1) * 25,
//           top: 0,
//           child: ShowRoundImage(
//             image: context.read<InventoryDataController>().imageIfExist(imageId: mapEntry.imageId), 
//             height: 40, width: 40, borderRadius: 5000000,),
//         );
//       }).toList()
//     );
//   }
 
// }