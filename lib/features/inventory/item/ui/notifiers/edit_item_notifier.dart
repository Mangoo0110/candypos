import 'dart:typed_data';

import 'package:candypos/core/common/enums/common_enums.dart';
import 'package:candypos/core/utils/func/dekhao.dart';
import 'package:candypos/features/inventory/item/ui/notifiers/edit_variant_notifier.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../../../core/utils/uuid_service/firebase_uid.dart';

import '../../../../../core/common/domains/upload_meta.dart';
import '../../../../../core/common/notifiers/save_status_provider.dart';
import 'package:flutter/cupertino.dart';

import '../../../../../init_dependency.dart';
import '../../../../../the_app/providers/inventory_data_provider.dart';
import '../../../../auth/domain/entities/user_auth.dart';
import '../../../unit/domain/entities/unit.dart';
import '../../domain/entities/item.dart';
import '../../domain/usecases/create_item.dart';
import '../../domain/usecases/update_item.dart';

class EditItemNotifier extends ChangeNotifier {
  final Key _key = UniqueKey();

  late SaveStatusNotifier saveStatusNotifier;

  late final Item _item;
  final Item? _existingItem;

  final UserAuth _userAuth;

  Uint8List? _itemImage;
  Uint8List? get itemImage => _itemImage;
  set itemImage(Uint8List? newImage) {
    _itemImage = newImage; 
    _checkIfCanSave(); notifyListeners();
  }


  late String _itemName;
  String get itemName => _itemName;
  set itemName(String value) {
    _itemName = value;

    // Also set variant's itemName attribute with the same value.
    _baseVariant.variantName = _itemName;

    for (final entry in _variants.entries) {
      entry.value.itemName = value;
    }
    
    _checkIfCanSave(); notifyListeners();
  }

  late String _description;
  String get description => _description;
  set description(String value) {
    _description = value;
    _checkIfCanSave(); notifyListeners();
  }

  late EditVariantProvider _baseVariant;
  EditVariantProvider get baseVariant => _baseVariant;
  

  late Map<String, EditVariantProvider> _variants;
  Map<String, EditVariantProvider> get variants => _variants;

  late bool? _visibleOnline;
  bool? get visibleOnline => _visibleOnline;
  set visibleOnline(bool? value) {
    _visibleOnline = value;
    _checkIfCanSave(); notifyListeners();
  }

  late Unit _unit;
  Unit get unit => _unit;
  set unit(Unit value) {
    _unit = value;
    _baseVariant.unit = value;
    for (final entry in _variants.entries) {
      entry.value.unit = value;
    }
    _checkIfCanSave();
    notifyListeners();
  }

  //late Set<String> modifierGroupMap;
  // Set<String> get getModifierGroupMap => modifierGroupMap;
  // set setModifierGroupMap(Set<String> value) {
  //   modifierGroupMap = value;
  //   _checkIfCanSave(); notifyListeners();
  // }

  late Map<String, String> categoryIdMapName;
  // Getters and Setters with notifyListeners

  Map<String, String> get getCategoryIdMapName => categoryIdMapName;
  set setCategoryIdMapName(Map<String, String> value) {
    categoryIdMapName = value;
    _checkIfCanSave(); notifyListeners();
  }

  EditItemNotifier(this._existingItem, this._userAuth) {
    saveStatusNotifier = SaveStatusNotifier(_key);

    if (_existingItem == null) {
      final String itemId = uuidByFirebaseSdk();
      // item's unit and variant's unit need to be simmilar
      final newItemUnit = Unit.pcs();
      _item = Item(
          id: itemId,
          itemName: "",
          description: "",
          imageUrl: null,
          baseVariant: Variant.newItemVariant(
              itemId: itemId,
              itemName: "",
              variantId: uuidByFirebaseSdk(),
              variantName: "Regular",
              unit: newItemUnit),
          variants: {},
          categoryIdMapName: {},
          visibleOnline: null,
          uploadDetails: UploadMeta.newInstance(auth: _userAuth),
          index: DateTime.now().millisecondsSinceEpoch,
          unitDetails: newItemUnit,
          deleted: null);
    } else {
      _item = _existingItem;
    }
    _itemName = _item.itemName;
    _description = _item.description;
    _baseVariant = EditVariantProvider(_item.baseVariant);
    _variants = _item.variants.map((k, v) => MapEntry(k, EditVariantProvider(v)));
    _visibleOnline = _item.visibleOnline;
    categoryIdMapName = _item.categoryIdMapName;
    _unit = _item.unitDetails;

    listenVariantsModification();
  }
  

