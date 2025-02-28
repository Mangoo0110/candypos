
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:provider/provider.dart';

// class BilledProductListWidget extends StatefulWidget {
//   final List<SaleItem>  billedProductList;
//   const BilledProductListWidget({super.key, required this.billedProductList});

//   @override
//   State<BilledProductListWidget> createState() => _BilledProductListWidgetState();
// }

// class _BilledProductListWidgetState extends State<BilledProductListWidget> {
//   BillModel? currentBill;

//   @override
//   Widget build(BuildContext context) {
    
//     return LayoutBuilder(
//       builder: (context, constraints) {
//         List<Widget> widgetList = [];
//         for(int index = 0; index < widget.billedProductList.length; index++) {
//           widgetList.add(Padding(
//             padding: const EdgeInsets.symmetric(vertical: 2),
//             child: Container(
//               height: 80,
//               width: constraints.maxWidth,
//               decoration: BoxDecoration(
//                 color: index % 2 == 0 ? AppColors().buttonGrey(context: context).withOpacity(.5) : Colors.transparent,
//                 borderRadius: BorderRadius.circular(8)
//               ),
//               child: Material(
//                 color: Colors.transparent,
//                 child: InkWell(
//                   borderRadius: BorderRadius.circular(8),
//                   onTap: () {
//                     showModalBottomSheet(
//                       context: context, 
//                       builder:(context) => BillingProductEditPopup(
//                         billingProduct: widget.billedProductList[index],
//                         onDone: (quantity) {
//                           Navigator.pop(context);
//                           setState(() {
                            
//                           });
//                         }));
//                   },
//                   child: Padding(
//                     padding: const EdgeInsets.all(3.0),
//                     child: _table(context: context, constraints: constraints, billedItem: widget.billedProductList[index]),
//                   ),
//                 ),
//               ),
//             ),
//           ));
//         }
//         return SafeArea(
//           child: (widget.billedProductList.isEmpty) ? 
//           const Center(child: Text('No products selected!'))
//           :
//           Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: widgetList,
//           ),
//         );
//       },
//     );
//   }

//   Widget _table({required BuildContext context, required BoxConstraints constraints, required SaleItem billedItem,}) {
//     dekhao("billingProduct.productImageId ${billedItem.imageId}");
//     return Table(
//       defaultVerticalAlignment: TableCellVerticalAlignment.middle,
//       columnWidths: const{0: FlexColumnWidth(.62), 1: FlexColumnWidth(.38),},
//       children: [
//         TableRow(
//           children: [
//             Row(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 ShowRoundImage(image: context.read<InventoryDataController>().imageIfExist(imageId: billedItem.imageId), height: 60, width: 60, borderRadius: 5000000,),
//                 Flexible(
//                   child: Padding(
//                     padding: const EdgeInsets.only(left: 2.0),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         Flexible(child: Text(billedItem.itemName, style: AppTextStyle().normalSize(context: context),)),
//                         Flexible(
//                           child: Padding(
//                             padding: const EdgeInsets.only(top: 3.0),
//                             child: Text('Qty. ${billedItem.quantity}', style: AppTextStyle().greySmallSize(context: context),),
//                           ),
//                         )
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             Align(
//               alignment: Alignment.topRight, 
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 crossAxisAlignment: CrossAxisAlignment.end,
//                 children: [
//                   Flexible(child: Text(Money().moneyText(moneyValue: billedItem.totalPrice), style: AppTextStyle().normalSize(context: context),)),
                  
//                 ],
//               ))
//           ]
//         )
//       ],
//     );
//   }
// }