import 'package:candypos/core/utils/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:popover/popover.dart';
import 'package:provider/provider.dart';

import '../providers/open_cart.dart';

class HoldBillActionPopup extends StatefulWidget {
  const HoldBillActionPopup({super.key});

  @override
  State<HoldBillActionPopup> createState() => _HoldBillActionPopupState();
}

class _HoldBillActionPopupState extends State<HoldBillActionPopup> with TickerProviderStateMixin{

  late AnimationController _animationController ;


  @override
  void initState() {
    // TODO: implement initState
    _animationController = AnimationController(
      vsync: this, 
      duration: const Duration(
        milliseconds: 200,
      ),
    );
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    
    return IconButton(
      tooltip: 'Save & hold bill',
      onPressed: () async{
        await showPopover(
          direction: PopoverDirection.top,
          arrowDxOffset: 0,
          arrowWidth: 16,
          arrowHeight: 8,
          //height: 180,
          context: context, 
          bodyBuilder:(context) {

            return _popup();
          });
      },
      icon: Icon(Icons.pause, size: 30, color: AppColors.context(context).buttonTextColor,)
    ).animate(controller: _animationController,).slideY(begin: -1, end: 0, duration: const Duration(milliseconds: 300), curve: Curves.easeIn);;
  }

  Widget _popup() {
    return LayoutBuilder(
      builder: (context, constraints) {
        
        if(context.read<OpenedCart>().saleItemList.isEmpty) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Bill is empty!', style: Theme.of(context).textTheme.labelLarge?.copyWith(color: AppColors.context(context).contentBoxColor)),
          );
        }
        return Container(
          //height: 200,
          width: constraints.maxWidth * .7,
          decoration: BoxDecoration(
            color: AppColors.context(context).backgroundColor,
            borderRadius: BorderRadius.circular(4)
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 4.0),
                    child: Text('Save & hold the bill', style: Theme.of(context).textTheme.labelLarge?.copyWith(color: AppColors.context(context).contentBoxColor)),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0, bottom: 4),
                    child: _actionItems(
                      actionText: 'Confirm', 
                      onTapAction: () async{
                        
                      }
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _actionItems({required String actionText, required VoidCallback onTapAction}) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          width: constraints.maxWidth,
          decoration: BoxDecoration(
            color: AppColors.context(context).contentBoxGreyColor,
            borderRadius: BorderRadius.circular(6)
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                onTapAction();
              },
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12),
                  child: Text(actionText, ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}