  @override
  void dispose() {
    // TODO: implement dispose
    baseVariant.dispose();

    for(final entry in _variants.entries) {
      entry.value.dispose();
    }
    super.dispose();
  }


  listenVariantsModification() {
    baseVariant.saveStatusNotifier.addListener((){
      _checkIfCanSave();
    });
  }

  void _checkIfCanSave() {

    if(_existingItem != null && (_itemImage != null || _variantsNeedSave())) {
      if(saveStatusNotifier.saveStatus != SaveStatus.canSave){
        saveStatusNotifier.setSaveStatus(_key, SaveStatus.canSave);
      }
      return;
    }

    if(_itemName.isNotEmpty) {
      if(saveStatusNotifier.saveStatus != SaveStatus.canSave){
        saveStatusNotifier.setSaveStatus(_key, SaveStatus.canSave);
      }
    } else {
      if(saveStatusNotifier.saveStatus != SaveStatus.canNotSave){
        saveStatusNotifier.setSaveStatus(_key, SaveStatus.canNotSave);
      }
    }
  }

  bool _variantsNeedSave() {
    bool isYes = baseVariant.saveStatusNotifier.saveStatus == SaveStatus.canSave;
    for(final entry in _variants.entries) {
      isYes &= entry.value.saveStatusNotifier.saveStatus == SaveStatus.canSave;
    }
    return isYes;
  }

  Future<void> save(UserAuth auth) async {
    
    final modifiedItem = _item.copyWith(
      itemName: _itemName,
      description: _description,
      unitDetails: _unit,
      baseVariant: _baseVariant.modifiedVariant(),
      variants: _variants.map((k, v) => MapEntry(k, v.modifiedVariant())),
      visibleOnline: _visibleOnline,
      uploadDetails: _item.uploadDetails.copyWith(lastUpdatedBy: auth.id,),
    );

    if(_existingItem == null) {
      await _create(modifiedItem);
    } else {
      dekhao("updating item and existing item is equal? ${_existingItem == modifiedItem}");
      if(_existingItem != modifiedItem) {

        await _update(modifiedItem);
      } else {
        
        await _update(null);
      }
    }
  }

  Future<void> _create(Item item) async {

    _checkIfCanSave();
    if(saveStatusNotifier.saveStatus != SaveStatus.canSave) return;

    saveStatusNotifier.setSaveStatus(_key, SaveStatus.saving); 
    // Future.delayed(Duration(milliseconds: 900)).then((_) async{
    //   saveStatusNotifier.setSaveStatus(_key, SaveStatus.success);
    // }).then((_){
    //   Future.delayed(Duration(milliseconds: 900)).then((_) async{
    //     saveStatusNotifier.setSaveStatus(_key, SaveStatus.canSave);
    //   });
    // });
    return await serviceLocator<CreateItem>().call(CreateItemParams (item: item, image: _itemImage)).then((result){
      return result.fold((l){

        saveStatusNotifier.setSaveStatus(_key, SaveStatus.failed);
        Fluttertoast.showToast(msg: "Failed to create the item!!");
        Future.delayed(Duration(milliseconds: 900)).then((_) async{
            saveStatusNotifier.setSaveStatus(_key, SaveStatus.canNotSave);
        });
      }, (r){

        saveStatusNotifier.setSaveStatus(_key, SaveStatus.success);
        Fluttertoast.showToast(msg: "Done. Item created.");
      });
    });


  }

  Future<void> _update(Item? item) async {
    _checkIfCanSave();

    if(item == null && _itemImage == null) return;
    if(saveStatusNotifier.saveStatus != SaveStatus.canSave) return;

    saveStatusNotifier.setSaveStatus(_key, SaveStatus.saving);

    return await serviceLocator<UpdateItem>().call(UpdateItemParams(item: item, image: _itemImage, reference: _item.imageUrl)).then((result){
      return result.fold((l){
        saveStatusNotifier.setSaveStatus(_key, SaveStatus.failed);
        Fluttertoast.showToast(msg: "Failed to create the item!!");
        Future.delayed(Duration(milliseconds: 900)).then((_) async{
            saveStatusNotifier.setSaveStatus(_key, SaveStatus.canNotSave);
        });

      }, (r){

        if(_itemImage != null) InventoryDataProvider.instance.updateItemImage(itemId: _item.id, ref: _item.imageUrl, image: _itemImage!);
        saveStatusNotifier.setSaveStatus(_key, SaveStatus.success);
        Fluttertoast.showToast(msg: "Done. Item updated.");
      });
    });
  }
}
