
import 'dart:collection';
import 'dart:typed_data';

import 'package:candypos/core/utils/constants/app_colors.dart';
import 'package:candypos/core/utils/constants/app_sizes.dart';
import 'package:candypos/core/utils/func/dekhao.dart';
import 'package:candypos/the_app/providers/inventory_data_provider.dart';
import 'package:candypos/the_app/providers/pos_helpers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/common/functions/money.dart';
import '../../features/inventory/item/domain/entities/item.dart';
import '../../features/pos/ui/create_or_edit_bill/widgets/item_search_bar_widget.dart';
import '../../features/pos/ui/providers/open_cart.dart';


class PosItemsGrid extends StatefulWidget {
  const PosItemsGrid({super.key});

  @override
  State<PosItemsGrid> createState() => _PosItemsGridState();
}

class _PosItemsGridState extends State<PosItemsGrid> {
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  SplayTreeMap<String, Widget> gridWidgets = SplayTreeMap();
  double maxCrossAxisExtent = 160;
  double childAspectRatio = 4 / 5;
  double crossAxisSpacing = 6;
  double mainAxisSpacing = 6;


  @override
  Widget build(BuildContext context) {
    

    return ListenableBuilder(
      listenable: context.read<InventoryDataProvider>().itemData,
      builder: (context, child) {

        return LayoutBuilder(
          builder: (context, constraints) {
            //return Container();
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
        
                SizedBox(
                  child: ItemSearchBar(),
                ),
                _UpdatingIndicator(),
                
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 6),
                    child: _categoryProducts(),
                  ),
                )
              ],
            );
          },
        );
      }
    );
  }


  

  Widget _categoryProducts() {
    return LayoutBuilder(
      builder: (context, constraints) {
        if(context.read<InventoryDataProvider>().itemData.inventoryItems.isEmpty) {
          return Center(
            child: Text('0 products', style: Theme.of(context).textTheme.labelLarge,),
          );
        }
        return SizedBox(
          height: constraints.maxHeight,
          width: constraints.maxWidth - 10,
          child: GridView.builder(
            itemCount: context.read<InventoryDataProvider>().itemData.inventoryItems.length,
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: maxCrossAxisExtent,
              childAspectRatio: childAspectRatio,
              crossAxisSpacing: crossAxisSpacing,
              mainAxisSpacing: mainAxisSpacing,
            ), 
            itemBuilder:(context, index) {
              Item item = context.read<InventoryDataProvider>().itemData.inventoryItems[index];
              Uint8List? itemImage  = context.read<InventoryDataProvider>().itemImageData.images[item.id];
              
              return _gridTile(item, itemImage);
            },
          ),
        );
      }
    );
  }

  Widget _gridTile(Item item, Uint8List? itemImage ) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double boxWidth = constraints.maxWidth;
        double boxHeight = constraints.maxHeight;
        final double bottomTextHeight = 40;
        final imageHeight = boxHeight - bottomTextHeight;

        return Container(
          height: boxHeight,
          width: boxWidth,
          decoration: BoxDecoration(
            borderRadius: AppSizes.verySmallBorderRadius,
            color: AppColors.context(context).contentBoxGreyColor,
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              splashColor: AppColors.context(context).textColor,
              borderRadius: AppSizes.smallBorderRadius,
              onTap: () {
                if(item.variants.isEmpty && item.baseVariant.unitDetails.weightItem == false) {
                  dekhao("Calling adding method to add item to cart");
                  context.read<OpenedCart>().addItem(
                    saleItem: item.baseVariant.toSaleItem(addOns: [], quantity: 1)
                  );
                } else {
                  dekhao("Can't call adding method to add item to cart");
                }
                
              },
              child: itemImage != null 
                ? Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    
                    SizedBox(
                      height: imageHeight - 6,
                      width: boxWidth - 6,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          if(itemImage != null) Image.memory(
                            fit: BoxFit.cover,
                            itemImage,
                            height: imageHeight - 2,
                            width: boxWidth - 2,
                          ),

                          Positioned(
                            top: 2,
                            right: 1,
                            child: Container(
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(color: Colors.white.withAlpha(190), blurRadius: 2, spreadRadius: 1)
                                ]
                              ),
                              child: Text(
                                "${Money().moneySymbol(context: context)}${item.baseVariant.price.toString()}",
                                style: Theme.of(context).textTheme.titleMedium?.copyWith(color: AppColors.context(context).accentColor
                              ),),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Icon(Icons.image, size: min(constraints.maxHeight / 2, constraints.maxWidth), color: AppColors.context(context).contentBoxGreyColor,),
              
                    SizedBox(
                      height: bottomTextHeight,
                      child: Center(child: Text(item.itemName, style: Theme.of(context).textTheme.labelLarge,)),
                    )
                  ],
                )
                : Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(child: Text(item.itemName, style: Theme.of(context).textTheme.labelLarge,)),
                    Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(color: Colors.white.withAlpha(190), blurRadius: 2, spreadRadius: 1)
                        ]
                      ),
                      child: Text(
                        "${Money().moneySymbol(context: context)}${item.baseVariant.price.toString()}",
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(color: AppColors.context(context).accentColor
                      ),),
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


// class _ItemGridWidget extends StatefulWidget {
//   final Item item;
//   final double height;
//   final double width;
//   const _ItemGridWidget({super.key, required this.item, required this.height, required this.width});

//   @override
//   State<_ItemGridWidget> createState() => _ItemGridWidgetState();
// }

// class _ItemGridWidgetState extends State<_ItemGridWidget> {

//   late Item item;
//   Uint8List? itemImage;

//   @override
//   void initState() {
//     // TODO: implement initState
//     item = widget.item;
//     itemImage = context.read<InventoryDataProvider>().itemImageData.images[widget.item.id];

//     super.initState();
//   }

//   @override
//   void didChangeDependencies() {
//     // TODO: implement didChangeDependencies

//     // Listen to item image changes
//      dekhao("listening to item image changes");
//     if(context.mounted) {
//       dekhao("listening to item image changes... context(widget) is mounted");
//       context.read<InventoryDataProvider>().itemImageData.addListener(() {
//         dekhao("Item image changed");
//         if(mounted && context.read<InventoryDataProvider>().itemImageData.images[widget.item.id] != itemImage) {
//           itemImage = context.read<InventoryDataProvider>().itemImageData.images[widget.item.id];
//           setState(() {
            
//           });
//         }
//       });
//     }


//     super.didChangeDependencies();
//   }


//   @override
//   Widget build(BuildContext context) {
//     return LayoutBuilder(
//       builder: (context, constraints) {
//         final double bottomTextHeight = 40;
//         final imageHeight = constraints.maxHeight - bottomTextHeight;
        
//       },
//     );
  
//   }
// }


class _UpdatingIndicator extends StatefulWidget {
  const _UpdatingIndicator({super.key});

  @override
  State<_UpdatingIndicator> createState() => _UpdatingIndicatorState();
}

class _UpdatingIndicatorState extends State<_UpdatingIndicator> {


  @override
  void initState() {
    context.read<InventoryDataProvider>().addListener(() {
      if(context.mounted && context.read<InventoryDataProvider>().isUpdating == true) {
        setState(() {
          
        });
      }
    });
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return context.read<InventoryDataProvider>().isUpdating == true
      ? SizedBox(
        width: constraints.maxWidth,
        child: LinearProgressIndicator(
          backgroundColor: Colors.black,
          minHeight: 4,
          color: AppColors.context(context).accentColor,
        ),
      )
      : Container();
    });
  }
}