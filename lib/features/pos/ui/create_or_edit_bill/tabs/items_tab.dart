
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../inventory/item/domain/entities/item.dart';
import '../widgets/grid_item_widget.dart';

class ItemsTab extends StatefulWidget {
  const ItemsTab({super.key});

  @override
  State<ItemsTab> createState() => _ItemsTabState();
}

class _ItemsTabState extends State<ItemsTab> {
  
  // String selectedCategoryName = 'All products';
  // String commonCategoryNameOfItem = 'All products';


  // List<Item> itemList = [];

  // List<Category> categoryList = [];

  // List<String> categoryNameList = [];


  // // functions
  
  // _populateCategoryMappedProductList() {
  //   itemList = context.watch<InventoryDataController>().itemListOfStore;
  //   categoryList = context.watch<InventoryDataController>().categoriesOfStore;
  //   categoryNameList = [];
  //   categoryNameList.add(commonCategoryNameOfItem);

  //   for(final category in categoryList) {
  //     categoryNameList.add(category.categoryName);
  //   }
  // }

  // List<ItemModel> getCategoryItems() {
  //   List<ItemModel> categoryItemList = [];
  //   for(final item in itemList) {
  //     if(item.categoryIdMapName.containsValue(selectedCategoryName) || selectedCategoryName == commonCategoryNameOfItem){
  //       categoryItemList.add(item);
  //     }
  //   }
  //   return categoryItemList;
  // }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //_populateCategoryMappedProductList();

    return LayoutBuilder(
      builder: (context, constraints) {
        return Container();
        // return Column(
        //   mainAxisSize: MainAxisSize.min,
        //   children: [
        //     SizedBox(
              
        //       child: ItemSearchBar(
        //         categoryList: categoryNameList, 
        //         onCategorySelect: (String categoryName) { 
              
        //          }, 
        //         onSearchSelect: (ItemModel searchMatchedItem) { 
              
        //          },
        //       ),
        //     ),
        //     Flexible(
        //       child: Padding(
        //         padding: const EdgeInsets.only(top: 6),
        //         child: _categoryProducts(categoryName: selectedCategoryName, itemList: getCategoryItems(), constraints: constraints),
        //       ),
        //     )
        //   ],
        // );
      },
    );
  }


  

  // Widget _categoryProducts({required String categoryName, required List<ItemModel> itemList, required BoxConstraints constraints,}) {
  //   return LayoutBuilder(
  //     builder: (context, constraints) {
  //       if(itemList.isEmpty) {
  //         return Center(
  //           child: Text('0 products', style: AppTextStyle().greyBoldNormalSize(context: context),),
  //         );
  //       }
  //       return SizedBox(
  //         height: constraints.maxHeight,
  //         width: constraints.maxWidth,
  //         child: GridView.builder(
  //           itemCount: itemList.length,
  //           gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
  //             maxCrossAxisExtent: 175,
  //             childAspectRatio: 4 / 5,
  //             crossAxisSpacing: 4,
  //             mainAxisSpacing: 4,
  //           ), 
  //           itemBuilder:(context, index) {
  //             return GridItemWidget(item: itemList[index],);
  //           },
  //         ),
  //       );
  //     }
  //   );
  // }

}