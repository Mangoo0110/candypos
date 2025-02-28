
import 'package:firebase_auth/firebase_auth.dart';

import '../../models/item_model.dart';


import 'package:hive/hive.dart';

abstract interface class ItemLocalDatasource {

  Future<void> openDb();

  Future<void> saveItems({required List<ItemModel> items});

  List<ItemModel> fetchSyncedItems();


  // Future<void> createVariant({required Variant item});

  // Future<void> updateVariant({required UpdateVariantParams updateVariantParams});

  // Future<void> deleteVariant({required String itemId});

  // Future<Either<DataCRUDFailure, List<Variant>>> fetchAllVariants();

}


class HiveItemLocalDatasource implements ItemLocalDatasource {

  Box<dynamic>? _box;

  static String? _onlyDataKey;

  static HiveItemLocalDatasource? _instance;


  HiveItemLocalDatasource._internal();

  static HiveItemLocalDatasource get instance {
    _instance ??= HiveItemLocalDatasource._internal();
    return _instance!;
  }


  @override
  Future<void> openDb() async {
    final currentAuth = FirebaseAuth.instance.currentUser;

    if(currentAuth == null) {
      throw Exception("Can not open item's local db. User is not logged in!");
    }
    String boxName = '${currentAuth.uid}@SyncedItems';
    _box ??= await Hive.openBox(boxName);
  }

  

  @override
  Future<void> saveItems({required List<ItemModel> items}) async {
    for(final item in items) {
      await _box?.put(item.id, item);
    }
  }

  @override
  List<ItemModel> fetchSyncedItems() {
    if(_box == null) return [];
    return _box!.values.map((e) => ItemModel.fromMap(e)).toList();
  }
}