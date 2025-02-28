import 'dart:async';
import 'dart:collection';
import 'dart:typed_data';

import 'package:candypos/core/usecases/usecases.dart';
import 'package:candypos/core/utils/func/dekhao.dart';
import 'package:candypos/init_dependency.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';

import '../../features/image/domain/usecases/fetch_image.dart';
import '../../features/inventory/category/domain/entities/category.dart';
import '../../features/inventory/item/domain/entities/item.dart';
import '../../features/inventory/item/domain/usecases/fetch_synced_items.dart';

class ItemData extends ChangeNotifier{
  final SplayTreeMap<String, Item> _inventoryItems = SplayTreeMap<String, Item>();
  List<Item> get inventoryItems => _inventoryItems.entries.map((e) => e.value.copyWith()).toList();

  static ItemData? _instance;
  static ItemData get instance{
    _instance ??= ItemData._();
    return _instance!;
  }

  ItemData._();

  void update(List<Item> items) {
    for(final item in items) {
      _inventoryItems[item.id] = item;
    }
    notifyListeners();
  }
}

class ItemImageData extends ChangeNotifier{
  final SplayTreeMap<String, Uint8List> _itemImages = SplayTreeMap<String, Uint8List>();
  SplayTreeMap<String, Uint8List> get images => SplayTreeMap<String, Uint8List>.from(_itemImages);

  static ItemImageData? _instance;
  static ItemImageData get instance{
    _instance ??= ItemImageData._();
    return _instance!;
  }

  ItemImageData._();

  void updateItemImage({required Map<String, Uint8List> newImages}) {
    _itemImages.addAll(newImages);
    notifyListeners();
  }
}

class CategoryData extends ChangeNotifier{
  final SplayTreeMap<String, ItemCategory> _categories = SplayTreeMap<String, ItemCategory>();
  SplayTreeMap<String, ItemCategory> get categories => SplayTreeMap<String, ItemCategory>.from(_categories);

  static CategoryData? _instance;
  static CategoryData get instance{
    _instance ??= CategoryData._();
    return _instance!;
  }

  CategoryData._();

  void update(List<ItemCategory> categories) {
    for(final category in categories) {
      _categories[category.id] = category;
    }
    notifyListeners();
  }
}

class CategoryImageData extends ChangeNotifier{
  final SplayTreeMap<String, Uint8List> _images = SplayTreeMap<String, Uint8List>();
  SplayTreeMap<String, Uint8List> get images => SplayTreeMap<String, Uint8List>.from(_images);

  static CategoryImageData? _instance;
  static CategoryImageData get instance{
    _instance ??= CategoryImageData._();
    return _instance!;
  }

  CategoryImageData._();

  void updateImages({required Map<String, Uint8List> newImages}) {
    _images.addAll(newImages);
    notifyListeners();
  }
}



class InventoryDataProvider extends ChangeNotifier{

  bool _isUpdating = false;
  bool get isUpdating => _isUpdating;

  StreamSubscription<List<Item>>? itemSubscription;

  final ItemData itemData = ItemData.instance;

  final ItemImageData itemImageData = ItemImageData.instance;

  final CategoryData categoryData = CategoryData.instance;

  final CategoryImageData categoryImageData = CategoryImageData.instance;

  InventoryDataProvider._();

  

  static InventoryDataProvider? _instance;

  static InventoryDataProvider get instance{
    _instance ??= InventoryDataProvider._();
    return _instance!;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    if(itemSubscription != null) {
      itemSubscription?.cancel();
    }
    super.dispose();
  }
  

  Future<void> init() async{
    _inventoryItemsStream();
  }

  _inventoryItemsStream() {

    serviceLocator<FetchItems>().call(NoParams()).fold(
      (l){}, 
      (r) {
        itemSubscription = r.listen(
          (items) async{
            _isUpdating = true; notifyListeners();
            final Map<String, Uint8List> images = {};
            for(final item in items) {
              final image = await getItemImage(storageRef: item.imageUrl, itemId: item.id);
              if(image != null) {
                images[item.id] = image;
              }
            }
            // First update the images
            itemImageData.updateItemImage(newImages: images);
            // Then update the items
            itemData.update(items);
            _isUpdating = false; notifyListeners();
          }
        );
        
      });
  }


  Future<Uint8List?> getItemImage({required Reference storageRef, required String itemId}) async{
    return await serviceLocator<FetchImage>().call(FetchImageParams(storageRef: storageRef)).then((result) {
      return result.fold(
        (l){
          return null;
        }, (r){
          return r.image;
        });
    });
  }

  /// Update the item image
  /// Called when only the image of the item is updated.
  updateItemImage({required String itemId, required Reference ref, required Uint8List image}) {
    if(itemData._inventoryItems.containsKey(itemId) && itemData._inventoryItems[itemId]!.imageUrl == ref){
      itemImageData._itemImages[itemId] = image; notifyListeners();
    }
  }

  // Uint8List? itemImage({required String itemId}) {
  //   return itemImageData._itemImages[itemId];
  // }

}