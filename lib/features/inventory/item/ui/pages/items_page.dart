import 'dart:collection';
import 'dart:math';
import 'dart:typed_data';

import 'package:candypos/core/common/functions/money.dart';
import 'package:candypos/core/utils/constants/app_sizes.dart';
import 'package:candypos/the_app/providers/inventory_data_provider.dart';

import '../../../../../core/utils/constants/app_colors.dart';
import '../../../../../core/utils/func/dekhao.dart';
import '../../../../../core/utils/routing/smooth_page_transition.dart';
import 'edit_item_ui.dart';
import 'package:flutter/material.dart';
import '../../domain/entities/item.dart';


class ItemsPage extends StatefulWidget {
  
  const ItemsPage({super.key});

  @override
  State<ItemsPage> createState() => _ItemsPageState();
}

class _ItemsPageState extends State<ItemsPage> {



  void _navigateToCreateItemPage() {
    // Navigate to create item page
    Navigator.push(context, SmoothPageTransition().rightToLeft(
      secondScreen: EditItemUi()
    ));
  }

  void _navigateToEditItemPage(Item item) {
    // Navigate to edit item page with the selected item
    Navigator.push(context, SmoothPageTransition().rightToLeft(
      secondScreen: EditItemUi(
        itemImage: ItemImageData.instance.images[item.id],
        modifyingItem: item,
    )));
  }


  @override
  Widget build(BuildContext context) {

    return ListenableBuilder(
      listenable: ItemData.instance,
      builder: (context, child) {

        return LayoutBuilder(
          builder: (context, constraints) {
            double createButtonHeight = 60;
            double createButtonWidth = min((constraints.maxWidth - 50), 400);
            return Scaffold(
              appBar: AppBar(
                title: Text('Items', style: Theme.of(context).textTheme.titleLarge,),
              ),
              body: Stack(
                children: [
                  ListView.builder(
                    itemCount: ItemData.instance.inventoryItems.length,
                    itemBuilder: (context, index) {
                      
                      final item = ItemData.instance.inventoryItems[index];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: _ItemListTileWidget(
                          key: UniqueKey(),
                          onTap: () => _navigateToEditItemPage(item), 
                          item: item,
                        )
                      );
                    },
                  ),
            
                  Positioned(
                    bottom: 8,
                    left: (constraints.maxWidth - createButtonWidth) / 2,
                    child: Container(
                      height: createButtonHeight,
                      width: createButtonWidth,
                      decoration: BoxDecoration(
                        color: AppColors.context(context).accentColor,
                        borderRadius: AppSizes.smallBorderRadius
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: AppSizes.smallBorderRadius,
                          splashColor: AppColors.context(context).textColor,
                          onTap: () async{
                            await Future.delayed(Duration(milliseconds: 500)).then((value) {
                              _navigateToCreateItemPage();
                            },);
                            
                          },
                          child: Center(child: Text("Create item", style: Theme.of(context).textTheme.titleMedium?.copyWith(color: AppColors.context(context).buttonTextColor),)),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            );
          }
        );
      }
    );
  }
}


class _ItemListTileWidget extends StatefulWidget {
  final VoidCallback onTap;
  final Item item;
  const _ItemListTileWidget({required super.key, required this.onTap, required this.item});

  @override
  State<_ItemListTileWidget> createState() => __ItemListTileWidgetState();
}

class __ItemListTileWidgetState extends State<_ItemListTileWidget> {

  Uint8List? image;

  @override
  void initState() {
    image = ItemImageData.instance.images[widget.item.id];
    ItemImageData.instance.addListener((){
      if(ItemImageData.instance.images[widget.item.id] != image) {
        image = ItemImageData.instance.images[widget.item.id];
        setState(() {});
      }
    });
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder( 
      builder: (context, constraints) {

        double tileHeight = 80;
        double tilewidth = 80;
        final item = widget.item;
        return Container(
          decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: AppColors.context(context).contentBoxGreyColor))
          ),
          child: InkWell(
            splashColor: AppColors.context(context).textColor,
            onTap: () {
              widget.onTap();
            },
            child: Padding(
              padding: const EdgeInsets.only(bottom: 8.0, left: 4, right: 4),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      image != null 
                      ? Image.memory(
                        height: tileHeight - 10,
                        width: tilewidth - 10,
                        image!,
                        fit: BoxFit.cover,
                      )
                      : Icon(Icons.image, size: tileHeight -20, color: AppColors.context(context).contentBoxGreyColor,),
                  
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Text(item.itemName, style: Theme.of(context).textTheme.labelLarge,),
                      ),
                    ],
                  ),
                  Text(
                    item.variants.length > 1 
                    ? "${item.variants.length} prices"
                    : item.baseVariant.price == 0
                    ? "Variable price"
                    : "${Money().moneySymbol(context: context)} ${item.baseVariant.price}",
                    style: Theme.of(context).textTheme.labelLarge
                  )
                ],
              ),
            ),
          )
          
        );
      },
    );
  }
}

