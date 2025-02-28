
import 'package:candypos/core/common/widgets/ui_button.dart';
import 'package:candypos/core/utils/constants/app_sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';

import '../../core/utils/constants/app_colors.dart';
import '../../features/pos/ui/widgets/change_billtype_action_popup.dart';
import '../../features/pos/ui/widgets/hold_bill_action_popup.dart';
import '../providers/appdrawer_controller.dart';
import '../pages/appdrawer.dart';

class AppbarWidget extends StatefulWidget {
  const AppbarWidget({super.key});

  @override
  State<AppbarWidget> createState() => _AppbarWidgetState();
}

class _AppbarWidgetState extends State<AppbarWidget> {

  //late AnimationController _animationController;

  AppDrawerTabState appDrawerTabState = AppDrawerTabState.initialTabScreen;

  @override
  didChangeDependencies() {
    final newDrawerTab = context.watch<AppdrawerStateController>().selectedAppDrawerTab;

    if(newDrawerTab != appDrawerTabState) {
      appDrawerTabState = newDrawerTab;
      setState(() {
        
      });
    }
    
    super.didChangeDependencies();
  }

  @override
  void initState() {
    // TODO: implement initState
    // _animationController = AnimationController(vsync: this);
    // _animationController.forward();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(appDrawerTabState.name.toUpperCase(), style: Theme.of(context).textTheme.titleMedium?.copyWith(letterSpacing: 5),),
    
        //Spaces().horizontalSpace2(),
    
        _actions()
      ],
    ).animate().fadeIn( duration: Duration(milliseconds: 500));
  }

  

  Widget _actions() {
    return LayoutBuilder(
      builder: (context, constraints) {
        switch (appDrawerTabState) {
          case AppDrawerTabState.pos:
            return _billingActions();
          case AppDrawerTabState.inventory:
            return _inventoryActions();
          case AppDrawerTabState.expenses:
            return _expensesActions();
          case AppDrawerTabState.analysis:
            return _analysisActions();
          case AppDrawerTabState.settings:
            return _settingsActions();
          }
      },
    );
  }


  Widget _billingActions() {
    return LayoutBuilder(
      builder: (context, constraints) {
        if(appDrawerTabState != AppDrawerTabState.pos) {
          return Container();
        } else {

          return Container(
            decoration: BoxDecoration(
              color: AppColors.context(context).backgroundColor,
              borderRadius: AppSizes.maxCircularRadius
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 8),
              child: Row(
                children: [
                  UiButton(
                    borderRadius: AppSizes.mediumBorderRadius, 
                    onTap:() {
                      
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(Icons.currency_exchange),
                    ),
                  ),
                  //Spaces().horizontalSpace2(),
                  UiButton(
                    borderRadius: AppSizes.mediumBorderRadius, 
                    onTap:() {
                      
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(Icons.table_restaurant_rounded),
                    ),
                  ),
              
                  // const HoldBillActionPopup(),
              
                  // const ChangeBilltypeActionPopup(),
              
                  // IconButton(
                  //   tooltip: 'Serviced by',
                  //   onPressed: () {
                      
                  //   },
                  //   icon: CircleAvatar(radius: 15, backgroundColor: AppColors.context(context).textColor.withOpacity(.85),)
                  // ),
                ],
              ),
            ),
          );
        }
      },
    );
  }

  Widget _inventoryActions() {
    return LayoutBuilder(
      builder: (context, constraints) {
        if(appDrawerTabState != AppDrawerTabState.inventory) {
          return Container();
        } else {

          return Container();
        }
      },
    );
  }


  Widget _expensesActions() {
    return LayoutBuilder(
      builder: (context, constraints) {
        if(appDrawerTabState != AppDrawerTabState.expenses) {
          return Container();
        } else {

          return Container();
        }
      },
    );
  }


  Widget _analysisActions() {
    return LayoutBuilder(
      builder: (context, constraints) {
        if(appDrawerTabState != AppDrawerTabState.analysis) {
          return Container();
        } else {

          return Container();
        }
      },
    );
  }

  Widget _settingsActions() {
    return LayoutBuilder(
      builder: (context, constraints) {
        if(appDrawerTabState != AppDrawerTabState.settings) {
          return Container();
        } else {

          return Container();
        }
      },
    );
  }
}