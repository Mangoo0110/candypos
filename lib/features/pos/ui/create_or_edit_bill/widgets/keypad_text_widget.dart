// import 'dart:math';
// import 'package:candypos/core/utils/constants/app_colors.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// import '../../../../../core/common/functions/money.dart';
// import '../../../../../core/utils/func/dekhao.dart';
// import '../controllers/keypad_typed_data_controller.dart';

// class KeypadTextWidget extends StatefulWidget {
//   const KeypadTextWidget({super.key});

//   @override
//   State<KeypadTextWidget> createState() => _KeypadTextWidgetState();
// }

// class _KeypadTextWidgetState extends State<KeypadTextWidget> {

//   String priceXquantity = '';

//   double _fontSizeOfPriceQuantity({required BoxConstraints constraints}) {
//    //return 18;
//     return max(16, constraints.maxWidth/ 12 );
//   }

//   getPriceXquantityText() {
//     priceXquantity = context.watch<KeypadBillingController>().priceXquantity;
//   }
//   @override
//   Widget build(BuildContext context) {
//     getPriceXquantityText();
//     dekhao("sjkdnfkjskjsn $priceXquantity");
//     return LayoutBuilder(
//       builder: (context, constraints) {
//         return _text();
//       },
//     );
//   }

//   Widget _text() {
//     return LayoutBuilder(
//       builder: (context, constraints) {
//         if (priceXquantity.isEmpty) {
//           return Center(
//             child: Text(
//               '${Money().moneySymbol(context: context)}0.00', 
//               style: TextStyle(
//                 color: AppColors.context(context).textGreyColor, 
//                 fontSize: _fontSizeOfPriceQuantity(constraints: constraints),
//                 fontWeight: FontWeight.w400),
//             ),
//           );
//         } else {
//           return Center(
//             child: SingleChildScrollView(
//               child: Wrap(
//                 crossAxisAlignment: WrapCrossAlignment.center,
//                 alignment: WrapAlignment.center,
//                 runAlignment: WrapAlignment.center,
//                 children: [
//                   context.read<KeypadBillingController>().tappedMultiply ?
//                   Text(
//                     '${Money().moneySymbol(context: context)}$priceXquantity', 
//                     style: TextStyle(
//                       color: AppColors.context(context).textColor, 
//                       fontSize: _fontSizeOfPriceQuantity(constraints: constraints),
//                       fontWeight: FontWeight.w400),
//                   )
//                   :
//                   Text(
//                     '${Money().moneySymbol(context: context)}$priceXquantity X 1', 
//                     style: TextStyle(
//                       color: AppColors.context(context).textGreyColor, 
//                       fontSize: _fontSizeOfPriceQuantity(constraints: constraints),
//                       fontWeight: FontWeight.w400),
//                   )
//                 ],
//               ),
//             ),
//           );
//         }
              
//       },
//     );
//   }

  
// }