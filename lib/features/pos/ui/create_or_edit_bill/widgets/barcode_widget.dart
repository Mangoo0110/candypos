
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:provider/provider.dart';

// import '../../../../../inventory/item&variant/domain/entities/item.dart';

// class BarcodeWidget extends StatefulWidget {
//   const BarcodeWidget({super.key});

//   @override
//   State<BarcodeWidget> createState() => _BarcodeWidgetState();
// }

// class _BarcodeWidgetState extends State<BarcodeWidget> {
//   final TextEditingController _controller = TextEditingController();

//   Cart? currentBill;

  

//   Item? getBarcodeProduct(String barcodeText){
//     final index = context.read<InventoryDataController>().itemListOfStore.indexWhere((element) => element.barcode == barcodeText);
//     if(index < 0) return null;
//     return context.read<InventoryDataController>().itemListOfStore[index];
//   }
  

//   //functions::
//   Future<void> scanCode() async{
//     try {
//       await FlutterBarcodeScanner
//       .scanBarcode(
//         '#ff6666', 'Cancel', true, ScanMode.BARCODE)
//         .then((scannedText) {
//           setState(() {

//             _controller.text = scannedText;

//             final barcodeProduct = getBarcodeProduct(scannedText);
//             if(barcodeProduct == null) {
//               Fluttertoast.showToast(msg: 'Product not found!');
//               return;
//             } else {
//             }
//           });
//         });
//     } on PlatformException{
//       Fluttertoast.showToast(msg: 'Platform denied! Try again.');
//     }
//   }

  
//   @override
//   Widget build(BuildContext context) {
//     return LayoutBuilder(
//       builder: (context, constraints) {
//         return Row(
//           children: [
//             SizedBox(
//               height: 60,
//               width: constraints.maxWidth * .65,
//               child: NameTextfield(
//                 maxLines: 1, 
//                 onChanged:(text) {
                  
//                 }, 
//                 controller: _controller, 
//                 hintText: "Type product's barcode", 
//                 labelText: 'Barcode text', 
//                 validationCheck:(text) {
                  
//                 },),
//             ),

//             Flexible(
//               child: Row(
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 2.0),
//                     child: Container(
//                       height: 60,
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(8),
//                         boxShadow: const [
//                           BoxShadow(color: Color(0x1F000000), blurRadius: 5)
//                         ]
//                       ),
//                       child: Material(
//                         color: Colors.transparent,
//                         child: InkWell(
//                           borderRadius: BorderRadius.circular(8),
//                           onTap: () async{
//                             await scanCode();
//                           },
//                           child: const Padding(
//                             padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 4),
//                             child: Center(child: Icon(Icons.search, color: Colors.black,)),
//                           ),
//                         ),
//                       )
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 2.0),
//                     child: Container(
//                       height: 60,
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(8),
//                         boxShadow: const [
//                           BoxShadow(color: Color(0x1F000000), blurRadius: 5)
//                         ]
//                       ),
//                       child: Material(
//                         color: Colors.transparent,
//                         child: InkWell(
//                           borderRadius: BorderRadius.circular(8),
//                           onTap: () async{
//                             await scanCode();
//                           },
//                           child: const Padding(
//                             padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 4),
//                             child: Center(child: Icon(Icons.qr_code_scanner_sharp, color: Colors.black,)),
//                           ),
//                         ),
//                       )
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         );
//       },
//     );
//   }

// }