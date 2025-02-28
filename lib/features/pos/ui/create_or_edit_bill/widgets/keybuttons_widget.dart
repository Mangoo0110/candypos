// import 'dart:math';

// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:provider/provider.dart';

// import '../../../../../core/utils/constants/app_colors.dart';
// import '../controllers/keypad_typed_data_controller.dart';
// import 'keypad_plus_button_widget.dart';

// class KeybuttonsWidget extends StatefulWidget {
//   const KeybuttonsWidget({super.key});

//   @override
//   State<KeybuttonsWidget> createState() => _KeybuttonsWidgetState();
// }

// class _KeybuttonsWidgetState extends State<KeybuttonsWidget> {

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//   }
//   @override
//   Widget build(BuildContext context) {
//     return LayoutBuilder(
//       builder: (context, constraints) {
//         return _calculator();
//       },
//     );
//   }

//   Widget _calculator(){
//     return LayoutBuilder(
//       builder: (context, constraints) {
//         return Table(
//           columnWidths: const {0: FlexColumnWidth(.71), 1: FlexColumnWidth(.29)},
//           children: [
//             TableRow(
//               children: [
//                 SizedBox(height: constraints.maxHeight , child: _numTable()),
//                 SizedBox(height: constraints.maxHeight, child: _actionTable())
//               ]
//             )
//           ],
//         );
//       },
//     );
//   }

//   Widget _numTable() {
//     return LayoutBuilder(
//       builder: (context, constraints) {
//          double numButtonHeight = constraints.maxHeight / 4 ;
//          double numButtonWidth = constraints.maxWidth / 3;
//         return Table(
//           border: TableBorder.all(color: AppColors.context(context).textGreyColor, width: .5),
//           columnWidths: const {0: FlexColumnWidth(.33), 1: FlexColumnWidth(.33), 2: FlexColumnWidth(.33)},
//           children: [
//             TableRow(
//               children: [
//                 _numButton(buttonHeight: numButtonHeight, buttonWidth: numButtonWidth, numText: '1'),
//                 _numButton(buttonHeight: numButtonHeight, buttonWidth: numButtonWidth, numText: '2'),
//                 _numButton(buttonHeight: numButtonHeight, buttonWidth: numButtonWidth, numText: '3'),
//               ]
//             ),
//             TableRow(
//               children: [
//                 _numButton(buttonHeight: numButtonHeight, buttonWidth: numButtonWidth, numText: '4'),
//                 _numButton(buttonHeight: numButtonHeight, buttonWidth: numButtonWidth , numText: '5'),
//                 _numButton(buttonHeight: numButtonHeight, buttonWidth: numButtonWidth, numText: '6'),
//               ]
//             ),
//             TableRow(
//               children: [
//                 _numButton(buttonHeight: numButtonHeight, buttonWidth: numButtonWidth , numText: '7'),
//                 _numButton(buttonHeight: numButtonHeight, buttonWidth: numButtonWidth , numText: '8'),
//                 _numButton(buttonHeight: numButtonHeight, buttonWidth: numButtonWidth , numText: '9'),
//               ]
//             ),
//             TableRow(
//               children: [
//                 _clear(buttonHeight: numButtonHeight, buttonWidth: numButtonWidth,),
//                 _numButton(buttonHeight: numButtonHeight, buttonWidth: numButtonWidth , numText: '0'),
//                 _numButton(buttonHeight: numButtonHeight, buttonWidth: numButtonWidth , numText: '.'),
//               ]
//             ),
//           ],
//         );
//       },
//     );
//   }

//   Widget _actionTable() {
//     return LayoutBuilder(
//       builder: (context, constraints) {
//          double numButtonHeight = constraints.maxHeight / 2 ;
//          double numButtonWidth = constraints.maxWidth;
//         return Table(
//           border: TableBorder.all(color: AppColors.context(context).textGreyColor, width: .5),
//           columnWidths: const {0: FlexColumnWidth(1)},
//           children: [
//             TableRow(
//               children: [
//                 _multiply(buttonHeight: numButtonHeight, buttonWidth: numButtonWidth,),
//               ]
//             ),
//             TableRow(
//               children: [
//                 SizedBox(height: numButtonHeight, width: numButtonWidth, child: const KeypadPlusButtonWidget(),),
//               ]
//             ),
//           ],
//         );
//       },
//     );
//   }

//   Widget _numButton({required double buttonHeight, required double buttonWidth, required String numText}) {
//     return LayoutBuilder(
//       builder: (context, constraints) {
//         return SizedBox(
//           height: buttonHeight,
//           width: buttonWidth,
//           child: Padding(
//             padding: const EdgeInsets.all(1.5),
//             child: Container(
//               decoration: BoxDecoration(
//                 color: AppColors.context(context).backgroundColor,
//                 // borderRadius: BorderRadius.circular(8),
//                 // boxShadow: const[
//                 //   BoxShadow(color: Color(0x1F000000), blurRadius: 8)
//                 // ]
//               ),
//               child: Material(
//                 color: Colors.transparent,
//                 child: InkWell(
//                   onTap: () {

//                     if(context.read<KeypadBillingController>().saleItem!.totalPrice > 1e10) {
//                       Fluttertoast.showToast(msg: 'Out of range! ${'\n'} (price * quantity) > 1e10');
//                       return;
//                     }

//                     context.read<KeypadBillingController>().addKeypadTextAndParse(numText);   
//                   },
//                   borderRadius: BorderRadius.circular(0),
//                   child: Center(
//                     child: Text(
//                       numText, style: TextStyle(color: Colors.black, fontSize: buttonHeight / 4 , overflow: TextOverflow.ellipsis, fontWeight: FontWeight.bold),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }

//   Widget _clear({required double buttonHeight, required double buttonWidth}) {
//     return LayoutBuilder(
//       builder: (context, constraints) {
//         return SizedBox(
//           height: buttonHeight,
//           width: buttonWidth,
//           child: Padding(
//             padding: const EdgeInsets.all(1.5),
//             child: Container(
//               decoration: BoxDecoration(
//                 color: AppColors.context(context).backgroundColor,
//                 //borderRadius: BorderRadius.circular(4),
//                 //border: Border.all(color: AppColors.context(context).textGreyColor),
                
//               ),
//               child: Material(
//                 color: Colors.transparent,
//                 child: InkWell(
//                   onTap: () {
//                     context.read<KeypadBillingController>().clearItemSale();
//                     //context.read<BillingDataController>().addBillingProduct(product: product, addingUnit: addingUnit, billigMethod: billigMethod)
//                   },
//                   borderRadius: BorderRadius.circular(0),
//                   child: Center(
//                     child: Text(
//                       'C', style: TextStyle(color: Colors.black, fontSize: buttonHeight / 4 , overflow: TextOverflow.ellipsis, fontWeight: FontWeight.bold),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }

//   Widget _multiply({required double buttonHeight, required double buttonWidth}) {
//     return LayoutBuilder(
//       builder: (context, constraints) {
//         return SizedBox(
//           height: buttonHeight,
//           width: buttonWidth,
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
//                   onTap: () {
//                     context.read<KeypadBillingController>().multiplyTapped();
//                   },
//                   borderRadius: BorderRadius.circular(0),
//                   child: Center(
//                     child: Text(
//                       'X', style: TextStyle(color: Colors.black, fontSize: min(buttonHeight, buttonWidth) / 3.5, overflow: TextOverflow.ellipsis, fontWeight: FontWeight.bold),
//                     ),
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