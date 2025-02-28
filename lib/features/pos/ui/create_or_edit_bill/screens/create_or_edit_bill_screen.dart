// import 'dart:math';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../../pages/billing_dashboard/controllers/billing_data_fetch_controller.dart';
// import '../controllers/keypad_typed_data_controller.dart';
// import '../widgets/billing_more_action_popup.dart';
// import '../widgets/change_billtype_action_popup.dart';
// import '../widgets/hold_bill_action_popup.dart';
// import '../widgets/short_overview_of_bill_widget.dart';
// import '../tabs/items_tab.dart';
// import '../tabs/keypad_tab.dart';

// class ItemSelectBillingLayout extends StatefulWidget {
//   const ItemSelectBillingLayout({super.key});

//   @override
//   State<ItemSelectBillingLayout> createState() => _ItemSelectBillingLayoutState();
// }

// class _ItemSelectBillingLayoutState extends State<ItemSelectBillingLayout> with SingleTickerProviderStateMixin{

//   late TabController _tabController ;
  
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     _tabController = TabController(length: 2, vsync: this);
//   }
//   @override
//   Widget build(BuildContext context) {
//     return MultiProvider(
//       providers: [
//         ChangeNotifierProxyProvider<InventoryDataController, KeypadBillingController>(
//           create: (context) => KeypadBillingController(),
//           update:(context, value, previous) {
//             return previous!..update(idMappedVariantOfStore: value.idMappedVariantOfStore);
//           },
//         ),

//       ],
//       child: LayoutBuilder(
//           builder: (context, constraints) {
//             BillModel? currentBill = context.watch<BillingDataFetchProvider>().currentBill;
//             if(currentBill == null) {
//               return const Center(
//                 child: CircularProgressIndicator(),
//               );
//             }
//             dekhao("constraints.maxHeight*** is ${constraints.maxHeight}");
//             return SafeArea(
//               child: Scaffold(
//                 resizeToAvoidBottomInset: false,
//                 primary: false,
//                 appBar: AppBar(
//                   elevation: 1,
//                   surfaceTintColor: AppColors().appBackgroundColor(context: context),
//                   //backgroundColor: AppColors().appBackgroundColor(context: context),
//                   shadowColor: AppColors().appTextColor(context: context),
//                   actions: [_actions()],
//                 ),
//                 body: _body()
//               ),
//             );
//           },
//         ),
//     );
//   }

//   Widget _body() {
//     return LayoutBuilder(
//       builder: (context, constraints) {
//         double barHeight = 50;
//         double bottomTotalBoxHeight = 135;
//         double tabHeight = constraints.maxHeight - barHeight - bottomTotalBoxHeight;
//         return Column(
//           // mainAxisSize: MainAxisSize.max,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: [
//             SizedBox(
//               height: barHeight,
//               width: constraints.maxWidth,
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 10),
//                 child: Center(child: _tabBar()),
//               )
//             ),
//             SizedBox(
//               height: tabHeight,
//               width: constraints.maxWidth,
//               child: TabBarView(
//                 controller: _tabController,
//                 // : (value) {
//                 //   setState(() {
//                 //     currentTabIndex = value;
//                 //   });
//                 // },
//                 children: const [
//                   KeypadTab(),
//                   ItemsTab(),
//                 ],
//               ),
//             ),
//             Container( 
//               height: bottomTotalBoxHeight,
//               width: constraints.maxWidth,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(2),
//                 color: Colors.white,
//                 border: Border(top: BorderSide(color: AppColors().buttonGrey(context: context)))
//                 //color: AppColors().grey(),
//               ),
//               child: const ShortOverviewOfBillWidget()),
//           ],
//         );
          
//       },
//     );
//   }

//   Widget _actions() {
//     return LayoutBuilder(
//       builder: (context, constraints) {
//         return Padding(
//           padding: const EdgeInsets.all(2.0),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.end,
//             children: [
//               const HoldBillActionPopup(),
          
//               const ChangeBilltypeActionPopup(),
          
//               IconButton(
//                 tooltip: 'Serviced by',
//                 onPressed: () {
                  
//                 },
//                 icon: CircleAvatar(radius: 15, backgroundColor: AppColors().appTextColor(context: context).withOpacity(.85),)
//               ),
          
//               const BillingMoreActionPopup(),
//             ],
//           ),
//         );
//       },
//     );
//   }

//   Widget _tabBar() {
//     return LayoutBuilder(
//       builder: (context, constraints) {
//         return Container(
//           height: constraints.maxHeight,
//           width: constraints.maxWidth,
//           decoration: BoxDecoration(
//             color: AppColors().buttonGrey(context: context),
//             borderRadius: BorderRadius.circular(8)
//           ),
//           child: Center(
//             child: Padding(
//               padding: const EdgeInsets.all(2.0),
//               child: TabBar(
//                 controller: _tabController,
//                 dividerColor: Colors.transparent,
//                 labelColor: AppColors().appTextColor(context: context).withOpacity(.9),
//                 labelStyle: TextStyle(fontSize: min(constraints.maxHeight, constraints.maxWidth) / 3, fontWeight: FontWeight.w500),
//                 indicatorSize: TabBarIndicatorSize.tab,
//                 //indicatorPadding: EdgeInsets.symmetric(horizontal: 10),
//                 indicator: BoxDecoration(
//                   color: AppColors().appBackgroundColor(context: context),
//                   borderRadius: BorderRadius.circular(8)
//                 ),
//                 //controller: ,
//                 //isScrollable: true,
//                 onTap: (value) {
//                   // setState(() {
//                   //   currentTabIndex = value;
//                   // });
//                 },
//                 tabs:  [
//                   Tab(text: 'Keypad', height: constraints.maxHeight,),
//                   Tab(text: 'Items', height: constraints.maxHeight,),
//                 ],
//               ),
            
//             ),
//           ),
//         );
//       },
//     );
//   }
// }