
import 'package:candypos/core/utils/constants/app_colors.dart';
import 'package:candypos/core/utils/func/dekhao.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:popover/popover.dart';
import 'package:provider/provider.dart';

import '../../../../core/common/enums/common_enums.dart';
import '../providers/open_cart.dart';

class ChangeBilltypeActionPopup extends StatefulWidget {
  const ChangeBilltypeActionPopup({super.key});

  @override
  State<ChangeBilltypeActionPopup> createState() => _ChangeBilltypeActionPopupState();
}

class _ChangeBilltypeActionPopupState extends State<ChangeBilltypeActionPopup> with TickerProviderStateMixin{

  late AnimationController _animationController ;

  ServiceType currentCartBillType = ServiceType.walkIn;

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

  // IconData getBillTypeIcon(){
  //   switch (currentCartBillType) {
  //     case ServiceType.delivery:
  //       return Icons.delivery_dining;
        
  //     case ServiceType.inStore:
  //       return Icons.storefront_outlined;

  //     case ServiceType.walkIn:
  //       return Icons.run_circle;
  //   }
  // }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    context.read<OpenedCart>().addListener(() {
      if(currentCartBillType != context.read<OpenedCart>().serviceType){
        setState(() {
        
        });
      }
      
    });
    
    super.didChangeDependencies();
  }


  @override
  Widget build(BuildContext context) {
    currentCartBillType = context.read<OpenedCart>().serviceType;
    dekhao(currentCartBillType.name);
    _animationController.reset();
    _animationController.forward();
    
    return AnimatedContainer(
      duration: Duration(milliseconds: 700),
      child: IconButton(
        tooltip: 'Bill type',
        onPressed: () async{
          await showPopover(
            arrowDxOffset: 0,
            arrowWidth: 16,
            arrowHeight: 8,
            //height: 180,
            //width: constraints.maxWidth * .7,
            context: context, 
            bodyBuilder:(context) {
              return _BillTypeSelectPopUp(
                onChange: (billType) {
                  context.read<OpenedCart>().serviceType = billType;
                },
              );
            },);
        },
        icon: Icon(context.read<OpenedCart>().serviceType.icon, size: 30, color: AppColors.context(context).buttonTextColor,)
      )
      .animate(controller: _animationController,).slideY(begin: -1, end: 0, duration: const Duration(milliseconds: 300), curve: Curves.easeIn),
    );
  }
  
}


class _BillTypeSelectPopUp extends StatefulWidget {
  final void Function(ServiceType billType) onChange;
  const _BillTypeSelectPopUp({super.key, required this.onChange});

  @override
  State<_BillTypeSelectPopUp> createState() => __BillTypeSelectPopUpState();
}

class __BillTypeSelectPopUpState extends State<_BillTypeSelectPopUp> with TickerProviderStateMixin{

  @override
  void initState() {
    // TODO: implement initState
    _billType = context.read<OpenedCart>().serviceType;
    super.initState();
  }

  void _changeState(ServiceType billType) {

    widget.onChange(billType);

    setState(() {
      
    });

    Future.delayed(Duration(milliseconds: 700)).then((_){
      if(mounted) Navigator.pop(context);
    });

    
  }

  late ServiceType _billType;


  @override
  Widget build(BuildContext context) {
    _billType = context.read<OpenedCart>().serviceType;

    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          //height: 200,
          width: constraints.maxWidth * .6 ,
          decoration: BoxDecoration(
            color: AppColors.context(context).backgroundColor,
            borderRadius: BorderRadius.circular(4)
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Select Bill Type', style: Theme.of(context).textTheme.labelLarge,),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: ServiceType.values.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: _actionItems(
                          billType: ServiceType.values[index],
                        ),
                    );
                  },
                  
                ),
              ],
            ),
          ),
        );
      },
    );
  }


  Widget _actionItems({required ServiceType billType}) {

    bool isTheCurrentType = false;
    dekhao("billType: ${billType.name} && _billType: ${_billType.name}");
    if(_billType == billType){
      isTheCurrentType = true;
    }

    final contentColor = isTheCurrentType ? AppColors.context(context).contentBoxColor : AppColors.context(context).textColor;

    return LayoutBuilder(
      builder: (context, constraints) {
        return AnimatedContainer(
          duration: Duration(milliseconds: 550),
          width: constraints.maxWidth,
          decoration: BoxDecoration(
            color: isTheCurrentType ? AppColors.context(context).textColor : AppColors.context(context).contentBoxGreyColor,
            borderRadius: BorderRadius.circular(6)
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                _changeState(billType);
              },
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12),
                  child: Row(
                    children: [
                      Icon(billType.icon, color: contentColor,),
                      Padding(
                        padding: const EdgeInsets.only(left: 12.0),
                        child: Text(billType.name, style: Theme.of(context).textTheme.labelLarge?.copyWith(color: contentColor)),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
  
  
}