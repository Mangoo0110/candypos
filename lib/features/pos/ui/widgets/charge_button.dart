

import 'package:candypos/core/utils/constants/app_sizes.dart';
import 'package:provider/provider.dart';

import '../../../../core/common/enums/common_enums.dart';
import '../../../../core/common/functions/money.dart';
import '../../../../core/utils/constants/app_colors.dart';
import 'package:flutter/material.dart';

import '../../../../the_app/providers/current_app_user_provider.dart';
import '../providers/open_cart.dart';


class ChargeButton extends StatefulWidget {


  const ChargeButton({super.key});

  @override
  State<ChargeButton> createState() => _ChargeButtonState();
}

class _ChargeButtonState extends State<ChargeButton> {

  SaveStatus saveStatus = SaveStatus.canNotSave;


  Color _buttonContainerColor() {
    return saveStatus == SaveStatus.canNotSave ?
      AppColors.context(context).contentBoxGreyColor
      :
      saveStatus == SaveStatus.failed ?
      AppColors.context(context).contentBoxGreyColor
      :
      saveStatus == SaveStatus.success ?
      Colors.greenAccent.shade400
      :
      AppColors.context(context).accentColor;
  }

  // Color _buttonBorderColor() {
  //   return saveStatus == SaveStatus.canNotSave ?
  //     AppColors.context(context).contentBoxGreyColor
  //     :
  //     saveStatus == SaveStatus.failed ?
  //     AppColors.context(context).errorColor
  //     :
  //     AppColors.context(context).accentColor;
  // }

  @override
  Widget build(BuildContext context) {
    
    double grandTotal =  context.watch<OpenedCart>().grandTotal;

    return LayoutBuilder(
      builder: (context, constraints) {
        return Material(
          color: Colors.transparent,
          child: InkWell(
            splashColor: AppColors.context(context).textColor.withOpacity(0.7),
            //borderRadius: AppSizes.smallBorderRadius,
            onTap: grandTotal <= 0
            ? null
            : () async{
              Future.delayed(const Duration(milliseconds: 350)).then((_){
                if(context.mounted) {
                  context.read<OpenedCart>().checkout(context.read<CurrentAppUserProvider>().currentAppUser!.userAuth);
                }
              });
            },
            child: AnimatedContainer(
              height: constraints.maxHeight,
              width: constraints.maxWidth,
              duration: Duration(milliseconds: 450),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("CHARGE", style: Theme.of(context).textTheme.titleMedium?.copyWith(color: AppColors.context(context).buttonTextColor),),
                  Padding(
                    padding: const EdgeInsets.only(top: 1.0),
                    child: Text(
                      "${Money().moneySymbol(context: context)}${grandTotal.toString()}", 
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(color: AppColors.context(context).buttonTextColor),
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

}

