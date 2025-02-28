// import 'package:easypos/core/common/widgets/text_widgets.dart';
// import 'package:easypos/ui/billing/billing_dashboard/controllers/billing_data_fetch_controller.dart';
// import 'package:easypos/core/utils/app_colors.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_animate/flutter_animate.dart';
// import 'package:popover/popover.dart';
// import 'package:provider/provider.dart';

// class BillingMoreActionPopup extends StatefulWidget {
//   const BillingMoreActionPopup({super.key});

//   @override
//   State<BillingMoreActionPopup> createState() => _BillingMoreActionPopupState();
// }

// class _BillingMoreActionPopupState extends State<BillingMoreActionPopup> with SingleTickerProviderStateMixin{

//   late AnimationController _animationController;

//   bool loading = true;

//   void clearBill() {

//   }

//   @override
//   void initState() {
//     // TODO: implement initState
//     _animationController = AnimationController(
//       vsync: this, 
//       duration: const Duration(
//         milliseconds: 200,
//       ),
//     );
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
    
//     return IconButton(
//       onPressed: () async{
//         await showPopover(
//           arrowDxOffset: 0,
//           arrowWidth: 16,
//           arrowHeight: 8,
//           //height: 180,
//           context: context, 
//           bodyBuilder:(context) {
//             return _popup();
//           },);
//       },
//       tooltip: 'More actions',
//       icon: Icon(Icons.more_vert, size: 30, color: AppColors().appTextColor(context: context).withOpacity(.85), semanticLabel: 'More actions')
//     ).animate(controller: _animationController,).slideY(begin: -1, end: 0, duration: const Duration(milliseconds: 300), curve: Curves.easeIn);;
//   }

//   Widget _popup() {
//     return LayoutBuilder(
//       builder: (context, constraints) {
//         return Container(
//           //height: 200,
//           width: constraints.maxWidth * .6,
//           decoration: BoxDecoration(
//             color: AppColors().appBackgroundColor(context: context),
//             borderRadius: BorderRadius.circular(4)
//           ),
//           child: SingleChildScrollView(
//             child: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.only(top: 6.0),
//                     child: _actionItems(
//                       actionText: 'Clear bill', 
//                       onTapAction: (){
//                         context.read<BillingDataFetchProvider>().removeAllItemsOfCurrentBill();
//                         Navigator.pop(context);
//                       }
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.only(top: 10.0, bottom: 6),
//                     child: _actionItems(
//                       actionText: 'Add customer', 
//                       onTapAction: (){}
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }

//   Widget _actionItems({required String actionText, required VoidCallback onTapAction}) {
//     return LayoutBuilder(
//       builder: (context, constraints) {
//         return Container(
//           width: constraints.maxWidth,
//           decoration: BoxDecoration(
//             color: AppColors().buttonGrey(context: context),
//             borderRadius: BorderRadius.circular(6)
//           ),
//           child: Material(
//             color: Colors.transparent,
//             child: InkWell(
//               onTap: () {
//                 onTapAction();
//               },
//               child: Center(
//                 child: Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12),
//                   child: TextWidgets().highLightText14(text: actionText, textColor: AppColors().appActionColor(context: context)),
//                 ),
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }