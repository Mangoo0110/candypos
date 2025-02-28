// import 'dart:typed_data';

// import 'package:easypos/core/common/data/app_regexp.dart';
// import 'package:easypos/core/common/widgets/buttons/done_button_widget.dart';
// import 'package:easypos/core/common/widgets/textfields/quantity_textfield.dart';
// import 'package:easypos/core/common/widgets/image_related/show_rect_image.dart';
// import 'package:easypos/features/billing/data/models/bill_model.dart';
// import 'package:easypos/features/billing/data/models/sale_item_model.dart';
// import 'package:easypos/features/appuser/ui/providers/branch_data_provider.dart';
// import 'package:easypos/ui/billing/billing_dashboard/controllers/billing_data_fetch_controller.dart';
// import 'package:easypos/ui/inventory/dashboard/controllers/inventory_data_controller.dart';
// import 'package:easypos/core/utils/app_colors.dart';
// import 'package:easypos/core/utils/app_sizes.dart';
// import 'package:easypos/core/utils/app_textstyles.dart';
// import 'package:easypos/core/utils/dekhao.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:provider/provider.dart';

// class BillingProductEditPopup extends StatefulWidget {
//   final SaleItem billingProduct;
//   final Function (double quantity) onDone;
//   const BillingProductEditPopup({super.key, required this.billingProduct, required this.onDone});

//   @override
//   State<BillingProductEditPopup> createState() => _BillingProductEditPopupState();
// }

// class _BillingProductEditPopupState extends State<BillingProductEditPopup> {
//   final _formKey = GlobalKey<FormState>();

//   final TextEditingController _quantityInputcontroller = TextEditingController();
//   Uint8List? productImage;

//   BillModel? currentBill;

//   editBillingProduct({required SaleItem billingProduct}) {
    
//   }

//   @override
//   void initState() {
//     // TODO: implement initState
//     _quantityInputcontroller.text = widget.billingProduct.quantity.toString();
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
//     productImage = context.read<InventoryDataController>().imageIfExist(imageId: widget.billingProduct.imageId);
//     if(productImage == null) {
//       dekhao("image is null");
//     }
//     return LayoutBuilder(
//       builder: (context, constraints) {
//         return CupertinoPageScaffold(
//           child: Form(
//             key: _formKey,
//             child: Container(
//               color: Colors.white,
//               width: constraints.maxWidth,
//               child: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: SingleChildScrollView(
//                   child: Column(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text('Quantity edit', style: AppTextStyle().boldBigSize(context: context),),
//                           DoneButtonWidget(
//                             onDone: () {
//                               widget.onDone(double.tryParse(_quantityInputcontroller.text) ?? 0);
//                             },
//                           )
//                         ],
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.symmetric(vertical: 8),
//                         child: Column(
//                           mainAxisSize: MainAxisSize.min,
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           children: [
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               children: [
//                                 ShowRectImage(image: productImage, height: 120, width: 120, borderRadius: 8,),
//                                 Padding(
//                                   padding: const EdgeInsets.only(left: 8),
//                                   child: Text(widget.billingProduct.itemName, style: AppTextStyle().boldNormalSize(context: context),),
//                                 )
//                               ],
//                             ),
                        
//                             Padding(
//                               padding: const EdgeInsets.symmetric(vertical: 20),
//                               child: SizedBox(
//                                 height: 60,
//                                 width: constraints.maxWidth,
//                                 child: Form(
//                                   child: QuantityTextField(
//                                     maxLines: 1, 
//                                     onChanged: (value){
//                                       dekhao("QuantityTextField $value");
//                                       if(value != '' && double.tryParse(value)!.isNaN) {
//                                         widget.billingProduct.setQuantity(quantity:  double.parse(value));
//                                       }
                                      
//                                     }, 
//                                     controller: _quantityInputcontroller, 
//                                     hintText: 'Product quantity', 
//                                     labelText: 'Quantity', 
//                                     validationCheck: (value){
//                                       if(value == '') return null;
//                                       if(!double.tryParse(value)!.isNaN) {
//                                         return "Enter a valid number. (e.g, .145, 20, 23.4, 1003)";
//                                       }
//                                     }, 
//                                     numRegExp: widget.billingProduct.unitDetails.weightItem == true ?  AppRegExp().moneyRegExp() :  AppRegExp().integerRegExp(),
//                                     onlyInteger: widget.billingProduct.unitDetails.weightItem),
//                                 ),
//                               ),
//                             ),

//                             Padding(
//                               padding: const EdgeInsets.only(top: 8),
//                               child: _removeProductFromBill(constraints: constraints),
//                             )
//                           ],
//                         ),
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
//             widget.onDone(0);
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