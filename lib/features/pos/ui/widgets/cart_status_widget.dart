import 'package:candypos/core/utils/func/dekhao.dart';

import 'charge_button.dart';
import 'hold_bill_action_popup.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/utils/constants/app_colors.dart';
import 'package:flutter/cupertino.dart';

import '../providers/open_cart.dart';
import 'change_billtype_action_popup.dart';

class CartStatusWidget extends StatefulWidget {
  const CartStatusWidget({super.key});

  @override
  State<CartStatusWidget> createState() => _CartStatusWidgetState();
}

class _CartStatusWidgetState extends State<CartStatusWidget> {

  late OpenedCart cartProvider;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  int cnt = 0;

  double boxHeight = 75;
  
  @override
  Widget build(BuildContext context) {
    dekhao("rebuilding cart status widget ${cnt++}");
    return LayoutBuilder(
      builder: (context, constraints) {
        return Stack(
          
          children: [
            _BackGroundTile(
              height: boxHeight,
              width: constraints.maxWidth,
            ),
            Table(
              columnWidths: {0: FlexColumnWidth(.5), 1: FlexColumnWidth(.5)},
              border: TableBorder(
                verticalInside: BorderSide(
                  color: AppColors.context(context).buttonTextColor
                )
              ),
              children: [
                TableRow(
                  //crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    
                    SizedBox(
                      height: boxHeight,
                      width: constraints.maxWidth,
                      child: Center(child: ChargeButton()),
                    ),
                    //Container(),
                    
                    SizedBox(
                      height: boxHeight,
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const ChangeBilltypeActionPopup(),
                            HoldBillActionPopup()
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        );
      },
    );
  }

}

class _BackGroundTile extends StatefulWidget {
  final double height;
  final double width;
  const _BackGroundTile({required this.height, required this.width});

  @override
  State<_BackGroundTile> createState() => __BackGroundTileState();
}

class __BackGroundTileState extends State<_BackGroundTile> {
  @override
  Widget build(BuildContext context) {
    final grandTotal = context.watch<OpenedCart>().grandTotal;
    return AnimatedContainer(
      duration: Duration(milliseconds: 500),
      curve: Curves.fastLinearToSlowEaseIn,
      height: widget.height,
      width: widget.width,
      decoration: BoxDecoration(
        color: grandTotal > 0
        ? AppColors.context(context).accentColor
        : AppColors.context(context).textGreyColor,
        //borderRadius: AppSizes.smallBorderRadius
      ),
    );
  }
}